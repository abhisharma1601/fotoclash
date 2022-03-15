import 'package:flutter/material.dart';

import 'Profile/profile_user.dart';

class SingleImage extends StatefulWidget {
  String? image;
  SingleImage({this.image});

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image!), fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 120 / 375,
                ),
              ],
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(widget.image!),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "name abc",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => UserProfile("",0)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Center(
                        child: Text(
                      'Folllow',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width * 30 / 375,
              top: MediaQuery.of(context).size.height * 740 / 812,
              child: Row(
                children: [
                  const Icon(
                    Icons.comment,
                    color: Colors.red,
                    size: 28,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 28,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
