import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Widgets/tab_bar.dart';
import 'package:fotoclash/main.dart';
import 'package:share_plus/share_plus.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int followers = app_user.data[0];
  int following = app_user.data[1];
  int Likes = app_user.data[2];

  int won = 0;
  int lost = 0;
  int tie = 0;
  int total_contest = 0;

  Future<void> get_contests_data() async {
    var key = await store.collection("Users").doc(app_user.uid).get();
    won = (key.data() as dynamic)["WinningData"]["Won"];
    lost = (key.data() as dynamic)["WinningData"]["Lost"];
    tie = (key.data() as dynamic)["WinningData"]["Contest Tie"];
    var key1 = await store
        .collection("Users")
        .doc(app_user.uid)
        .collection("Participations")
        .get();
    for (var i in key1.docs) {
      total_contest += 1;
    }

    setState(() {});
  }

  @override
  void initState() {
    get_contests_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(app_user.photo);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.355,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Image(
                        image: NetworkImage(app_user.photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 226 / 812,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      app_user.username,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      app_user.place,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      175 /
                                      375,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Share.share(
                                          "Hey, visit my Fotoclash Profile. Here is my username ${app_user.username}\nlink: https://fotoclash.com");
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.red,
                                      size: 30,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Wrap(
                    runSpacing: MediaQuery.of(context).size.width * 15 / 375,
                    children: [
                      const SizedBox(),
                      _shocase(head: followers, body: "Followers"),
                      _shocase(head: following, body: "Following"),
                      _shocase(
                          head: total_contest,
                          body: total_contest == 1 ? "Contest" : "Contests")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _winDetails(
                        head: "Won", body: won.toString(), color: Colors.green),
                    _winDetails(
                        head: "Lost", body: lost.toString(), color: Colors.red),
                    _winDetails(
                        head: "Contest Tie",
                        body: tie.toString(),
                        color: Colors.yellow)
                  ],
                ),
                Divider(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 40 / 812,
                  thickness: 0.2,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                  child: Text(
                    "Bio",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                  child: Text(
                    app_user.bio,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const TabBarAndTabViews()
              ],
            ),
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
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class _winDetails extends StatelessWidget {
  _winDetails({required this.head, required this.body, required this.color});

  String head;
  String body;
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
