import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/Chats/home_body.dart';
import 'package:fotoclash/Screens/Chats/messages.dart';
import 'package:fotoclash/Widgets/search_bar.dart';

class HomeChats extends StatefulWidget {
  const HomeChats({Key? key}) : super(key: key);

  @override
  _HomeChatsState createState() => _HomeChatsState();
}

class _HomeChatsState extends State<HomeChats> {
  List images = [
    "https://cdn.vox-cdn.com/thumbor/J2XSqgAqREtpkGAWa6rMhkHA1Y0=/0x0:1600x900/1400x933/filters:focal(672x322:928x578):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/66320060/Tanjiro__Demon_Slayer_.0.png",
    "https://i.insider.com/5e820b04671de06758588fb8?width=700",
    "https://pbs.twimg.com/profile_images/1402894430173110274/5zrO8sS5_400x400.jpg",
    "https://www.cartoonbrew.com/wp-content/uploads/2020/10/demon_slayer_mugen-580x326.jpg"
  ];
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // InkWell(
                  //   // onTap: () {
                  //   //   Navigator.pop(context);
                  //   // },
                  //   child: const Icon(
                  //     Icons.arrow_back_ios_new,
                  //     color: Colors.white,
                  //   ),
                  // ),
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 150 / 375,
                  ),
                  const Center(
                    child: Text(
                      "Messages",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 50 / 812,
                  width: MediaQuery.of(context).size.width * 340 / 375,
                  child:
                      SearchInput(textController: searchC, hintText: "Search")),
              Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return HomeBody(
                        index: index,
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Messages()));
                        },
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
