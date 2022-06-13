import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/search_contest/searchcontest.dart';
import 'package:fotoclash/Screens/single_image.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import '../main.dart';
import 'contest_2v2.dart';
import 'drawer_details.dart';

class Contest4v4 extends StatefulWidget {
  Contest4v4(
      {required this.images,
      required this.likes,
      required this.contest_id,
      required this.participations});
  List images;
  List likes;
  String contest_id;
  List participations;
  @override
  _Contest4v4State createState() => _Contest4v4State();
}

class _Contest4v4State extends State<Contest4v4> {
  bool isLiked = false;
  int index = 0;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        drawer: const Drawer(
          backgroundColor: Color(0xffbac333863),
          child: ProfileDrawer(),
        ),
        body: _Comp4v4(
            contest_id: widget.contest_id,
            images: widget.images,
            likes: widget.likes,
            scaffoldkey: _scaffoldkey,
            isLiked: isLiked,
            participations: widget.participations));
  }
}

//  _Comp4v4(images: images, scaffoldkey: _scaffoldkey, isLiked: isLiked),

class _Comp4v4 extends StatefulWidget {
  const _Comp4v4({
    Key? key,
    required this.images,
    required this.likes,
    required this.participations,
    required this.contest_id,
    required GlobalKey<ScaffoldState> scaffoldkey,
    required this.isLiked,
  })  : _scaffoldkey = scaffoldkey,
        super(key: key);

  final List images, likes, participations;
  final GlobalKey<ScaffoldState> _scaffoldkey;
  final bool isLiked;
  final String contest_id;

  @override
  State<_Comp4v4> createState() => _Comp4v4State();
}

class _Comp4v4State extends State<_Comp4v4> {
  Color like1 = Colors.white;
  Color like2 = Colors.white;
  Color like3 = Colors.white;
  Color like4 = Colors.white;

  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("background.png"), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      Column(children: [
        // SizedBox(height: 50,),
        Row(children: [
          imageContainer(context, widget.images[0], widget.participations[0]),
          imageContainer(context, widget.images[1], widget.participations[1])
        ]),

        Row(children: [
          imageContainer(context, widget.images[2], widget.participations[2]),
          imageContainer(context, widget.images[3], widget.participations[3])
        ])
      ]),
      Positioned(
        left: MediaQuery.of(context).size.width * 130 / 375,
        top: MediaQuery.of(context).size.height * 360 / 865,
        child:
            Image(height: 110, width: 110, image: AssetImage("assets/vs.png")),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 30),
        child: IconButton(
            onPressed: () {
              widget._scaffoldkey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            )),
      ),
      Positioned(
        left: MediaQuery.of(context).size.width * 310 / 375,
        top: 35,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchContest()));
          },
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      Positioned(
        child: GestureDetector(
          onTap: () {
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(widget.contest_id)
                .set({
              "Voters": FieldValue.arrayUnion([app_user.uid])
            }, SetOptions(merge: true));
            if (like1 == Colors.white) {
              setState(() {
                like1 = Colors.red;
              });
              widget.likes[0] += 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
              if (like2 == Colors.red) {
                setState(() {
                  like2 = Colors.white;
                  widget.likes[1] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like3 == Colors.red) {
                setState(() {
                  like3 = Colors.white;
                  widget.likes[2] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like4 == Colors.red) {
                setState(() {
                  like4 = Colors.white;
                  widget.likes[3] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
            } else if (like1 == Colors.red) {
              setState(() {
                like1 = Colors.white;
              });
              widget.likes[0] -= 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
            }
          },
          child: Container(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: like1,
                  size: 35,
                ),
                Text(
                  widget.likes[0].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          ),
        ),
        left: MediaQuery.of(context).size.width * 187 / 375,
        right: 0,
        top: MediaQuery.of(context).size.height * 330 / 812,
      ),
      Positioned(
        child: GestureDetector(
          onTap: () {
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(widget.contest_id)
                .set({
              "Voters": FieldValue.arrayUnion([app_user.uid])
            }, SetOptions(merge: true));
            if (like2 == Colors.white) {
              setState(() {
                like2 = Colors.red;
              });
              widget.likes[1] += 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
              if (like1 == Colors.red) {
                setState(() {
                  like1 = Colors.white;
                  widget.likes[0] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like3 == Colors.red) {
                setState(() {
                  like3 = Colors.white;
                  widget.likes[2] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like4 == Colors.red) {
                setState(() {
                  like4 = Colors.white;
                  widget.likes[3] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
            } else if (like2 == Colors.red) {
              setState(() {
                like2 = Colors.white;
              });
              widget.likes[1] -= 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
            }
          },
          child: Container(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: like2,
                  size: 35,
                ),
                Text(
                  widget.likes[1].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          ),
        ),
        left: 0,
        right: MediaQuery.of(context).size.width * 185 / 375,
        top: MediaQuery.of(context).size.height * 330 / 812,
      ),
      Positioned(
        child: GestureDetector(
          onTap: () {
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(widget.contest_id)
                .set({
              "Voters": FieldValue.arrayUnion([app_user.uid])
            }, SetOptions(merge: true));
            if (like3 == Colors.white) {
              setState(() {
                like3 = Colors.red;
                widget.likes[2] += 1;
                FirebaseFirestore.instance
                    .collection("Contests")
                    .doc(widget.contest_id)
                    .set({"Likes": widget.likes}, SetOptions(merge: true));
              });

              if (like1 == Colors.red) {
                setState(() {
                  like1 = Colors.white;
                  widget.likes[0] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like2 == Colors.red) {
                setState(() {
                  like3 = Colors.white;
                  widget.likes[2] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like4 == Colors.red) {
                setState(() {
                  like4 = Colors.white;
                  widget.likes[3] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
            } else if (like3 == Colors.red) {
              setState(() {
                like3 = Colors.white;
              });
              widget.likes[2] -= 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
            }
          },
          child: Container(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: like3,
                  size: 35,
                ),
                Text(
                  widget.likes[2].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          ),
        ),
        left: 0,
        right: MediaQuery.of(context).size.width * 185 / 375,
        top: MediaQuery.of(context).size.height * 410 / 812,
      ),
      Positioned(
        child: GestureDetector(
          onTap: () {
            FirebaseFirestore.instance
                .collection("Contests")
                .doc(widget.contest_id)
                .set({
              "Voters": FieldValue.arrayUnion([app_user.uid])
            }, SetOptions(merge: true));
            if (like4 == Colors.white) {
              setState(() {
                like4 = Colors.red;
              });
              widget.likes[3] += 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
              if (like1 == Colors.red) {
                setState(() {
                  like1 = Colors.white;
                  widget.likes[0] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like2 == Colors.red) {
                setState(() {
                  like2 = Colors.white;
                  widget.likes[1] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
              if (like3 == Colors.red) {
                setState(() {
                  like3 = Colors.white;

                  widget.likes[2] -= 1;
                  FirebaseFirestore.instance
                      .collection("Contests")
                      .doc(widget.contest_id)
                      .set({"Likes": widget.likes}, SetOptions(merge: true));
                });
              }
            } else if (like4 == Colors.red) {
              setState(() {
                like4 = Colors.white;
              });
              widget.likes[3] -= 1;
              FirebaseFirestore.instance
                  .collection("Contests")
                  .doc(widget.contest_id)
                  .set({"Likes": widget.likes}, SetOptions(merge: true));
            }
          },
          child: Container(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: like4,
                  size: 35,
                ),
                Text(
                  widget.likes[3].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          ),
        ),
        left: MediaQuery.of(context).size.width * 187 / 375,
        right: 0,
        top: MediaQuery.of(context).size.height * 410 / 812,
      ),
      Positioned(
          left: MediaQuery.of(context).size.width * 330 / 375,
          top: MediaQuery.of(context).size.height * 700 / 812,
          child: InkWell(
            onTap: () {
              Share.share(
                  "Hey, look at the contest I'm participating in vote me and you can also win upto Rs. 2000 by competing in the contest with id: ${widget.contest_id}",
                  subject: "Fotoclash Contest Invitation!");
              // showModalBottomSheet(
              //     shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(24),
              //         topRight: Radius.circular(24),
              //       ),
              //     ),
              //     context: context,
              //     builder: (context) {
              //       return SingleChildScrollView(
              //         child: Container(
              //           decoration: const BoxDecoration(
              //             color: Color.fromRGBO(5, 16, 32, 1),
              //             borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(24),
              //               topRight: Radius.circular(24),
              //             ),
              //           ),
              //           child: Column(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(16.0),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     const Icon(
              //                       Icons.share,
              //                       color: Colors.red,
              //                     ),
              //                     const SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Share this contest to",
              //                       style: TextStyle(
              //                           color: Colors.orange[400],
              //                           fontWeight: FontWeight.w700,
              //                           fontSize: 16),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: MediaQuery.of(context).size.height *
              //                     400 /
              //                     812,
              //                 child: ListView.builder(
              //                     itemCount: 10,
              //                     itemBuilder: (context, index) {
              //                       return ListTile(
              //                           leading: const CircleAvatar(
              //                             backgroundImage: NetworkImage(
              //                                 "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
              //                           ),
              //                           title: const Text(
              //                             "Olivia Samantha",
              //                             style: TextStyle(
              //                                 color: Colors.white,
              //                                 fontWeight: FontWeight.w700,
              //                                 fontSize: 16),
              //                           ),
              //                           trailing: Container(
              //                             height: MediaQuery.of(context)
              //                                     .size
              //                                     .height *
              //                                 35 /
              //                                 812,
              //                             width: MediaQuery.of(context)
              //                                     .size
              //                                     .width *
              //                                 70 /
              //                                 375,
              //                             decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(6),
              //                                 gradient:
              //                                     const LinearGradient(colors: [
              //                                   Color.fromRGBO(175, 47, 32, 1),
              //                                   Color.fromRGBO(218, 62, 45, 1),
              //                                   Color.fromRGBO(244, 157, 99, 1),
              //                                   Color.fromRGBO(
              //                                       195, 188, 138, 1),
              //                                 ])),
              //                             child: ElevatedButton(
              //                               style: ButtonStyle(
              //                                   elevation:
              //                                       MaterialStateProperty.all(
              //                                           0),
              //                                   alignment: Alignment.center,
              //                                   padding:
              //                                       MaterialStateProperty.all(
              //                                           const EdgeInsets.only(
              //                                               right: 15,
              //                                               left: 15,
              //                                               top: 8,
              //                                               bottom: 8)),
              //                                   backgroundColor:
              //                                       MaterialStateProperty.all(
              //                                           Colors.transparent),
              //                                   shape:
              //                                       MaterialStateProperty.all(
              //                                     RoundedRectangleBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 15)),
              //                                   )),
              //                               onPressed: () {},
              //                               child: const Text(
              //                                 "Send",
              //                                 style: TextStyle(
              //                                     color: Colors.white,
              //                                     fontSize: 16),
              //                               ),
              //                             ),
              //                           ));
              //                     }),
              //               )
              //             ],
              //           ),
              //         ),
              //       );
              //     });
            },
            child: const Icon(
              Icons.share_outlined,
              color: Colors.red,
              size: 28,
            ),
          )),
    ]);
  }
}

imageContainer(BuildContext context, String image, String Participations) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SingleImage(
                image: image,
                Participations: Participations,
              )));
    },
    child: Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      width: MediaQuery.of(context).size.width * 187 / 375,
      height: MediaQuery.of(context).size.height * 420 / 865,
    ),
  );
}

likebuttom(BuildContext context, bool liked, int left, int top, int count,
    String id, int index, List likes) {
  return Positioned(
    left: MediaQuery.of(context).size.width * left / 375,
    top: MediaQuery.of(context).size.height * top / 812,
    child: LikeButton(
      size: 40,
      isLiked: liked,
      likeCount: count,
      likeBuilder: (liked) {
        likes[index] += 1;
        FirebaseFirestore.instance
            .collection("Contests")
            .doc(id)
            .set({"Likes": likes}, SetOptions(merge: true));
        final color = liked ? Colors.red : Colors.white;
        return Icon(
          Icons.favorite,
          color: color,
          size: 36,
        );
      },
      countBuilder: (count, isliked, text) {
        print(isliked);
        likes[index] = isliked ? count! + 1 : count! + 0;
        FirebaseFirestore.instance
            .collection("Contests")
            .doc(id)
            .set({"Likes": likes}, SetOptions(merge: true));
        final color = liked ? Colors.black : Colors.white;
        return Text(
          text,
          style: TextStyle(
              color: color, fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    ),
  );
}
