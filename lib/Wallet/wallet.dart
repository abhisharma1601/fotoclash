import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Wallet/add_balance.dart';
import 'package:fotoclash/Wallet/withdraw_balance.dart';
import 'package:fotoclash/main.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int balance = 0;
  int pending = 0;
  int added = 0;
  int withdrawn = 0;

  @override
  void initState() {
    get_data();
    super.initState();
  }

  List<Widget> _cardlist = [];

  Future<void> get_data() async {
    var key = await FirebaseFirestore.instance
        .collection("Users")
        .doc(app_user.uid)
        .get();
    balance = (key.data() as dynamic)["Wallet"]["Balance"];
    withdrawn = (key.data() as dynamic)["Wallet"]["Withdrawn"];
    added = (key.data() as dynamic)["Wallet"]["Added"];
    pending = (key.data() as dynamic)["Wallet"]["Pending"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("background.png"), fit: BoxFit.cover)),
      width: size.width,
      child: Column(
        children: [
          const SizedBox(
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
              SizedBox(width: size.width * 15 / 375),
              Column(
                children: [
                  Text(
                    "${app_user.name} - Wallet",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                backgroundImage: NetworkImage(app_user.photo),
                radius: 24,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(height: size.height * 25 / 812),
          Stack(children: [
            Container(
              padding: EdgeInsets.only(left: 23, bottom: 15),
              width: size.width * 343 / 375,
              decoration: BoxDecoration(
                  color: Color(0xFF141E31),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Total Balance",
                            style: TextStyle(color: Color(0xFFBBC0C6)),
                          ),
                          SizedBox(height: 7),
                          Text(
                            "\u{20B9} $balance",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBalance(
                                            balance: balance,
                                            added: added,
                                          )));
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              width: size.width * 57 / 375,
                              height: size.height * 34 / 812,
                              decoration: BoxDecoration(
                                  color: Color(0xFF23C43),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  )),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 9),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WithdrawBalance(
                                            balance: balance,
                                            pending: pending,
                                            withdrawn: withdrawn,
                                          )));
                            },
                            child: Container(
                                alignment: Alignment.topRight,
                                width: size.width * 95 / 375,
                                height: size.height * 34 / 812,
                                decoration: BoxDecoration(
                                    color: Color(0xFF23C43),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    )),
                                child: Center(
                                  child: Text(
                                    "Withdraw",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Withdrawn",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "\u{20B9} $withdrawn",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Pending",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "\u{20B9} $pending",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Added",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "\u{20B9} $added",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
          SizedBox(height: size.height * 20 / 812),
          Text("History",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          SizedBox(height: size.height * 20 / 812),
          Expanded(
            child: Scrollbar(
              radius: Radius.circular(50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(app_user.uid)
                          .collection("Transactions")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        _cardlist = [];
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> d = snapshot.data!.docs;
                          for (var i in d.reversed) {
                            _cardlist.add(History(
                                amount: (i.data() as dynamic)["Amount"],
                                type: (i.data() as dynamic)["Type"],
                                date: (i.data() as dynamic)["Date"],
                                time: (i.data() as dynamic)["Time"],
                                size: size));
                          }
                        }
                        return Column(
                          children:
                              _cardlist.length != 0 ? _cardlist : [Container()],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class History extends StatelessWidget {
  History({
    required this.amount,
    required this.type,
    required this.date,
    required this.time,
    required this.size,
  });

  String type, date, time;
  int amount;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9),
      padding: EdgeInsets.all(20),
      width: size.width * 343 / 375,
      decoration: BoxDecoration(
          color: Color(0xFF222633), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7,
              ),
              Text("$date    $time", style: TextStyle(color: Color(0xFFBBC0C6)))
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                type == "Added" ? "+ \u{20B9}$amount" : "- \u{20B9}$amount",
                style: TextStyle(
                    color: type == "Added" ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
