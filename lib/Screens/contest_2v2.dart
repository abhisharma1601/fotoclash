import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/drawer_details.dart';
import 'package:like_button/like_button.dart';

class Contest2v2 extends StatefulWidget {
  const Contest2v2({Key? key}) : super(key: key);

  @override
  _Contest2v2State createState() => _Contest2v2State();
}

class _Contest2v2State extends State<Contest2v2> {
  bool isLiked = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  List images = [
    "https://cdn.vox-cdn.com/thumbor/J2XSqgAqREtpkGAWa6rMhkHA1Y0=/0x0:1600x900/1400x933/filters:focal(672x322:928x578):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/66320060/Tanjiro__Demon_Slayer_.0.png",
    "https://i.insider.com/5e820b04671de06758588fb8?width=700",
    "https://pbs.twimg.com/profile_images/1402894430173110274/5zrO8sS5_400x400.jpg",
    "https://www.cartoonbrew.com/wp-content/uploads/2020/10/demon_slayer_mugen-580x326.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: const Drawer(
        backgroundColor: Color(0xffbac333863),
        child: ProfileDrawer(),
      ),
      extendBody: true,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background.png"), fit: BoxFit.cover)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(children: [
            imageContainer(context, images[0]),
            imageContainer(context, images[1])
          ]),
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
          padding: const EdgeInsets.all(20.0),
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
          top: 24,
          child: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        likebuttom(context, isLiked, 60, 560),
        likebuttom(context, isLiked, 250, 560),
        Positioned(
            left: MediaQuery.of(context).size.width * 330 / 375,
            top: MediaQuery.of(context).size.height * 700 / 812,
            child: const Icon(
              Icons.share_outlined,
              color: Colors.red,
              size: 28,
            )),
        Positioned(
            left: MediaQuery.of(context).size.width * 30 / 375,
            top: MediaQuery.of(context).size.height * 700 / 812,
            child: const Icon(
              Icons.comment,
              color: Colors.red,
              size: 28,
            ))
      ]),
    );
  }
}

imageContainer(BuildContext context, String image) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
    width: MediaQuery.of(context).size.width * 187 / 375,
    height: MediaQuery.of(context).size.height * 420 / 865,
  );
}

likebuttom(BuildContext context, bool liked, int left, int top) {
  return Positioned(
    left: MediaQuery.of(context).size.width * left / 375,
    top: MediaQuery.of(context).size.height * top / 812,
    child: LikeButton(
      size: 40,
      isLiked: liked,
      likeCount: 10,
      likeBuilder: (liked) {
        final color = liked ? Colors.red : Colors.white;
        return Icon(
          Icons.favorite,
          color: color,
          size: 36,
        );
      },
      countBuilder: (count, isliked, text) {
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
