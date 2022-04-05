import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Profile/profile_user.dart';

class SingleImage extends StatefulWidget {
  String? image;
  String? Participations;
  SingleImage({this.image, this.Participations});

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  @override
  Widget build(BuildContext context) {
    print(widget.Participations);
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
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("uid", isEqualTo: widget.Participations!)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return snapshot.hasData
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 34,
                                backgroundImage: NetworkImage(
                                    snapshot.requireData.docs[0]["imageUrl"]),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  snapshot.requireData.docs[0]["userName"],
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => UserProfile( snapshot.requireData.docs[0]["userName"], 0)));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    'Folllow',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
