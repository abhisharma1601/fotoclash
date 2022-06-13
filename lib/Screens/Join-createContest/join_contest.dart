import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Models/userModel.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class JoinContest extends StatefulWidget {
  String? ContestID;
  int? contestSize;
  int balance;
  String? CreatorID;
  String? EntryFee;
  String? winnerPrize;
  bool isActive;
  bool winnerisME;
  JoinContest(
      {this.ContestID,
      this.contestSize,
      required this.balance,
      this.CreatorID,
      this.EntryFee,
      this.winnerPrize,
      required this.isActive,
      required this.winnerisME});
  @override
  State<JoinContest> createState() => _JoinContestState();
}

class _JoinContestState extends State<JoinContest> {
  File? _photo;
  File? _photo1;
  File? _photo2;
  File? _photo3;
  bool imagePicked = false;
  int likes = 0;
  int index = 0;
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage1(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _photo1 = File(pickedFile.path);
        imagePicked = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _photo2 = File(pickedFile.path);
        imagePicked = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage3(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        imageQuality: 20,
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _photo3 = File(pickedFile.path);
        imagePicked = true;
      } else {
        print('No image selected.');
      }
    });
  }

  final _auth = FirebaseAuth.instance;
  postDataToFirestore() async {
    List<File?> pics = [_photo, _photo1, _photo2, _photo3];
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Contests")
        .where("ContestID", isEqualTo: widget.ContestID)
        .get();
    List prevparticipants = snapshot.docs[0]["Participations"];
    List prevImages = snapshot.docs[0]["images"];
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(widget.ContestID!)
        .child(user.uid + '.jpg');
    ref
        .putFile(
      pics[index]!,
    )
        .whenComplete(() async {
      String url1 = await ref.getDownloadURL();
      prevImages[index] = url1;
      prevparticipants[index] = _auth.currentUser!.uid;
      await firebaseFirestore
          .collection("Contests")
          .doc(widget.ContestID)
          .update({"images": prevImages, "Participations": prevparticipants});
    });
  }

  postDataToFirestoreUser() async {
    List<File?> pics = [_photo, _photo1, _photo2, _photo3];
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.CreatorID)
        .collection("Contests")
        .where("ContestID", isEqualTo: widget.ContestID)
        .get();
    List prevparticipants = snapshot.docs[0]["Participations"];
    List prevImages = snapshot.docs[0]["images"];
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(widget.ContestID!)
        .child(user.uid + '.jpg');
    ref
        .putFile(
      pics[index]!,
    )
        .whenComplete(() async {
      String url1 = await ref.getDownloadURL();
      prevImages[index] = url1;
      prevparticipants[index] = _auth.currentUser!.uid;
      await firebaseFirestore
          .collection("Users")
          .doc(widget.CreatorID)
          .collection("Contests")
          .doc(widget.ContestID)
          .update({"images": prevImages, "Participations": prevparticipants});
    });
  }

  postDataToFirestoreParticipations() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.CreatorID)
        .collection("Contests")
        .where("ContestID", isEqualTo: widget.ContestID)
        .get();
    List prevImages = snapshot.docs[0]["images"];
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .collection("Participations")
        .doc(widget.ContestID)
        .set({
      "ContestId": widget.ContestID,
      "Likes": likes,
      "isActive": widget.isActive,
      "Winner": widget.winnerisME,
      "Status": "Lost",
      "images": prevImages,
      "Entry Fee": widget.EntryFee,
      "DateTime": DateTime.now().toString().substring(0, 18),
      "Prize": widget.winnerPrize
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.CreatorID);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background.png"), fit: BoxFit.cover)),
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 40 / 812,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: size.width / 2 - 85,
                      ),
                      Text(
                        "Fotoclash",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Contests")
                      .where("ContestID", isEqualTo: widget.ContestID)
                      .get(),
                  builder: (context, AsyncSnapshot futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return futureSnapshot.hasData
                          ? Column(
                              children: [
                                Text(
                                    "Contest Name : " +
                                        futureSnapshot.requireData.docs[0]
                                            ["CreatorName"],
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                                Text("Contest Id : " + widget.ContestID!,
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                                Text(
                                    "Entry Free : \u{20B9}" +
                                        futureSnapshot.requireData.docs[0]
                                            ["EntryFee"],
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                                Text(
                                    "Winning Amount : " +
                                        futureSnapshot.requireData.docs[0]
                                            ["winnerPrize"],
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                              ],
                            )
                          : Container();
                    }
                  }),
              widget.contestSize == 2
                  ? SizedBox(
                      height: size.height * 120 / 812,
                    )
                  : SizedBox(
                      height: size.height * 33 / 812,
                    ),
              Stack(
                alignment: Alignment.center,
                children: [
                  widget.contestSize == 2 ? contest2() : contest4(),
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                            colors: [Color(0xFFE65100), Color(0xFFFFE0B2)])),
                    child: Center(
                        child: Text("VS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))),
                  )
                ],
              ),
              widget.contestSize == 2
                  ? SizedBox(
                      height: size.height * 200 / 812,
                    )
                  : SizedBox(
                      height: size.height * 40 / 812,
                    ),
              Container(
                  width: MediaQuery.of(context).size.width * 339 / 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE65100), Color(0xFFFFE0B2)])),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          alignment: Alignment.center,
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  right: 75, left: 75, top: 15, bottom: 15)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          )),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Total Amount ₹" + widget.EntryFee!,
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  "₹" +
                                      widget.EntryFee! +
                                      " will be debited from your account.",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            color: Colors.orange, fontSize: 20),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        print(widget.balance);
                                        if (int.parse(widget.EntryFee!) <=
                                            widget.balance) {
                                          postDataToFirestore();
                                          postDataToFirestoreUser();
                                          postDataToFirestoreParticipations();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(app_user.uid)
                                              .set({
                                            "Wallet": {
                                              "Balance": FieldValue.increment(
                                                  int.parse(widget.EntryFee!) *
                                                      -1),
                                            }
                                          }, SetOptions(merge: true));
                                          Fluttertoast.showToast(
                                              msg: "Contest Joined!");
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Low Wallet Balance!");
                                        }
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            color: Colors.orange, fontSize: 20),
                                      )),
                                ],
                                backgroundColor: Color(0xFF141E31),
                                elevation: 24,
                              );
                            });
                      },
                      child: const Text(
                        "Join Contest",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))),
              SizedBox(
                height: size.height * 10 / 812,
              ),
            ],
          ),
        ),
      ),
    );
  }

  contest4() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Contests")
              .where("ContestID", isEqualTo: widget.ContestID)
              .get(),
          builder: (context, AsyncSnapshot futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Wrap(
                runSpacing: 19.0,
                spacing: 16,
                children: [
                  GestureDetector(
                      onTap: () {
                        // if (_photo == null) {
                        index = 0;
                        //   getImage(true);
                        // }
                      },
                      child: Container(
                        height: size.height * 248 / 812,
                        width: size.width * 165 / 375,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF141E31),
                        ),
                        child: Image.network(
                          futureSnapshot.requireData.docs[0]["images"][0],
                          fit: BoxFit.cover,
                        ),
                      )),
                  futureSnapshot.requireData.docs[0]["images"][1] == ""
                      ? GestureDetector(
                          onTap: () {
                            if (_photo1 == null && imagePicked == false) {
                              index = 1;
                              getImage1(true);
                            }
                          },
                          child: _photo1 == null
                              ? Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Center(
                                    child: Text("Upload your\nphoto here",
                                        style: TextStyle(
                                            color: Color(0xFFBBC0C6))),
                                  ),
                                )
                              : Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Image.file(
                                    File(_photo1!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                      : Container(
                          height: size.height * 248 / 812,
                          width: size.width * 165 / 375,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF141E31),
                          ),
                          child: Image.network(
                            futureSnapshot.requireData.docs[0]["images"][1],
                            fit: BoxFit.cover,
                          ),
                        ),
                  futureSnapshot.requireData.docs[0]["images"][2] == ""
                      ? GestureDetector(
                          onTap: () {
                            if (_photo2 == null && imagePicked == false) {
                              index = 2;
                              getImage2(true);
                            }
                          },
                          child: _photo2 == null
                              ? Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Center(
                                    child: Text("Upload your\nphoto here",
                                        style: TextStyle(
                                            color: Color(0xFFBBC0C6))),
                                  ),
                                )
                              : Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Image.file(
                                    File(_photo2!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                      : Container(
                          height: size.height * 248 / 812,
                          width: size.width * 165 / 375,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF141E31),
                          ),
                          child: Image.network(
                            futureSnapshot.requireData.docs[0]["images"][1],
                            fit: BoxFit.cover,
                          ),
                        ),
                  futureSnapshot.requireData.docs[0]["images"][3] == ""
                      ? GestureDetector(
                          onTap: () {
                            if (_photo3 == null && imagePicked == false) {
                              index = 3;
                              getImage3(true);
                            }
                          },
                          child: _photo3 == null
                              ? Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Center(
                                    child: Text("Upload your\nphoto here",
                                        style: TextStyle(
                                            color: Color(0xFFBBC0C6))),
                                  ),
                                )
                              : Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Image.file(
                                    File(_photo3!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                      : Container(
                          height: size.height * 248 / 812,
                          width: size.width * 165 / 375,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF141E31),
                          ),
                          child: Image.network(
                            futureSnapshot.requireData.docs[0]["images"][1],
                            fit: BoxFit.cover,
                          ),
                        ),
                ],
              );
            }
          }),
    );
  }

  contest2() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Contests")
              .where("ContestID", isEqualTo: widget.ContestID)
              .get(),
          builder: (context, AsyncSnapshot futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Wrap(
                runSpacing: 19.0,
                spacing: 16,
                children: [
                  GestureDetector(
                      onTap: () {
                        // if (_photo == null) {
                        index = 0;
                      },
                      child: Container(
                        height: size.height * 248 / 812,
                        width: size.width * 165 / 375,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF141E31),
                        ),
                        child: Image.network(
                          futureSnapshot.requireData.docs[0]["images"][0],
                          fit: BoxFit.cover,
                        ),
                      )),
                  futureSnapshot.requireData.docs[0]["images"][1] == ""
                      ? GestureDetector(
                          onTap: () {
                            if (_photo1 == null) {
                              index = 1;
                              getImage1(true);
                            }
                          },
                          child: _photo1 == null
                              ? Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Center(
                                    child: Text("Upload your\nphoto here",
                                        style: TextStyle(
                                            color: Color(0xFFBBC0C6))),
                                  ),
                                )
                              : Container(
                                  height: size.height * 248 / 812,
                                  width: size.width * 165 / 375,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF141E31),
                                  ),
                                  child: Image.file(
                                    File(_photo1!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                      : Container(
                          height: size.height * 248 / 812,
                          width: size.width * 165 / 375,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF141E31),
                          ),
                          child: Image.network(
                            futureSnapshot.requireData.docs[0]["images"][1],
                            fit: BoxFit.cover,
                          ),
                        ),
                ],
              );
            }
          }),
    );
  }
}
