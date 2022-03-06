import 'package:flutter/material.dart';
import 'package:fotoclash/Widgets/tab_bar.dart';
import 'package:fotoclash/main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int followers = app_user.data[0];
  int following = app_user.data[1];
  int Likes = app_user.data[2];

  @override
  Widget build(BuildContext context) {
    print(app_user.photo);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background.png"), fit: BoxFit.cover),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.355,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Image(
                        image: NetworkImage(app_user.photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 215 / 812,
                      left: MediaQuery.of(context).size.width * 12 / 375,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            app_user.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                app_user.place,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Wrap(
                    runSpacing: MediaQuery.of(context).size.width * 15 / 375,
                    children: [
                      const SizedBox(),
                      _shocase(head: followers, body: "Followers"),
                      _shocase(head: following, body: "Following"),
                      _shocase(head: Likes, body: "Contests")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     DecoratedBox(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(15),
                //             gradient: const LinearGradient(colors: [
                //               Color.fromRGBO(166, 203, 255, 1),
                //               Color.fromRGBO(77, 123, 218, 1),
                //               Color.fromRGBO(175, 47, 32, 1),
                //               Color.fromRGBO(244, 157, 99, 1),
                //             ])),
                //         child: ElevatedButton(
                //           style: ButtonStyle(
                //               elevation: MaterialStateProperty.all(0),
                //               alignment: Alignment.center,
                //               padding: MaterialStateProperty.all(
                //                   const EdgeInsets.only(
                //                       right: 55,
                //                       left: 55,
                //                       top: 15,
                //                       bottom: 15)),
                //               backgroundColor:
                //                   MaterialStateProperty.all(Colors.transparent),
                //               shape: MaterialStateProperty.all(
                //                 RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(15)),
                //               )),
                //           onPressed: () {
                //             if(_auth.currentUser!.uid==app_user.uid){
                //               null;
                //             }else{
                //             setState(() {
                //               followers++;
                //               app_user.data[0]++;
                //               FirebaseFirestore.instance.collection("Users").doc(app_user.uid).update({
                //                 "Data":app_user.data
                //               });
                //             });}
                //           },
                //           child: const Text(
                //             "Follow",
                //             style: TextStyle(color: Colors.white, fontSize: 16),
                //           ),
                //         )),
                //     DecoratedBox(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(15),
                //             color: Colors.transparent,
                //             border: Border.all(color: Colors.white)),
                //         child: ElevatedButton(
                //           style: ButtonStyle(
                //               elevation: MaterialStateProperty.all(0),
                //               alignment: Alignment.center,
                //               padding: MaterialStateProperty.all(
                //                   const EdgeInsets.only(
                //                       right: 55,
                //                       left: 55,
                //                       top: 15,
                //                       bottom: 15)),
                //               backgroundColor:
                //                   MaterialStateProperty.all(Colors.transparent),
                //               shape: MaterialStateProperty.all(
                //                 RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(15)),
                //               )),
                //           onPressed: () {},
                //           child: const Text(
                //             "Message",
                //             style: TextStyle(color: Colors.white, fontSize: 16),
                //           ),
                //         )),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _winDetails(head: "Won", body: "60", color: Colors.green),
                    _winDetails(head: "Lost", body: "60", color: Colors.red),
                    _winDetails(
                        head: "Contest Tie", body: "60", color: Colors.yellow)
                  ],
                ),
                Divider(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 40 / 812,
                  thickness: 0.2,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                  child: Text(
                    "Bio",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                  child: Text(
                    "Amet minim mollit non deserunt ullamco est sit aliqua This is test.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const TabBarAndTabViews()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _shocase extends StatelessWidget {
  _shocase({required this.head, required this.body});

  int head;
  String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Text(
        "$head  $body",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class _winDetails extends StatelessWidget {
  _winDetails({required this.head, required this.body, required this.color});

  String head;
  String body;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$head  $body",
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: 16),
    );
  }
}
