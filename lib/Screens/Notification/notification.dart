import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/main.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Widget> notifs = [];

  @override
  void initState() {
    // get_notification();

    super.initState();
  }

  // void get_notification() {
  //   notifs = [];

  //   FirebaseMessaging.instance.getInitialMessage().then((message) async {
  //     notifs.add(Notification(
  //       head: message!.notification!.title.toString(),
  //       body: message.notification!.body.toString(),
  //     ));
  //     setState(() {});
  //   });

  //   FirebaseMessaging.onMessage.listen((message) async {
  //     if (message.notification != null) {
  //       notifs.add(Notification(
  //         head: message.notification!.title.toString(),
  //         body: message.notification!.body.toString(),
  //       ));
  //       setState(() {});
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
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
                const Center(
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(app_user.uid)
                        .collection("Notifications")
                        .snapshots(),
                    builder: (context, AsyncSnapshot futureSnapshot) {
                      if (futureSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (futureSnapshot.hasData) {
                          notifs = [];
                          int notis = futureSnapshot.requireData.size;
                          if (notis <= 5) {
                            for (var i
                                in futureSnapshot.requireData.docs.reversed) {
                              notifs.add(Notification(
                                head: i["head"],
                                body: i["body"],
                                docu: i["Time"],
                              ));
                            }
                          } else {
                            int k = 0;
                            while (k < 5) {
                              for (var i
                                  in futureSnapshot.requireData.docs.reversed) {
                                k += 1;
                                notifs.add(Notification(
                                  head: i["head"],
                                  body: i["body"],
                                  docu: i["Time"],
                                ));
                              }
                            }
                          }
                        }
                      }
                      return Column(
                        children: notifs.length != 0
                            ? notifs
                            : [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.335),
                                  child: Text(
                                    "No New\nNotifications !",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  Notification({required this.head, required this.body, required this.docu});
  String body, head, docu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    head,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 265,
                    child: Text(
                      body,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  var x = await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(app_user.uid)
                      .collection("Notifications")
                      .where("Time", isEqualTo: docu)
                      .get();
                  for (var i in x.docs) {
                    print(i.id);
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(app_user.uid)
                        .collection("Notifications")
                        .doc(i.id)
                        .delete();
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 35,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
