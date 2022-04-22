import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Wallet/add_balance.dart';
import 'package:fotoclash/Wallet/withdraw_balance.dart';
import 'package:fotoclash/main.dart';

class ContestTransactions extends StatefulWidget {
  const ContestTransactions({Key? key}) : super(key: key);

  @override
  State<ContestTransactions> createState() => _ContestTransactionsState();
}

class _ContestTransactionsState extends State<ContestTransactions> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _cardlist = [];

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
              SizedBox(width: size.width * 25 / 375),
              Column(
                children: [
                  Text(
                    "Contest Transactions",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: size.height * 25 / 812),
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
                          .collection("ContestTrans")
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
                                id: (i.data() as dynamic)["id"],
                                status: (i.data() as dynamic)["status"],
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
    required this.id,
    required this.size,
    required this.status,
  });

  String type, id, status;
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
                "Outcome - $status",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7,
              ),
              Text("$id", style: TextStyle(color: Color(0xFFBBC0C6)))
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
