import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Screens/Join-createContest/create_contest.dart';
import 'package:fotoclash/Screens/Join-createContest/create_contest2v2.dart';
import 'package:fotoclash/Screens/Join-createContest/create_contest3v3.dart';
import 'package:fotoclash/Screens/Join-createContest/join_contest.dart';
import 'package:fotoclash/Wallet/wallet.dart';
import 'package:fotoclash/main.dart';
import 'package:share_plus/share_plus.dart';

class ContestS extends StatefulWidget {
  const ContestS({Key? key}) : super(key: key);

  @override
  _ContestSState createState() => _ContestSState();
}

bool _private = false;
int _amount = 50;
int _balance_amount = 0;
int _con_size = 2;
final _formKey = GlobalKey<FormState>();
bool winnerisME = false;
bool isActive = true;
final _auth = FirebaseAuth.instance;
final TextEditingController PasswordC = TextEditingController();
final TextEditingController ContestNameC = TextEditingController();
final TextEditingController passC = TextEditingController();

class _ContestSState extends State<ContestS> {
  Gradient _active_gra = LinearGradient(colors: [
    Color.fromRGBO(134, 241, 249, 1),
    Color.fromRGBO(55, 80, 254, 1),
  ]);
  Gradient _notactive_gra = LinearGradient(colors: [
    Color.fromRGBO(0, 0, 0, 0),
    Color.fromRGBO(0, 0, 0, 0),
  ]);

  Gradient join_con = LinearGradient(colors: [
    Color.fromRGBO(134, 241, 249, 1),
    Color.fromRGBO(55, 80, 254, 1),
  ]);

  Gradient create_con = LinearGradient(colors: [
    Color.fromRGBO(0, 0, 0, 0),
    Color.fromRGBO(0, 0, 0, 0),
  ]);

  Gradient my_con = LinearGradient(colors: [
    Color.fromRGBO(0, 0, 0, 0),
    Color.fromRGBO(0, 0, 0, 0),
  ]);

  Widget _show = JOinConS();
  String _copy = "Copy Me";

  @override
  void initState() {
    get_balance();
    super.initState();
  }

  Future<void> get_balance() async {
    var key = await FirebaseFirestore.instance
        .collection("Users")
        .doc(app_user.uid)
        .get();
    _balance_amount = (key.data() as dynamic)["Wallet"]["Balance"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size.height * 40 / 812,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Fotoclash",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wallet()));
                        },
                        child: StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection("Users")
                                .doc(app_user.uid)
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return snapshot.hasData
                                    ? Chip(
                                        label: Text("₹" +
                                            snapshot.requireData["Wallet"]
                                                    ["Balance"]
                                                .toString()),
                                      )
                                    : Container();
                              }
                            }),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  height: size.height * 52 / 812,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (join_con != _active_gra) {
                              _show = JOinConS();
                              join_con = _active_gra;
                              create_con = _notactive_gra;
                              my_con = _notactive_gra;
                            }
                          });
                        },
                        child: Container(
                          height: 36,
                          width: 105,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: join_con),
                          child: Center(
                              child: Text(
                            "Join Contest",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (create_con != _active_gra) {
                              _show = CreateConS(
                                size: size,
                              );
                              create_con = _active_gra;
                              join_con = _notactive_gra;
                              my_con = _notactive_gra;
                            }
                          });
                        },
                        child: Container(
                          height: 36,
                          width: 105,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: create_con),
                          child: Center(
                              child: Text(
                            "Create Contest",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (my_con != _active_gra) {
                              _show = MyConS();
                              my_con = _active_gra;
                              create_con = _notactive_gra;
                              join_con = _notactive_gra;
                            }
                          });
                        },
                        child: Container(
                          height: 36,
                          width: 105,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: my_con),
                          child: Center(
                              child: Text(
                            "Created",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _show
              ],
            ),
          ),
        ));
  }
}

class CreateConS extends StatefulWidget {
  const CreateConS({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;

  @override
  State<CreateConS> createState() => _CreateConSState();
}

class _CreateConSState extends State<CreateConS> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Make it Private",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Switch(
                  value: _private,
                  onChanged: (val) {
                    setState(() {
                      _private = val;
                    });
                  },
                  inactiveTrackColor: Colors.grey.withOpacity(0.4),
                  inactiveThumbColor: Color.fromRGBO(218, 62, 45, 1),
                  thumbColor:
                      MaterialStateProperty.all(Color.fromRGBO(218, 62, 45, 1)),
                )
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: widget.size.height * 48 / 812,
              width: widget.size.width * 339 / 375,
              decoration: BoxDecoration(
                  color: Color(0xff222633),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: ContestNameC,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("Contest Name cannot be empty");
                    }
                    },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10),
                    border: InputBorder.none,
                    hintText: "Enter contest name",
                    hintStyle: TextStyle(color: Color(0xff6B7076))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: widget.size.height * 48 / 812,
              width: widget.size.width * 339 / 375,
              decoration: BoxDecoration(
                  color: Color(0xff222633),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                    "Select Entry Fee",
                    style: TextStyle(color: Color(0xff6B7076)),
                  ),
                  Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _amount,
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Color(0xff020C12),
                        items: [
                          DropdownMenuItem(
                            child: Text("₹20"),
                            value: 20,
                          ),
                          DropdownMenuItem(
                            child: Text("₹50"),
                            value: 50,
                          ),
                          DropdownMenuItem(
                            child: Text("₹100"),
                            value: 100,
                          ),
                          DropdownMenuItem(
                            child: Text("₹200"),
                            value: 200,
                          ),
                          DropdownMenuItem(
                            child: Text("₹300"),
                            value: 300,
                          ),
                          DropdownMenuItem(
                            child: Text("₹400"),
                            value: 400,
                          ),
                          DropdownMenuItem(
                            child: Text("₹500"),
                            value: 500,
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _amount = val as int;
                          });
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: widget.size.height * 48 / 812,
              width: widget.size.width * 339 / 375,
              decoration: BoxDecoration(
                  color: Color(0xff222633),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                    "Select Contest size",
                    style: TextStyle(color: Color(0xff6B7076)),
                  ),
                  Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Color(0xff020C12),
                        value: _con_size,
                        items: [
                          DropdownMenuItem(
                            child: Text("2"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("4"),
                            value: 4,
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _con_size = val as int;
                          });
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: _private,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: widget.size.height * 48 / 812,
                width: widget.size.width * 349 / 375,
                decoration: BoxDecoration(
                    color: Color(0xff222633),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: PasswordC,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("Contest Pin cannot be empty");
                    }if( value.length!=4){
                      return ("Please Enter 4 digit Pin");
                    }
                    },
                  cursorColor: Colors.white,
                  maxLength: 4,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10),
                      border: InputBorder.none,
                      hintText: "Set Pin",
                      hintStyle: TextStyle(color: Color(0xff6B7076))),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Winnings",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Rank",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                Spacer(),
                Text("Amount",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(20, 39, 49, 1),
                    Color.fromRGBO(0, 0, 0, 0),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "01",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    "₹${((_con_size * _amount) / 1.1765).ceil()}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 120 / 812,
            ),
            GestureDetector(
              onTap: () {
                if (_con_size == 4 && _formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CreateContest(
                        isActive: isActive,
                        winnerisME: winnerisME,
                        balance: _balance_amount,
                        prize: _amount.toString(),
                        pass: int.parse(PasswordC.text),
                        private: _private,
                        winnerPrize: "₹${((_con_size * _amount) / 1.18).ceil()}",
                        ContestName: ContestNameC.text,
                      ),
                    ),
                  );
                }
                if (_con_size == 3  && _formKey.currentState!.validate()) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CreateContest3v3(
                            balance: _balance_amount,
                            prize: _amount.toString(),
                            pass: int.parse(PasswordC.text),
                            private: _private,
                            winnerPrize:
                                "₹${((_con_size * _amount) / 1.18).ceil()}",
                            ContestName: ContestNameC.text,
                          )));
                }
                if (_con_size == 2  && _formKey.currentState!.validate()) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CreateContest2v2(
                            isActive: isActive,
                            winnerisME: winnerisME,
                            balance: _balance_amount,
                            prize: _amount.toString(),
                            pass: int.parse(PasswordC.text),
                            private: _private,
                            winnerPrize:
                                "₹${((_con_size * _amount) / 1.18).ceil()}",
                            ContestName: ContestNameC.text,
                          )));
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 46 / 812,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(175, 47, 32, 1),
                      Color.fromRGBO(218, 62, 45, 1),
                      Color.fromRGBO(244, 157, 99, 1),
                      Color.fromRGBO(195, 188, 138, 1)
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 50 / 812,
            ),
          ],
        ),
      ),
    );
  }
}

class JOinConS extends StatefulWidget {
  JOinConS({
    Key? key,
  }) : super(key: key);

  @override
  State<JOinConS> createState() => _JOinConSState();
}

class _JOinConSState extends State<JOinConS> {
  String cid = "";

  Widget contests = Container(
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Contests").snapshots(),
        builder: (context, AsyncSnapshot futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return futureSnapshot.hasData
                ? futureSnapshot.data.docs.isNotEmpty
                    ? Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: futureSnapshot.requireData.size,
                            itemBuilder: (context, index) {
                              if (futureSnapshot.requireData.docs[index]
                                          ["CreatorID"] !=
                                      app_user.uid &&
                                  !futureSnapshot
                                      .requireData.docs[index]["Participations"]
                                      .contains(app_user.uid) &&
                                  DateTime.parse(futureSnapshot.requireData
                                                  .docs[index]["DateTime"] +
                                              "0")
                                          .add(Duration(days: 1))
                                          .difference(DateTime.now()) >
                                      Duration(seconds: 0)) {
                                // isActive =true;
                                int join = 0;
                                print(DateTime.parse(futureSnapshot.requireData
                                            .docs[index]["DateTime"] +
                                        "0")
                                    .add(Duration(days: 1))
                                    .difference(DateTime.now()));
                                for (var i in futureSnapshot.requireData
                                    .docs[index]["Participations"]) {
                                  if (i != "") {
                                    join += 1;
                                  }
                                }
                                return _joinBlock(
                                    contestID: futureSnapshot
                                        .requireData.docs[index]["ContestID"],
                                    participants: join,
                                    players: futureSnapshot.requireData
                                        .docs[index]["Participations"].length,
                                    EntryFee: futureSnapshot
                                        .requireData.docs[index]["EntryFee"],
                                    winningPrize: futureSnapshot
                                        .requireData.docs[index]["winnerPrize"],
                                    isVisible: true,
                                    CreatorID: futureSnapshot
                                        .requireData.docs[index]["CreatorID"]);
                              } else
                                return Container(
                                  color: Colors.transparent,
                                );
                            }),
                      )
                    : Container(
                        color: Colors.transparent,
                        child: Text("No Contest available"),
                      )
                : Container(
                    color: Colors.transparent,
                    child: Text("No Contest available"),
                  );
          }
        }),
  );

  Future<void> get_searched_contest(String id) async {
    print(id);
    var key =
        await FirebaseFirestore.instance.collection("Contests").doc(id).get();
    int join = 0;
    for (var i in (key.data() as dynamic)["Participations"]) {
      if (i != "") {
        join += 1;
      }
    }
    contests = Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          _joinBlock(
              contestID: (key.data() as dynamic)["ContestID"],
              participants: join,
              players: (key.data() as dynamic)["Participations"].length,
              EntryFee: (key.data() as dynamic)["EntryFee"],
              winningPrize: (key.data() as dynamic)["winnerPrize"],
              isVisible:
                  DateTime.parse((key.data() as dynamic)["DateTime"] + "0")
                              .add(Duration(days: 1))
                              .difference(DateTime.now()) >
                          Duration(seconds: 0) &&
                      (key.data() as dynamic)["CreatorID"] != app_user.uid &&
                      !(key.data() as dynamic)["Participations"]
                          .contains(app_user.uid),
              CreatorID: (key.data() as dynamic)["CreatorID"])
        ],
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          height: size.height * 42 / 812,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                onChanged: (val) {
                  cid = val;
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search by contest code.",
                    hintStyle: TextStyle(color: Colors.white)),
              )),
              Spacer(),
              GestureDetector(
                onTap: () => {get_searched_contest(cid)},
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        contests
      ],
    );
  }
}

class MyConS extends StatelessWidget {
  const MyConS({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          height: MediaQuery.of(context).size.height * 42 / 812,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search by contest code.",
                    hintStyle: TextStyle(color: Colors.white)),
              )),
              Spacer(),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(_auth.currentUser!.uid)
                  .collection("Contests")
                  .snapshots(),
              builder: (context, AsyncSnapshot futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return futureSnapshot.hasData
                      ? futureSnapshot.data.docs.isNotEmpty
                          ? Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: futureSnapshot.requireData.size,
                                  itemBuilder: (context, index) {
                                    int join = 0;
                                    for (var i in futureSnapshot.requireData
                                        .docs[index]["Participations"]) {
                                      if (i != "") {
                                        join += 1;
                                      }
                                    }
                                    return _joinBlockMy(
                                      contestID: futureSnapshot
                                          .requireData.docs[index]["ContestID"],
                                      participants: join,
                                      players: futureSnapshot.requireData
                                          .docs[index]["Participations"].length,
                                      EntryFee: futureSnapshot
                                          .requireData.docs[index]["EntryFee"],
                                      winningPrize: futureSnapshot.requireData
                                          .docs[index]["winnerPrize"],
                                      isVisible: true,
                                    );
                                  }),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.transparent,
                              child: Center(
                                child: Text("No contests created",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ))
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("No contests created",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ));
                }
              }),
        )
      ],
    );
  }
}

class _joinBlock extends StatelessWidget {
  String? contestID;
  String? winningPrize;
  String? EntryFee;
  int? players, participants;
  bool isVisible;
  String? CreatorID;
  _joinBlock(
      {Key? key,
      this.contestID,
      this.winningPrize,
      this.EntryFee,
      required this.players,
      required this.participants,
      required this.isVisible,
      this.CreatorID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 12),
      height: MediaQuery.of(context).size.height * 163 / 812,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(20, 30, 49, 1),
            Color.fromRGBO(1, 1, 1, 0.4)
          ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Contest ID : ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(new ClipboardData(text: contestID));
                          Fluttertoast.showToast(msg: "Copied");
                        },
                        child: Text(contestID!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible: isVisible && participants != players,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xff323C43),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return JoinContest(
                                isActive: isActive,
                                winnerisME: winnerisME,
                                balance: _balance_amount,
                                ContestID: contestID,
                                contestSize: players,
                                CreatorID: CreatorID,
                                EntryFee: EntryFee,
                                winnerPrize: winningPrize,
                              );
                            }));
                          },
                          child: Text(
                            "Join",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21, top: 6),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: "",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                    children: [
                      TextSpan(
                        text: winningPrize,
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21, top: 2),
            child: RichText(
              text: TextSpan(
                text: "PRIZE",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 21, right: 21, top: 10, bottom: 4),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 293 / 375,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(150, 156, 163, 1)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *
                        ((participants! / players!) * 310) /
                        375,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(255, 15, 0, 1),
                          Color.fromRGBO(255, 106, 106, 1)
                        ])),
                  )
                ],
              )),
          Row(
            children: [
              Spacer(),
              Text(
                "$players Players",
                style: TextStyle(
                  color: Color(0xff969CA3),
                ),
              ),
              SizedBox(
                width: 21,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21, right: 21, top: 6),
            child: Row(
              children: [
                Text(
                  "Entery Fee: ₹" + EntryFee!,
                  style: TextStyle(
                    color: Color(0xff969CA3),
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: participants == players,
                  child: Text(
                    "Full",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _joinBlockMy extends StatelessWidget {
  String? contestID;
  String? winningPrize;
  String? EntryFee;
  int? players, participants;
  bool isVisible;
  String? CreatorID;
  String _copy = "Copy Me";
  _joinBlockMy(
      {Key? key,
      this.contestID,
      this.winningPrize,
      this.EntryFee,
      required this.players,
      required this.participants,
      required this.isVisible,
      this.CreatorID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 12),
      height: MediaQuery.of(context).size.height * 163 / 812,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(20, 30, 49, 1),
            Color.fromRGBO(1, 1, 1, 0.4)
          ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Contest ID : ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(new ClipboardData(text: contestID));
                          Fluttertoast.showToast(msg: "Copied");
                        },
                        child: Text(contestID!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible: isVisible,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xff323C43),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Share.share(
                                "Hey, look at the contest I'm participating in vote me and you can also win upto Rs. 2000 by competing in the contest with id: $contestID",
                                subject: "Fotoclash Contest Invitation!");
                          },
                          child: Text(
                            "Share",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21, top: 6),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: "",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                    children: [
                      TextSpan(
                        text: winningPrize,
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21, top: 2),
            child: RichText(
              text: TextSpan(
                text: "PRIZE",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 21, right: 21, top: 10, bottom: 4),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 293 / 375,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(150, 156, 163, 1)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *
                        ((participants! / players!) * 310) /
                        375,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(255, 15, 0, 1),
                          Color.fromRGBO(255, 106, 106, 1)
                        ])),
                  )
                ],
              )),
          Row(
            children: [
              Spacer(),
              Text(
                "$players Players",
                style: TextStyle(
                  color: Color(0xff969CA3),
                ),
              ),
              SizedBox(
                width: 21,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21, right: 21, top: 6),
            child: Row(
              children: [
                Text(
                  "Entery Fee: ₹" + EntryFee!,
                  style: TextStyle(
                    color: Color(0xff969CA3),
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: participants == players,
                  child: Text(
                    "Full",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
