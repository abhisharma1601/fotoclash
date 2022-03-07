import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/single_image.dart';
import 'package:like_button/like_button.dart';
import 'contest_2v2.dart';
import 'drawer_details.dart';

class Contest4v4 extends StatefulWidget {
  Contest4v4(
      {required this.images, required this.likes, required this.contest_id});
  List images;
  List likes;
  String contest_id;

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
        body: _Comp4v4(
            contest_id: widget.contest_id,
            images: widget.images,
            likes: widget.likes,
            scaffoldkey: _scaffoldkey,
            isLiked: isLiked));
  }
}

//  _Comp4v4(images: images, scaffoldkey: _scaffoldkey, isLiked: isLiked),

class _Comp4v4 extends StatelessWidget {
  const _Comp4v4({
    Key? key,
    required this.images,
    required this.likes,
    required this.contest_id,
    required GlobalKey<ScaffoldState> scaffoldkey,
    required this.isLiked,
  })  : _scaffoldkey = scaffoldkey,
        super(key: key);

  final List images, likes;
  final GlobalKey<ScaffoldState> _scaffoldkey;
  final bool isLiked;
  final String contest_id;

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
          imageContainer(context, images[0]),
          imageContainer(context, images[1])
        ]),

        Row(children: [
          imageContainer(context, images[2]),
          imageContainer(context, images[3])
        ])
      ]),
      Positioned(
        left: MediaQuery.of(context).size.width * 160 / 375,
        top: MediaQuery.of(context).size.height * 380 / 865,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(195, 188, 138, 1),
                Color.fromRGBO(244, 157, 99, 1),
                Color.fromRGBO(218, 62, 45, 1),
                Color.fromRGBO(175, 47, 32, 1),
              ])),
          child: const CircleAvatar(
            child: Text(
              "VS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            radius: 30,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
            onPressed: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            )),
      ),
      Positioned(
        left: MediaQuery.of(context).size.width * 310 / 375,
        top: 18,
        child: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      likebuttom(context, isLiked, 60, 350, likes[0], contest_id, 0, likes),
      likebuttom(context, isLiked, 250, 350, likes[1], contest_id, 1, likes),
      likebuttom(context, isLiked, 60, 400, likes[2], contest_id, 2, likes),
      likebuttom(context, isLiked, 250, 400, likes[3], contest_id, 3, likes),
      Positioned(
          left: MediaQuery.of(context).size.width * 330 / 375,
          top: MediaQuery.of(context).size.height * 700 / 812,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(5, 16, 32, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.share,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Share this contest to",
                                    style: TextStyle(
                                        color: Colors.orange[400],
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  400 /
                                  812,
                              child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: const CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
                                        ),
                                        title: const Text(
                                          "Olivia Samantha",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                        trailing: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              35 /
                                              812,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              70 /
                                              375,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              gradient:
                                                  const LinearGradient(colors: [
                                                Color.fromRGBO(175, 47, 32, 1),
                                                Color.fromRGBO(218, 62, 45, 1),
                                                Color.fromRGBO(244, 157, 99, 1),
                                                Color.fromRGBO(
                                                    195, 188, 138, 1),
                                              ])),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                alignment: Alignment.center,
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            right: 15,
                                                            left: 15,
                                                            top: 8,
                                                            bottom: 8)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                )),
                                            onPressed: () {},
                                            child: const Text(
                                              "Send",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ));
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: const Icon(
              Icons.share_outlined,
              color: Colors.red,
              size: 28,
            ),
          )),
      Positioned(
          left: MediaQuery.of(context).size.width * 30 / 375,
          top: MediaQuery.of(context).size.height * 700 / 812,
          child: const Icon(
            Icons.comment,
            color: Colors.red,
            size: 28,
          ))
    ]);
  }
}

imageContainer(BuildContext context, String image) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SingleImage(
                image: image,
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
        // likes[index] += 1;
        // FirebaseFirestore.instance
        //     .collection("Contests")
        //     .doc(id)
        //     .set({"Likes": likes}, SetOptions(merge: true));
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
