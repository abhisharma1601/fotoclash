import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Widget> notifs = [];

  @override
  void initState() {
    get_notification();
    super.initState();
  }

  void get_notification() {
    notifs = [];

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      notifs.add(Notification(
        head: message!.notification!.title.toString(),
        body: message.notification!.body.toString(),
      ));
      setState(() {});
    });

    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        notifs.add(Notification(
          head: message.notification!.title.toString(),
          body: message.notification!.body.toString(),
        ));
        setState(() {});
      }
    });
  }

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
              height: 45,
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
            Column(children: notifs)
          ],
        ),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  Notification({required this.head, required this.body});
  String body, head;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffF49D63)),
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
          Icon(
            Icons.notification_add,
            color: Colors.red,
            size: 35,
          )
        ],
      ),
    );
  }
}
