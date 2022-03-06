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
                height: 40,
              ),
              Row(
                children: [
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
                    width: MediaQuery.of(context).size.width * 120 / 375,
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
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 100 / 375,
                  ),
                  const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      _otherswinners(context,
                          "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Lucy",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "170 W 16L",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 18 / 812),
                  Column(
                    children: [
                      _firstwinners(
                        context,
                        "https://i.insider.com/5e820b04671de06758588fb8?width=700",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Lucy",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "170 W 16L",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 18 / 812),
                  Column(
                    children: [
                      _otherswinners(context,
                          "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Lucy",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "170 W 16L",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 550 / 812,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(5, 16, 32, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                        const Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                          size: 28,
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*6/375 ,),
                        const Text(
                          "4",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*12/375 ,),
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                              "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*16/375 ,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Olivia Samantha",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            SizedBox(height:MediaQuery.of(context).size.height*8/812 ,),
                            Row(
                              children:  [
                                const Text(
                                  "15 Wins",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                SizedBox(width:MediaQuery.of(context).size.width*12/375 ,),
                                const Text(
                                  "15 Lose",
                                  style: TextStyle(
                                      color: Colors.red,
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
                    }),
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
