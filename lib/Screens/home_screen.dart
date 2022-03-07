import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Controllers/user_class.dart';
import 'package:fotoclash/Screens/Chats/chat_home.dart';
import 'package:fotoclash/Screens/leader_board.dart';
import 'package:fotoclash/Screens/profile.dart';
import 'package:fotoclash/Screens/contest_4v4.dart';
import 'package:fotoclash/Screens/vote-screen.dart';
import 'package:fotoclash/Widgets/bottom_bar.dart';
import 'package:fotoclash/main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetch_data();
    declare_result();
    super.initState();
  }

  Future<void> fetch_data() async {
    var key = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    app_user = user_class(
        name: (key.data() as dynamic)["fullname"],
        uid: FirebaseAuth.instance.currentUser!.uid,
        username: (key.data() as dynamic)["userName"],
        phone: (key.data() as dynamic)["phoneNo"],
        email: (key.data() as dynamic)["email"],
        photo: (key.data() as dynamic)["imageUrl"],
        place: (key.data() as dynamic)["State"],
        data: (key.data() as dynamic)["Data"],
        balance: (key.data() as dynamic)["Wallet"]["Balance"]);
  }

  Future<void> declare_result() async {
    var key = await FirebaseFirestore.instance.collection("Contests").get();
    for (var i in key.docs) {
      if (DateTime.parse(i.data()["DateTime"] + "0")
                  .add(Duration(days: 1))
                  .difference(DateTime.now()) <=
              Duration(seconds: 0) &&
          !i.data()["Participations"].contains("")) {
        try {
          if (!i.data()["Declared"]) {
            int max_likes = i.data()["Likes"].max;
            int index = i.data()["Likes"].indexOf(max_likes);
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(i.data()["ContestID"])
                .set({"Declared": true}, SetOptions(merge: true));
            String winner_id = i.data()["Participations"][index];
            FirebaseFirestore.instance.collection("Users").doc(winner_id).set({
              "Wallet": {
                "Balance": FieldValue.increment(
                    int.parse(i.data()["winnerPrize"].replaceAll("₹", "")))
              }
            }, SetOptions(merge: true));
          }
        } catch (e) {
          int max_likes = get_max(i.data()["Likes"]);
          int index = i.data()["Likes"].indexOf(max_likes);
          FirebaseFirestore.instance
              .collection("Contests")
              .doc(i.data()["ContestID"])
              .set({"Declared": true}, SetOptions(merge: true));
          String winner_id = i.data()["Participations"][index];
          FirebaseFirestore.instance.collection("Users").doc(winner_id).set({
            "Wallet": {
              "Balance": FieldValue.increment(
                  int.parse(i.data()["winnerPrize"].replaceAll("₹", "")))
            }
          }, SetOptions(merge: true));
        }
      } else if (DateTime.parse(i.data()["DateTime"] + "0")
                  .add(Duration(days: 1))
                  .difference(DateTime.now()) <=
              Duration(seconds: 0) &&
          i.data()["Participations"].contains("")) {
        try {
          if (!i.data()["Declared"]) {
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(i.data()["ContestID"])
                .set({"Declared": true}, SetOptions(merge: true));
            String creator_id = i.data()["CreatorID"];
            FirebaseFirestore.instance.collection("Users").doc(creator_id).set({
              "Wallet": {
                "Balance": FieldValue.increment(
                    int.parse(i.data()["EntryFee"].replaceAll("₹", "")))
              }
            }, SetOptions(merge: true));
          }
        } catch (e) {
          FirebaseFirestore.instance
              .collection("Contests")
              .doc(i.data()["ContestID"])
              .set({"Declared": true}, SetOptions(merge: true));
          String creator_id = i.data()["CreatorID"];
          FirebaseFirestore.instance.collection("Users").doc(creator_id).set({
            "Wallet": {
              "Balance": FieldValue.increment(
                  int.parse(i.data()["EntryFee"].replaceAll("₹", "")))
            }
          }, SetOptions(merge: true));
        }
      }
    }
  }

  int get_max(List likes) {
    int max = 0;
    for (int i in likes) {
      if (i > max) {
        max = i;
      }
    }

    return max;
  }

  int index = 0;
  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  final pages = <Widget>[
    const VoteScreen(),
    const LeaderBoard(),
    const HomeChats(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavBar(
          index: index,
          onChangedTab: onChangedTab,
        ),
        body: pages[index]);
  }
}
