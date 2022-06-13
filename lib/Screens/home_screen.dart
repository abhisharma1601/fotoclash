import 'dart:convert';
import 'dart:math';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fotoclash/Screens/Notification/notification.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Controllers/user_class.dart';
import 'package:fotoclash/Screens/Chats/chat_home.dart';
import 'package:fotoclash/Screens/leader_board.dart';
import 'package:fotoclash/Screens/Profile/profile.dart';
import 'package:fotoclash/Screens/contest_4v4.dart';
import 'package:fotoclash/Screens/vote-screen.dart';
import 'package:fotoclash/Widgets/bottom_bar.dart';
import 'package:fotoclash/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'drawer_details.dart';

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
    set_fcm();
    notify();
    super.initState();
  }

  String _server_token =
      "AAAAZ0LjcmY:APA91bHd2nHGR0kt1grTkoXIMgWrJNMAXTchK9i089bwmaEV738RD1zA1rebS5-TwrHGWTwrqQfgVgkr3V_kpuGufH8gOItQ7WyvQj98gaQwA4rxWSRgvzLsKEUQy867wFm7Nj7c1ojJ";

  Future<void> send_noti(String token, int Amount, String Status,
      String ContestID, String body_text) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=' + _server_token,
    };
    final body = {
      'notification': {
        'title': 'Result Declared!',
        'body': body_text,
      },
      'to': token,
      'priority': 'high',
      'data': {"Amount": Amount, "Status": Status, "ContestID": ContestID},
    };
    final encoding = Encoding.getByName('utf-8');
    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var response = await post(
      uri,
      headers: headers,
      body: json.encode(body),
      encoding: encoding,
    );
    print(response.body);
  }

  void notify() {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        print(message.notification!.body);
        Fluttertoast.showToast(msg: "New Notifications!");
      }
    });

    //background taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    });
  }

  Future<void> set_fcm() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"Token": token}, SetOptions(merge: true));
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
        bio: (key.data() as dynamic)["bio"],
        balance: (key.data() as dynamic)["Wallet"]["Balance"]);
  }

  Future<void> declare_result() async {
    var key = await FirebaseFirestore.instance.collection("Contests").get();
    for (var i in key.docs) {
      //if contest is over and result not declared
      if (DateTime.parse(i.data()["DateTime"] + "0")
                  .add(Duration(days: 1))
                  .difference(DateTime.now()) <=
              Duration(seconds: 0) &&
          !i.data()["Participations"].contains("")) {
        try {
          if (!i.data()["Declared"]) {
            //if there is a tie
            if (is_tie(i.data()["Likes"]) && i.data()["Likes"].length == 2) {
              for (var j in i.data()["Participations"]) {
                store.collection("Users").doc(j).set({
                  "WinningData": {"Contest Tie": FieldValue.increment(1)}
                }, SetOptions(merge: true));
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("Participations")
                    .doc(i.data()["ContestID"])
                    .set({"isActive": false, "Winner": false, "Status": "Tie"},
                        SetOptions(merge: true));

                FirebaseFirestore.instance.collection("Users").doc(j).set({
                  "Wallet": {
                    "Balance": FieldValue.increment(i.data()['EntryFee'])
                  }
                }, SetOptions(merge: true));
                var key = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .get();
                String token = (key.data() as dynamic)["Token"];
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("Notifications")
                    .doc(DateTime.now().toString())
                    .set({
                  "head": "Result Declared",
                  "body":
                      "The result of contest with id ${i.data()["ContestID"]} is declared with a tie! Entry fee will be refunded!",
                  "Time": DateTime.now().toString()
                }, SetOptions(merge: true));
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("ContestTrans")
                    .doc(DateTime.now().toString())
                    .set({
                  "id": i.data()["ContestID"],
                  "Type": "Added",
                  "status": "Tie",
                  "Amount": int.parse(i.data()['EntryFee'])
                }, SetOptions(merge: true));
                send_noti(
                    token,
                    int.parse(i.data()['EntryFee']),
                    "Tie",
                    i.data()["ContestID"],
                    "The result of contest with id ${i.data()["ContestID"]} is declared with a tie! Entry fee will be refunded!");
              }
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(i.data()["ContestID"])
                  .set({"Declared": true}, SetOptions(merge: true));
            }

            //4 tie

            else if (is4_tie(i.data()["Likes"])[0] == true &&
                i.data()["Likes"].length == 4) {
              print("checking func!");

              List parts = [];
              int prize = 0;

              for (int j in is4_tie(i.data()["Likes"])[1]) {
                parts.add(i.data()["Participations"][j]);
              }

              if (parts.length != 4) {
                prize = int.parse(
                    i.data()["winnerPrize"].replaceAll("₹", "") / parts.length);
              } else {
                prize = int.parse(i.data()['EntryFee']);
              }

              for (var j in parts) {
                store.collection("Users").doc(j).set({
                  "WinningData": {"Contest Tie": FieldValue.increment(1)}
                }, SetOptions(merge: true));
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("Participations")
                    .doc(i.data()["ContestID"])
                    .set({"isActive": false, "Winner": false, "Status": "Tie"},
                        SetOptions(merge: true));
                FirebaseFirestore.instance.collection("Users").doc(j).set({
                  "Wallet": {"Balance": FieldValue.increment(prize)}
                }, SetOptions(merge: true));
                var key = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .get();
                String token = (key.data() as dynamic)["Token"];
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("Notifications")
                    .doc(DateTime.now().toString())
                    .set({
                  "head": "Result Declared",
                  "body":
                      "The result of contest with id ${i.data()["ContestID"]} is declared with a tie with an another entry! Price money of Rs $prize shared with other entry will be added!",
                  "Time": DateTime.now().toString()
                }, SetOptions(merge: true));
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("ContestTrans")
                    .doc(DateTime.now().toString())
                    .set({
                  "id": i.data()["ContestID"],
                  "Type": "Added",
                  "status": "Tie",
                  "Amount": int.parse(i.data()['EntryFee'])
                }, SetOptions(merge: true));
                send_noti(
                    token,
                    int.parse(i.data()['EntryFee']),
                    "Tie",
                    i.data()["ContestID"],
                    "The result of contest with id ${i.data()["ContestID"]} is declared with a tie with an another entry! Price money of Rs $prize shared with other entry will be added!");
              }
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(i.data()["ContestID"])
                  .set({"Declared": true}, SetOptions(merge: true));
            }

            // if there is no tie
            else {
              int max_likes = get_max(i.data()["Likes"]);
              int index = i.data()["Likes"].indexOf(max_likes);
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(i.data()["ContestID"])
                  .set({"Declared": true}, SetOptions(merge: true));
              String winner_id = i.data()["Participations"][index];
              store.collection("Users").doc(winner_id).set({
                "WinningData": {"Won": FieldValue.increment(1)}
              }, SetOptions(merge: true));
              var key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(winner_id)
                  .get();
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(winner_id)
                  .set({
                "Wallet": {
                  "Balance": FieldValue.increment(
                      int.parse(i.data()["winnerPrize"].replaceAll("₹", "")))
                }
              }, SetOptions(merge: true));
              FirebaseFirestore.instance
                  .collection("Winners")
                  .doc(winner_id)
                  .set({
                "Total Winnigs": FieldValue.increment(
                  int.parse(
                    i.data()["winnerPrize"].replaceAll("₹", ""),
                  ),
                ),
                "Wins": FieldValue.increment(1),
                "ID": winner_id,
                "image": (key.data() as dynamic)["imageUrl"],
                "uname": (key.data() as dynamic)["userName"],
              }, SetOptions(merge: true));
              var token_key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(winner_id)
                  .get();
              String token = (token_key.data() as dynamic)["Token"];

              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(winner_id)
                  .collection("Notifications")
                  .doc(DateTime.now().toString())
                  .set({
                "head": "Result Declared",
                "body":
                    "Congratulations! You won the contest with id ${i.data()["ContestID"]}. Prize money will be added to your wallet!",
                "Time": DateTime.now().toString()
              }, SetOptions(merge: true));

              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(winner_id)
                  .collection("ContestTrans")
                  .doc(DateTime.now().toString())
                  .set({
                "id": i.data()["ContestID"],
                "Type": "Added",
                "status": "Won",
                "Amount": int.parse(
                  i.data()["winnerPrize"].replaceAll("₹", ""),
                ),
              }, SetOptions(merge: true));

              send_noti(
                  token,
                  int.parse(
                    i.data()["winnerPrize"].replaceAll("₹", ""),
                  ),
                  "Win",
                  i.data()["ContestID"],
                  "Congratulations! You won the contest with id ${i.data()["ContestID"]}. Prize money will be added to your wallet!");
              for (var j in i.data()["Participations"]) {
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("Participations")
                    .doc(i.data()["ContestID"])
                    .set({"isActive": false}, SetOptions(merge: true));
                var token_key = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .get();
                String token = (token_key.data() as dynamic)["Token"];

                if (j != winner_id) {
                  store.collection("Users").doc(j).set({
                    "WinningData": {"Lost": FieldValue.increment(1)}
                  }, SetOptions(merge: true));
                  store
                      .collection("Users")
                      .doc(winner_id)
                      .collection("Notifications")
                      .doc(DateTime.now().toString())
                      .set({
                    "head": "Result Declared",
                    "body":
                        "Better Luck next time! You lost the contest with id ${i.data()["ContestID"]}. Don't worry, participate in some other contest to win!",
                    "Time": DateTime.now().toString()
                  }, SetOptions(merge: true));
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(j)
                      .collection("ContestTrans")
                      .doc(DateTime.now().toString())
                      .set({
                    "id": i.data()["ContestID"],
                    "Type": "Withdrawn",
                    "status": "Lost",
                    "Amount": int.parse(i.data()['EntryFee'])
                  }, SetOptions(merge: true));
                  send_noti(
                      token,
                      int.parse(
                        i.data()["winnerPrize"].replaceAll("₹", ""),
                      ),
                      "Lost",
                      i.data()["ContestID"],
                      "Better Luck next time! You lost the contest with id ${i.data()["ContestID"]}. Don't worry, participate in some other contest to win!");
                }
              }
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(winner_id)
                  .collection("Participations")
                  .doc(i.data()["ContestID"])
                  .set({"Winner": true}, SetOptions(merge: true));
            }
          }
        } catch (e) {
          //if there is a tie
          if (is_tie(i.data()["Likes"]) && i.data()["Likes"].length == 2) {
            print(i.data()["ContestID"]);
            for (var j in i.data()["Participations"]) {
              store.collection("Users").doc(j).set({
                "WinningData": {"Contest Tie": FieldValue.increment(1)}
              }, SetOptions(merge: true));
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .collection("Participations")
                  .doc(i.data()["ContestID"])
                  .set({"isActive": false, "Winner": false, "Status": "Tie"},
                      SetOptions(merge: true));
              FirebaseFirestore.instance.collection("Users").doc(j).set({
                "Wallet": {
                  "Balance":
                      FieldValue.increment(int.parse(i.data()['EntryFee']))
                }
              }, SetOptions(merge: true));
              var key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .get();
              String token = (key.data() as dynamic)["Token"];
              store
                  .collection("Users")
                  .doc(j)
                  .collection("Notifications")
                  .doc(DateTime.now().toString())
                  .set({
                "head": "Result Declared",
                "body":
                    "The result of contest with id ${i.data()["ContestID"]} is declared with a tie! Entry fee will be refunded!",
                "Time": DateTime.now().toString()
              }, SetOptions(merge: true));
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .collection("ContestTrans")
                  .doc(DateTime.now().toString())
                  .set({
                "id": i.data()["ContestID"],
                "Type": "Added",
                "status": "Tie",
                "Amount": int.parse(i.data()['EntryFee'])
              }, SetOptions(merge: true));
              send_noti(
                  token,
                  int.parse(i.data()['EntryFee']),
                  "Tie",
                  i.data()["ContestID"],
                  "The result of contest with id ${i.data()["ContestID"]} is declared with a tie! Entry fee will be refunded!");
            }
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(i.data()["ContestID"])
                .set({"Declared": true}, SetOptions(merge: true));
          }

          //4 tie

          else if (is4_tie(i.data()["Likes"])[0] == true &&
              i.data()["Likes"].length == 4) {
            print("checking func!");

            List parts = [];
            int prize = 0;

            for (int j in is4_tie(i.data()["Likes"])[1]) {
              parts.add(i.data()["Participations"][j]);
            }

            if (parts.length != 4) {
              prize = int.parse(
                  i.data()["winnerPrize"].replaceAll("₹", "") / parts.length);
            } else {
              prize = int.parse(i.data()['EntryFee']);
            }

            for (var j in parts) {
              store.collection("Users").doc(j).set({
                "WinningData": {"Contest Tie": FieldValue.increment(1)}
              }, SetOptions(merge: true));
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .collection("Participations")
                  .doc(i.data()["ContestID"])
                  .set({"isActive": false, "Winner": false, "Status": "Tie"},
                      SetOptions(merge: true));
              FirebaseFirestore.instance.collection("Users").doc(j).set({
                "Wallet": {"Balance": FieldValue.increment(prize)}
              }, SetOptions(merge: true));
              var key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .get();
              String token = (key.data() as dynamic)["Token"];
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .collection("Notifications")
                  .doc(DateTime.now().toString())
                  .set({
                "head": "Result Declared",
                "body":
                    "The result of contest with id ${i.data()["ContestID"]} is declared with a tie with an another entry! Price money of Rs $prize shared with other entry will be added!",
                "Time": DateTime.now().toString()
              }, SetOptions(merge: true));
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .collection("ContestTrans")
                  .doc(DateTime.now().toString())
                  .set({
                "id": i.data()["ContestID"],
                "Type": "Added",
                "status": "Tie",
                "Amount": int.parse(i.data()['EntryFee'])
              }, SetOptions(merge: true));
              send_noti(
                  token,
                  int.parse(i.data()['EntryFee']),
                  "Tie",
                  i.data()["ContestID"],
                  "The result of contest with id ${i.data()["ContestID"]} is declared with a tie with an another entry! Price money of Rs $prize shared with other entry will be added!");
            }
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(i.data()["ContestID"])
                .set({"Declared": true}, SetOptions(merge: true));
          }

          //if no tie
          else {
            int max_likes = get_max(i.data()["Likes"]);
            int index = i.data()["Likes"].indexOf(max_likes);
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(i.data()["ContestID"])
                .set({"Declared": true}, SetOptions(merge: true));
            String winner_id = i.data()["Participations"][index];
            store.collection("Users").doc(winner_id).set({
              "WinningData": {"Won": FieldValue.increment(1)}
            }, SetOptions(merge: true));
            var key = await FirebaseFirestore.instance
                .collection("Users")
                .doc(winner_id)
                .get();
            FirebaseFirestore.instance.collection("Users").doc(winner_id).set({
              "Wallet": {
                "Balance": FieldValue.increment(
                    int.parse(i.data()["winnerPrize"].replaceAll("₹", "")))
              }
            }, SetOptions(merge: true));
            FirebaseFirestore.instance
                .collection("Winners")
                .doc(winner_id)
                .set({
              "Total Winnigs": FieldValue.increment(
                int.parse(
                  i.data()["winnerPrize"].replaceAll("₹", ""),
                ),
              ),
              "Wins": FieldValue.increment(1),
              "ID": winner_id,
              "image": (key.data() as dynamic)["imageUrl"],
              "uname": (key.data() as dynamic)["userName"],
            }, SetOptions(merge: true));
            var token_key = await FirebaseFirestore.instance
                .collection("Users")
                .doc(winner_id)
                .get();
            String token = (token_key.data() as dynamic)["Token"];

            store
                .collection("Users")
                .doc(winner_id)
                .collection("Notifications")
                .doc(DateTime.now().toString())
                .set({
              "head": "Result Declared",
              "body":
                  "Congratulations! You won the contest with id ${i.data()["ContestID"]}. Prize money will be added to your wallet!",
              "Time": DateTime.now().toString()
            }, SetOptions(merge: true));

            FirebaseFirestore.instance
                .collection("Users")
                .doc(winner_id)
                .collection("ContestTrans")
                .doc(DateTime.now().toString())
                .set({
              "id": i.data()["ContestID"],
              "Type": "Added",
              "status": "Won",
              "Amount": int.parse(
                i.data()["winnerPrize"].replaceAll("₹", ""),
              ),
            }, SetOptions(merge: true));

            send_noti(
                token,
                int.parse(
                  i.data()["winnerPrize"].replaceAll("₹", ""),
                ),
                "Win",
                i.data()["ContestID"],
                "Congratulations! You won the contest with id ${i.data()["ContestID"]}. Prize money will be added to your wallet!");
            for (var j in i.data()["Participations"]) {
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .collection("Participations")
                  .doc(i.data()["ContestID"])
                  .set({"isActive": false}, SetOptions(merge: true));
              var token_key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(j)
                  .get();
              String token = (token_key.data() as dynamic)["Token"];

              if (j != winner_id) {
                store.collection("Users").doc(j).set({
                  "WinningData": {"Lost": FieldValue.increment(1)}
                }, SetOptions(merge: true));

                store
                    .collection("Users")
                    .doc(j)
                    .collection("Notifications")
                    .doc(DateTime.now().toString())
                    .set({
                  "head": "Result Declared",
                  "body":
                      "Better Luck next time! You lost the contest with id ${i.data()["ContestID"]}. Don't worry, participate in some other contest to win!",
                  "Time": DateTime.now().toString()
                }, SetOptions(merge: true));
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(j)
                    .collection("ContestTrans")
                    .doc(DateTime.now().toString())
                    .set({
                  "id": i.data()["ContestID"],
                  "Type": "Withdrawn",
                  "status": "Lost",
                  "Amount": int.parse(i.data()['EntryFee'])
                }, SetOptions(merge: true));
                send_noti(
                    token,
                    int.parse(
                      i.data()["winnerPrize"].replaceAll("₹", ""),
                    ),
                    "Lost",
                    i.data()["ContestID"],
                    "Better Luck next time! You lost the contest with id ${i.data()["ContestID"]}. Don't worry, participate in some other contest to win!");
              }
            }
            FirebaseFirestore.instance
                .collection("Users")
                .doc(winner_id)
                .collection("Participations")
                .doc(i.data()["ContestID"])
                .set({"Winner": true}, SetOptions(merge: true));
          }
        }
      }
      //if contest is over and no participation is there
      else if (DateTime.parse(i.data()["DateTime"] + "0")
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
            List participants = i.data()["Participations"];
            for (var person in participants) {
              print(i);
              if (person != "") {
                FirebaseFirestore.instance.collection("Users").doc(person).set({
                  "Wallet": {
                    "Balance": FieldValue.increment(
                        int.parse(i.data()["EntryFee"].replaceAll("₹", "")))
                  }
                }, SetOptions(merge: true));
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(person)
                    .collection("Participations")
                    .doc(i.data()["ContestID"])
                    .set({"isActive": false, "Status": "No_Participation"},
                        SetOptions(merge: true));

                var token_key = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(person)
                    .get();
                String token = (token_key.data() as dynamic)["Token"];

                store
                    .collection("Users")
                    .doc(person)
                    .collection("Notifications")
                    .doc(DateTime.now().toString())
                    .set({
                  "head": "No Participation",
                  "body":
                      "There was no participation for your contest with id ${i.data()["ContestID"]}. Don't worry, keep sharing your contests! Entry fee will be refunded!",
                  "Time": DateTime.now().toString()
                }, SetOptions(merge: true));

                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(person)
                    .collection("ContestTrans")
                    .doc(DateTime.now().toString())
                    .set({
                  "id": i.data()["ContestID"],
                  "Type": "Added",
                  "status": "No Participation",
                  "Amount": int.parse(i.data()['EntryFee'])
                }, SetOptions(merge: true));

                send_noti(
                    token,
                    int.parse(i.data()["EntryFee"].replaceAll("₹", "")),
                    "No Participation",
                    i.data()["ContestID"],
                    "There was no participation for your contest with id ${i.data()["ContestID"]}. Don't worry, keep sharing your contests! Entry fee will be refunded!");
              }
            }
          }
        } catch (e) {
          FirebaseFirestore.instance
              .collection("Contests")
              .doc(i.data()["ContestID"])
              .set({"Declared": true}, SetOptions(merge: true));
          // String creator_id = i.data()["CreatorID"];
          List participants = i.data()["Participations"];
          for (var person in participants) {
            print(i);
            if (person != "") {
              FirebaseFirestore.instance.collection("Users").doc(person).set({
                "Wallet": {
                  "Balance": FieldValue.increment(
                      int.parse(i.data()["EntryFee"].replaceAll("₹", "")))
                }
              }, SetOptions(merge: true));
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(person)
                  .collection("Participations")
                  .doc(i.data()["ContestID"])
                  .set({"isActive": false, "Status": "No_Participation"},
                      SetOptions(merge: true));

              var token_key = await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(person)
                  .get();
              String token = (token_key.data() as dynamic)["Token"];
              store
                  .collection("Users")
                  .doc(person)
                  .collection("Notifications")
                  .doc(DateTime.now().toString())
                  .set({
                "head": "No Participation",
                "body":
                    "There was no participation for your contest with id ${i.data()["ContestID"]}. Don't worry, keep sharing your contests! Entry fee will be refunded!",
                "Time": DateTime.now().toString()
              }, SetOptions(merge: true));

              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(person)
                  .collection("ContestTrans")
                  .doc(DateTime.now().toString())
                  .set({
                "id": i.data()["ContestID"],
                "Type": "Added",
                "status": "No Participation",
                "Amount": int.parse(i.data()['EntryFee'])
              }, SetOptions(merge: true));

              send_noti(
                  token,
                  int.parse(i.data()["EntryFee"].replaceAll("₹", "")),
                  "No Participation",
                  i.data()["ContestID"],
                  "There was no participation for your contest with id ${i.data()["ContestID"]}. Don't worry, keep sharing your contests! Entry fee will be refunded!");
            }
          }
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

  bool is_tie(List Likes) {
    bool check = true;
    int base = Likes[0];
    for (int i in Likes) {
      if (i != base) {
        check = false;
      }
    }
    return check;
  }

  List is4_tie(List likes) {
    int tie = 0;
    List participants = [];

    int max = 0;

    for (int i in likes) {
      if (i > max) {
        max = i;
      }
    }

    for (int i = 0; i < likes.length; i++) {
      if (likes[i] == max) {
        participants.add(i);
        tie = tie + 1;
      }
    }

    return [tie > 1, participants];
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
        body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: pages[index]));
  }
}
