import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Models/databse.dart';
import 'package:fotoclash/Screens/Chats/messages.dart';
import 'package:fotoclash/main.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  const SearchInput(
      {required this.textController, required this.hintText, Key? key})
      : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  DataBase dataBase = DataBase();
  Stream? chatRoomsStream;
  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.requireData.size,
                itemBuilder: (context, index) {
                  return ChatTile(
                      snapshot.requireData.docs[index]
                          .get("chatRoomId")
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(app_user.username, ""),
                      snapshot.requireData.docs[index]
                          .get("chatRoomId")
                          .toString(),
                      snapshot.requireData.docs[index]["image"],
                      index);
                },
              )
            : Container(
               color: Colors.transparent,
                child: Center(
                    child: Text(
                  "First start chats",
                  style: TextStyle(color: Colors.white),
                )),
              );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    dataBase.getUserChats(app_user.username).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
  }

  DataBase dataBaseMethods = DataBase();
  TextEditingController search = TextEditingController();
  QuerySnapshot? searchSnapshot;
  initSearch() {
    dataBaseMethods.getUserByUserName(search.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot?.docs.length,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapshot?.docs[index].get("userName"),
                image: searchSnapshot?.docs[index].get("imageUrl"),
              );
            },
          )
        : Container(child: chatRoomList());
  }

  Widget searchTile({String? userName, String? image}) {
    return GestureDetector(
        onTap: () {
          createChatRoom(userName!, image!);
        },
        child: Container(
          child: ListTile(
            title: Text(
              userName!,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(image!),
            ),
          ),
        ));
  }

  createChatRoom(String userName, String image) {
    if (userName != app_user.username) {
      List<String> users = [userName, app_user.username];
      List<String> images = [image, app_user.photo];
      String chatRoomId = getChatRoomId(userName, app_user.username);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
        "image": images
      };
      dataBaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Messages(chatRoomId, search.text,
                app_user.photo == image[0] ? image[1] : image[0], 0),
          ));
    } else {
      SnackBar(
          content: Text(
              "Cannot Search Your Own Name Or that user is not available"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            controller: search,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  initSearch();
                },
                child: Icon(
                  Icons.search,
                  color: Colors.grey[500]!,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFF263238),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w400),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: searchList())
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

class ChatTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  final List image;
  int index;
  ChatTile(this.userName, this.chatRoom, this.image, this.index);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Messages(chatRoom, userName,
                  app_user.photo == image[0] ? image[1] : image[0], index),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Stack(children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                    app_user.photo == image[0] ? image[1] : image[0]),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all()),
                ),
              )
            ]),
            SizedBox(
              width: 16,
            ),
            Text(
              userName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
