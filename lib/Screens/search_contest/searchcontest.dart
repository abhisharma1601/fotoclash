import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Screens/contest_2v2.dart';
import 'package:fotoclash/Screens/contest_4v4.dart';

class SearchContest extends StatefulWidget {
  const SearchContest({Key? key}) : super(key: key);

  @override
  State<SearchContest> createState() => _SearchContestState();
}

class _SearchContestState extends State<SearchContest> {
  List<Widget> contest = [];
  String contestID = "";

  void get_contest(String cid) async {
    contest = [];
    var key =
        await FirebaseFirestore.instance.collection("Contests").doc(cid).get();
    int join = 0;
    for (var i in (key.data() as dynamic)["Participations"]) {
      if (i != "") {
        join += 1;
      }
    }
    contest.add(
      _ContestBlock(
          images: (key.data() as dynamic)["images"],
          likes: (key.data() as dynamic)["Likes"],
          contestID: (key.data() as dynamic)["ContestID"],
          winningPrize: (key.data() as dynamic)["winnerPrize"],
          EntryFee: (key.data() as dynamic)["EntryFee"],
          players: (key.data() as dynamic)["Participations"].length,
          participants: join,
          isVisible: (DateTime.parse((key.data() as dynamic)["DateTime"] + "0")
                  .add(Duration(days: 1))
                  .difference(DateTime.now()) >
              Duration(seconds: 0)),
          CreatorID: (key.data() as dynamic)["CreatorID"]),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 40 / 812,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        contestID = val;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search by contest code.",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        get_contest(contestID);
                      },
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
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: contest.length != 0 ? contest : [],
            )
          ],
        ),
      ),
    );
  }
}

class _ContestBlock extends StatelessWidget {
  String? contestID;
  String? winningPrize;
  String? EntryFee;
  int? players, participants;
  bool isVisible;
  List images, likes;
  String? CreatorID;
  _ContestBlock(
      {Key? key,
      required this.contestID,
      required this.winningPrize,
      required this.EntryFee,
      required this.players,
      required this.images,
      required this.likes,
      required this.participants,
      required this.isVisible,
      required this.CreatorID})
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Row(
                      children: [
                        Text(
                          "Contest ID :",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(contestID!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ],
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
                          print(players);
                          print(participants);
                          if (players != participants) {
                            Fluttertoast.showToast(
                                msg: "Can't vote! Contest is not full!");
                          } else {
                            if (participants == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Contest2v2(
                                          images: images,
                                          likes: likes,
                                          contest_id: contestID!)));
                            } else if (participants == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Contest4v4(
                                          images: images,
                                          likes: likes,
                                          contest_id: contestID!)));
                            }
                          }
                        },
                        child: Text(
                          "Vote",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  )
                ],
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
