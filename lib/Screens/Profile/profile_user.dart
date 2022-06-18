import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Screens/Chats/chat_home.dart';
import 'package:fotoclash/main.dart';

import '../../Models/databse.dart';
import '../Chats/messages.dart';

class UserProfile extends StatefulWidget {
  String username;
  int index;
  UserProfile(this.username, this.index, {Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Stream? chatRoomsStream;
  DataBase dataBase = DataBase();
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

  Future<void> postFollowers() async {
    var key = await FirebaseFirestore.instance
        .collection("Users")
        .where("userName", isEqualTo: widget.username)
        .get();
    var uid = key.docs[0]["uid"];
    List data = key.docs[0]["Data"];
    int a = data[0] + 1;
    FirebaseFirestore.instance.collection("Users").doc(uid).set({
      "Data": [a, 0, 0],
      "Followers": FieldValue.arrayUnion([app_user.username])
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.username);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background.png"), fit: BoxFit.cover),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("userName", isEqualTo: widget.username)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 1,
                              child: Image(
                                image: NetworkImage(
                                    snapshot.requireData.docs[0]["imageUrl"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height *
                                  340 /
                                  812,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.username,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.requireData.docs[0]["State"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Wrap(
                            runSpacing:
                                MediaQuery.of(context).size.width * 15 / 375,
                            children: [
                              const SizedBox(),
                              _shocase(
                                  head: snapshot.requireData.docs[0]["Data"][0],
                                  body: "Followers"),
                              SizedBox(
                                width: 40,
                              ),
                              // _shocase(head: snapshot.requireData.docs[0]["Data"][1], body: "Following"),
                              _shocase(
                                  head: snapshot.requireData.docs[0]
                                          ["WinningData"]["Contest Tie"] +
                                      snapshot.requireData.docs[0]
                                          ["WinningData"]["Lost"] +
                                      snapshot.requireData.docs[0]
                                          ["WinningData"]["Won"],
                                  body: "Contests")
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(166, 203, 255, 1),
                                      Color.fromARGB(255, 121, 139, 175),
                                      Color.fromRGBO(175, 47, 32, 1),
                                      Color.fromRGBO(244, 157, 99, 1),
                                    ])),
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Users")
                                        .where("userName",
                                            isEqualTo: widget.username)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot Streamsnapshot) {
                                      if (Streamsnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      return ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            alignment: Alignment.center,
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.only(
                                                    right: 55,
                                                    left: 55,
                                                    top: 15,
                                                    bottom: 15)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            )),
                                        onPressed: () {
                                          setState(() {
                                            if (Streamsnapshot.requireData
                                                .docs[0]["Followers"]
                                                .contains(app_user.username)) {
                                              print("Exists");
                                              Fluttertoast.showToast(
                                                  msg: "You already Followed");
                                            } else {
                                              setState(() {
                                                postFollowers();
                                              });

                                              print("Not");
                                            }
                                          });
                                        },
                                        child: Streamsnapshot.requireData
                                                .docs[0]["Followers"]
                                                .contains(app_user.username)
                                            ? const Text(
                                                "Following",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                "Follow",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                      );
                                    })),
                            SizedBox(
                              width: 5,
                            ),
                            StreamBuilder(
                                stream: chatRoomsStream,
                                builder: (context, AsyncSnapshot snapshot) {
                                  return snapshot.hasData
                                      ? DecoratedBox(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                alignment: Alignment.center,
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            right: 55,
                                                            left: 55,
                                                            top: 15,
                                                            bottom: 15)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                )),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeChats()));
                                              Clipboard.setData(
                                                  new ClipboardData(
                                                      text: widget.username));
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "${widget.username} copied!");
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Sarch username and start chating!");
                                            },
                                            child: const Text(
                                              "Message",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ))
                                      : Container();
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _winDetails(
                                head: "Won",
                                body: snapshot.requireData.docs[0]
                                    ["WinningData"]["Won"],
                                color: Colors.green),
                            _winDetails(
                                head: "Lost",
                                body: snapshot.requireData.docs[0]
                                    ["WinningData"]["Lost"],
                                color: Colors.red),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 40 / 812,
                          thickness: 0.2,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 16),
                          child: Text(
                            "Bio",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16),
                          child: Text(
                            snapshot.requireData.docs[0]["bio"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class _shocase extends StatelessWidget {
  _shocase({required this.head, required this.body});

  int head;
  String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Text(
        "$head  $body",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _winDetails extends StatelessWidget {
  _winDetails({required this.head, required this.body, required this.color});

  String head;
  int body;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$head  $body",
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: 16),
    );
  }
}
