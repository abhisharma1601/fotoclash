import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Models/databse.dart';
import 'package:fotoclash/Screens/Chats/new_message.dart';
import 'package:fotoclash/main.dart';
import 'package:uuid/uuid.dart';
import '../Profile/profile_user.dart';

class Messages extends StatefulWidget {
  String chatRoomId;
  String userName;
  String image;
  int index;
  Messages(
    this.chatRoomId,
    this.userName,
    this.image, 
    this.index,
    {
    Key? key,
  }) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Stream<QuerySnapshot>? chatMessageStream;
  @override
  void initState() {
    DataBase().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  String? ID;
  @override
  void setState(VoidCallback fn) {
    const uuid = Uuid();
    ID = uuid.v1().substring(0, 15);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.chatRoomId);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("background.png"), fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 100 / 375,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => UserProfile(widget.userName,widget.index)));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(widget.image),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.userName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: chatMessageStream,
                      builder: (ctx, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.requireData.size,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: app_user.username ==
                                            snapshot.requireData.docs[index]
                                                ["userName"]
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: app_user.username ==
                                                      snapshot.requireData.docs[index]
                                                          ["userName"]
                                                  ? Colors.blueGrey[900]
                                                  : Colors.grey[600],
                                              borderRadius: app_user.username ==
                                                      snapshot.requireData.docs[index]
                                                          ["userName"]
                                                  ? const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20))
                                                  : const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      topRight: Radius.circular(20))),
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20 * 0.85,
                                              vertical: 10),
                                          child: LimitedBox(
                                            maxHeight: 1000,
                                            maxWidth: 250,
                                            child: Text(
                                              snapshot.requireData.docs[index]
                                                  .get("message"),
                                              maxLines: 1000,
                                              textAlign: app_user.username ==
                                                      snapshot.requireData.docs[index]
                                                          ["userName"]
                                                  ? TextAlign.end:TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            : Container();
                      })),
              NewMessages(widget.chatRoomId)
            ],
          )
        ],
      ),
    );
  }
}
