import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Controllers/user_class.dart';
import 'package:fotoclash/Screens/Chats/chat_home.dart';
import 'package:fotoclash/Screens/leader_board.dart';
import 'package:fotoclash/Screens/profile.dart';
import 'package:fotoclash/Screens/contest_4v4.dart';
import 'package:fotoclash/Widgets/bottom_bar.dart';
import 'package:fotoclash/main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.uid});
  String uid;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetch_data();
    super.initState();
  }

  Future<void> fetch_data() async {
    var key = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.uid)
        .get();
    app_user = user_class(
        name: (key.data() as dynamic)["fullname"],
        uid: widget.uid,
        username: (key.data() as dynamic)["userName"],
        phone: (key.data() as dynamic)["phoneNo"],
        email: (key.data() as dynamic)["email"],
        photo: (key.data() as dynamic)["imageUrl"],
        place: (key.data() as dynamic)["State"],
        data: (key.data() as dynamic)["Data"],
        balance: (key.data() as dynamic)["Wallet"]["Balance"]);
  }

  int index = 0;
  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  final pages = <Widget>[
    const Contest4v4(),
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
