import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/contest_2v2.dart';
import 'package:fotoclash/Screens/contest_4v4.dart';

import 'drawer_details.dart';

class VoteScreen extends StatefulWidget {
  const VoteScreen({Key? key}) : super(key: key);

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  List<Widget> _piclist = [];

  @override
  void initState() {
    get_contest();
    super.initState();
  }

  Future<void> get_contest() async {
    var key = await FirebaseFirestore.instance.collection("Contests").get();
    for (var i in key.docs) {
      if (DateTime.parse(i.data()["DateTime"] + "0")
              .add(Duration(days: 1))
              .difference(DateTime.now()) >
          Duration(seconds: 0)) {
        if (i.data()["Participations"].length == 2 &&
            !i.data()["images"].contains("")) {
          print(i.data()["ContestID"]);
          _piclist.add(Contest2v2(
            images: i.data()["images"],
            likes: i.data()["Likes"],
            contest_id: i.data()["ContestID"],
          ));
        } else if (i.data()["Participations"].length == 4 &&
            !i.data()["images"].contains("")) {
          print(i.data()["ContestID"]);
          _piclist.add(Contest4v4(
            images: i.data()["images"],
            likes: i.data()["Likes"],
            contest_id: i.data()["ContestID"],
          ));
        }
      }
    }
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Color(0xffbac333863),
        child: ProfileDrawer(),
      ),
      key: _scaffoldkey,
      extendBody: true,
      body: _piclist.length != 0
          ? Swiper(
              loop: false,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return _piclist[index];
              },
              itemCount: _piclist.length,
              pagination: SwiperPagination(builder: SwiperPagination.fraction),
              control: SwiperControl(
                color: Colors.transparent,
                size: 0,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.fill)),
            ),
    );
  }
}
