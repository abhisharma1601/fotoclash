import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("background.png"), fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pop(context);
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
                      "LeaderBoard",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         _otherswinners(context,
              //             "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         const Text(
              //           "Lucy",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 18),
              //         ),
              //         const SizedBox(
              //           height: 3,
              //         ),
              //         const Text(
              //           "170 W 16L",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w300,
              //               fontSize: 14),
              //         ),
              //       ],
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width * 18 / 812),
              //     Column(
              //       children: [
              //         _firstwinners(
              //           context,
              //           "https://i.insider.com/5e820b04671de06758588fb8?width=700",
              //         ),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         const Text(
              //           "Lucy",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 18),
              //         ),
              //         const SizedBox(
              //           height: 3,
              //         ),
              //         const Text(
              //           "170 W 16L",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w300,
              //               fontSize: 14),
              //         ),
              //       ],
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width * 18 / 812),
              //     Column(
              //       children: [
              //         _otherswinners(context,
              //             "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         const Text(
              //           "Lucy",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 18),
              //         ),
              //         const SizedBox(
              //           height: 3,
              //         ),
              //         const Text(
              //           "170 W 16L",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w300,
              //               fontSize: 14),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 2,
              ),

              Container(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Winners")
                        .orderBy("Wins", descending: true)
                        .get(),
                    builder: (context, AsyncSnapshot futureSnapshot) {
                      if (futureSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return futureSnapshot.hasData
                            ? Container(
                                color: Colors.transparent,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: futureSnapshot.requireData.size,
                                    itemBuilder: (context, index) {
                                      if (index < 15) {
                                        return LeaderWinner(
                                          id: futureSnapshot
                                              .requireData.docs[index]
                                              .data()["ID"],
                                          wins: futureSnapshot
                                              .requireData.docs[index]
                                              .data()["Wins"]
                                              .toString(),
                                          prize: futureSnapshot
                                              .requireData.docs[index]
                                              .data()["Total Winnigs"]
                                              .toString(),
                                          index: index + 1,
                                          name: futureSnapshot
                                              .requireData.docs[index]
                                              .data()["uname"]
                                              .toString(),
                                          image: futureSnapshot
                                              .requireData.docs[index]
                                              .data()["image"]
                                              .toString(),
                                        );
                                      } else {
                                        return Container(
                                          color: Colors.transparent,
                                        );
                                      }
                                    }),
                              )
                            : Container(
                                color: Colors.transparent,
                              );
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}

class LeaderWinner extends StatelessWidget {
  LeaderWinner(
      {required this.id,
      required this.wins,
      required this.prize,
      required this.name,
      required this.image,
      required this.index});
  String id, wins, prize, name, image;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 6 / 375,
          ),
          Text(
            index.toString(),
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 15 / 375,
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 16 / 375,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 8 / 812,
              ),
              Row(
                children: [
                  Text(
                    "$wins Wins",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 12 / 375,
                  ),
                  Text(
                    "₹ $prize",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

_firstwinners(
  BuildContext context,
  String winnerUrl,
) {
  return Container(
    height: MediaQuery.of(context).size.height * 80 / 812,
    width: MediaQuery.of(context).size.width * 80 / 375,
    decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage(winnerUrl), fit: BoxFit.cover),
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
    ),
  );
}

_otherswinners(
  BuildContext context,
  String winnerUrl,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 60),
    child: Container(
      height: MediaQuery.of(context).size.height * 60 / 812,
      width: MediaQuery.of(context).size.width * 60 / 375,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(winnerUrl), fit: BoxFit.cover),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      ),
    ),
  );
}
