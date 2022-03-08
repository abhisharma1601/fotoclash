import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  String userName;
  String image;
  final int index;
  final VoidCallback press;

   HomeBody(this.userName,this.image,{required this.index,required this.press, Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // List images = [
  //   "https://cdn.vox-cdn.com/thumbor/J2XSqgAqREtpkGAWa6rMhkHA1Y0=/0x0:1600x900/1400x933/filters:focal(672x322:928x578):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/66320060/Tanjiro__Demon_Slayer_.0.png",
  //   "https://i.insider.com/5e820b04671de06758588fb8?width=700",
  //   "https://pbs.twimg.com/profile_images/1402894430173110274/5zrO8sS5_400x400.jpg",
  //   "https://www.cartoonbrew.com/wp-content/uploads/2020/10/demon_slayer_mugen-580x326.jpg"
  // ];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.75),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Users").get(),
          builder:(ctx, AsyncSnapshot futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return   Row(
            children: [
              Stack(
                children: [CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.image),
                ),
                 Positioned(
                   left: 0,
                   bottom: 0,
                   child: Container(
                     height: 16,
                     width: 16,
                     decoration: BoxDecoration(color: Colors.red,
                     shape: BoxShape.circle,
                     border: Border.all()),
                   ),
                 )
                ]),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                children:  [     
                  Text(
                    widget.userName,
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 5,),
                  Opacity(
                    opacity: 0.6,
                    child: Text("Hi this is test .................",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                     style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ],
              )),
              const Opacity(
                opacity: 0.6,
                child: Text("3m ago",style: TextStyle(color: Colors.white),))
            ],
          );
           } ),
      ),
    );
  }
}
