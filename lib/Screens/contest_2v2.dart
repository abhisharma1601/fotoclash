import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/drawer_details.dart';
import 'package:like_button/like_button.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.all(20.0),
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
          top: 24,
          child: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        likebuttom(context, isLiked, 60, 560, widget.likes[0],
            widget.contest_id, 0, widget.likes),
        likebuttom(context, isLiked, 250, 560, widget.likes[1],
            widget.contest_id, 1, widget.likes),
        Positioned(
            left: MediaQuery.of(context).size.width * 330 / 375,
            top: MediaQuery.of(context).size.height * 700 / 812,
            child: const Icon(
              Icons.share_outlined,
              color: Colors.red,
              size: 28,
            )),
        Positioned(
            left: MediaQuery.of(context).size.width * 30 / 375,
            top: MediaQuery.of(context).size.height * 700 / 812,
            child: const Icon(
              Icons.comment,
              color: Colors.red,
              size: 28,
            ))
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

likebuttom(BuildContext context, bool liked, int left, int top, int count,
    String id, int index, List likes) {
  return Positioned(
    left: MediaQuery.of(context).size.width * left / 375,
    top: MediaQuery.of(context).size.height * top / 812,
    child: LikeButton(
      size: 40,
      isLiked: liked,
      likeCount: count,
      likeBuilder: (liked) {
        final color = liked ? Colors.red : Colors.white;
        return Icon(
          Icons.favorite,
          color: color,
          size: 36,
        );
      },
      countBuilder: (count, isliked, text) {
        likes[index] += 1;
        FirebaseFirestore.instance
            .collection("Contests")
            .doc(id)
            .set({"Likes": likes}, SetOptions(merge: true));
        final color = liked ? Colors.black : Colors.white;
        return Text(
          text,
          style: TextStyle(
              color: color, fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    ),
  );
}
