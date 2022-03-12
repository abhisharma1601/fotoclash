import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/drawer_details.dart';
import 'package:fotoclash/Screens/search_contest/searchcontest.dart';
import 'package:fotoclash/main.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

class Contest2v2 extends StatefulWidget {
  Contest2v2(
      {required this.images, required this.likes, required this.contest_id});
  List images, likes;
  String contest_id;

  @override
  _Contest2v2State createState() => _Contest2v2State();
}

class _Contest2v2State extends State<Contest2v2> {
  bool isLiked = false;
  _isLiked() {
    setState(() {
      isLiked = true;
    });
  }

  Color like1 = Colors.white;
  Color like2 = Colors.white;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: const Drawer(
        backgroundColor: Color(0xffbac333863),
        child: ProfileDrawer(),
      ),
      extendBody: true,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background.png"), fit: BoxFit.cover)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(children: [
            imageContainer(context, widget.images[0]),
            imageContainer(context, widget.images[1])
          ]),
        ]),
        Positioned(
          left: MediaQuery.of(context).size.width * 160 / 375,
          top: MediaQuery.of(context).size.height * 380 / 865,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(195, 188, 138, 1),
                  Color.fromRGBO(244, 157, 99, 1),
                  Color.fromRGBO(218, 62, 45, 1),
                  Color.fromRGBO(175, 47, 32, 1),
                ])),
            child: const CircleAvatar(
              child: Text(
                "VS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              radius: 30,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: IconButton(
              onPressed: () {
                _scaffoldkey.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              )),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 310 / 375,
          top: 35,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchContest()));
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),

        Positioned(
          child: GestureDetector(
            onTap: () {
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({
                "Voters": FieldValue.arrayUnion([app_user.uid])
              }, SetOptions(merge: true));
              if (like1 == Colors.white) {
                setState(() {
                  like1 = Colors.red;
                });
                widget.likes[0] += 1;
                FirebaseFirestore.instance
                    .collection("Contests")
                    .doc(widget.contest_id)
                    .set({"Likes": widget.likes}, SetOptions(merge: true));

                if (like2 == Colors.red) {
                  setState(() {
                    like2 = Colors.white;
                    widget.likes[1] -= 1;
                    FirebaseFirestore.instance
                        .collection("Contests")
                        .doc(widget.contest_id)
                        .set({"Likes": widget.likes}, SetOptions(merge: true));
                  });
                }
              } else if (like1 == Colors.red) {
                setState(() {
                  like1 = Colors.white;
                });
                widget.likes[0] -= 1;
                FirebaseFirestore.instance
                    .collection("Contests")
                    .doc(widget.contest_id)
                    .set({"Likes": widget.likes}, SetOptions(merge: true));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: like1,
                    size: 35,
                  ),
                  Text(
                    widget.likes[0].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          // left: MediaQuery.of(context).size.width * 70 / 375,
          top: MediaQuery.of(context).size.height * 545 / 812,
        ),
        Positioned(
          child: GestureDetector(
            onTap: () {
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({
                "Voters": FieldValue.arrayUnion([app_user.uid])
              }, SetOptions(merge: true));
              if (like2 == Colors.white) {
                setState(() {
                  like2 = Colors.red;
                });
                widget.likes[1] += 1;
                FirebaseFirestore.instance
                    .collection("Contests")
                    .doc(widget.contest_id)
                    .set({"Likes": widget.likes}, SetOptions(merge: true));
                if (like1 == Colors.red) {
                  setState(() {
                    like1 = Colors.white;
                    widget.likes[0] -= 1;
                    FirebaseFirestore.instance
                        .collection("Contests")
                        .doc(widget.contest_id)
                        .set({"Likes": widget.likes}, SetOptions(merge: true));
                  });
                }
              } else if (like2 == Colors.red) {
                setState(() {
                  like2 = Colors.white;
                });
                widget.likes[1] -= 1;
                FirebaseFirestore.instance
                    .collection("Contests")
                    .doc(widget.contest_id)
                    .set({"Likes": widget.likes}, SetOptions(merge: true));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: like2,
                    size: 35,
                  ),
                  Text(
                    widget.likes[1].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          left: MediaQuery.of(context).size.width * 186 / 375,
          top: MediaQuery.of(context).size.height * 545 / 812,
        ),
        // likebuttom1(context, isLiked, 60, 560, widget.likes[0],
        //     widget.contest_id, 0, widget.likes),
        // likebuttom2(context, isLiked, 250, 560, widget.likes[1],
        //     widget.contest_id, 1, widget.likes),
        Positioned(
            left: MediaQuery.of(context).size.width * 330 / 375,
            top: MediaQuery.of(context).size.height * 700 / 812,
            child: GestureDetector(
              onTap: () {
                Share.share(
                    "Hey, look at the contest I'm participating in vote me and you can also win upto Rs. 2000 by competing in the contest with id: ${widget.contest_id}",
                    subject: "Fotoclash Contest Invitation!");
              },
              child: const Icon(
                Icons.share_outlined,
                color: Colors.red,
                size: 28,
              ),
            )),
      ]),
    );
  }
}

imageContainer(BuildContext context, String image) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
    width: MediaQuery.of(context).size.width * 187 / 375,
    height: MediaQuery.of(context).size.height * 420 / 865,
  );
}
