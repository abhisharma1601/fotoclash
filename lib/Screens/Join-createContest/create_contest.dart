import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Models/userModel.dart';
import 'package:fotoclash/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateContest extends StatefulWidget {
  String? prize;
  String? pass;
  int balance;
  String private;
  bool isActive;
  bool winnerisME;

  String? winnerPrize;
  String? ContestName;
  CreateContest(
      {required this.prize,
      required this.pass,
      required this.balance,
      required this.private,
      this.winnerPrize,
      this.ContestName,
      required this.isActive,
      required this.winnerisME});
  @override
  State<CreateContest> createState() => _CreateContestState();
}

class _CreateContestState extends State<CreateContest> {
  File? _photo;
  String? ID;
  int likes=0;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    File? pickedFile;

    var image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    pickedFile = File(image!.path);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    const uuid = Uuid();
    ID = uuid.v1().substring(0, 15);
    super.setState(fn);
  }

  final _auth = FirebaseAuth.instance;
  postDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(ID!)
        .child(user.uid + '.jpg');
    ref.putFile(_photo!).whenComplete(() async {
      String url = await ref.getDownloadURL();
      await firebaseFirestore.collection("Contests").doc(ID).set({
        'CreatorID': user.uid,
        'CreatorName': widget.ContestName,
        'ContestID': ID,
        'DateTime': DateTime.now().toString().substring(0, 18),
        "images": [url, "", "", ""],
        "Likes": [0, 0, 0, 0],
        "Participations": [user.uid, "", "", ""],
        "EntryFee": widget.prize,
        "password": widget.pass ?? "",
        "Protected": widget.private,
        "winnerPrize": widget.winnerPrize,
        "Voters": []
      });
    });
  }

  postDataToFirestoreUser() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(ID!)
        .child(user.uid + '.jpg');
    ref.putFile(_photo!).whenComplete(() async {
      String url = await ref.getDownloadURL();
      await firebaseFirestore
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .collection("Contests")
          .doc(ID)
          .set({
        'CreatorID': user.uid,
        'CreatorName': widget.ContestName,
        'ContestID': ID,
        'DateTime': DateTime.now().toString(),
        "images": [url, "", "", ""],
        "Likes": [0, 0, 0, 0],
        "Participations": [user.uid, "", "", ""],
        "EntryFee": widget.prize,
        "password": widget.pass ?? "",
        "Protected": widget.private,
        "winnerPrize": widget.winnerPrize,
        "Voters": []
      });
    });
    String url = await ref.getDownloadURL();
      await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .collection("Participations")
        .doc(ID)
        .set({
      "ContestId": ID,
      "Likes": [0, 0, 0, 0],
      "isActive":widget.isActive,
      "Winner":widget.winnerisME,
      "images": [url, "", "", ""],
    }, SetOptions(merge: true));
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background.png"), fit: BoxFit.cover)),
          width: size.width,
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
              Text(widget.ContestName!,
                  style: TextStyle(color: Color(0xFFBBC0C6))),
              SizedBox(
                height: size.height * 35 / 812,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    child: Wrap(
                      runSpacing: 19.0,
                      spacing: 16,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (_photo == null) {
                                getImage(true);
                              }
                            },
                            child: _photo == null
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
                                      File(_photo!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: size.height * 248 / 812,
                              width: size.width * 165 / 375,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF141E31),
                              ),
                              child: Center(
                                child: Text("Participants\nphoto here",
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                              ),
                            )),
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: size.height * 248 / 812,
                              width: size.width * 165 / 375,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF141E31),
                              ),
                              child: Center(
                                child: Text("Participants\nphoto here",
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                              ),
                            )),
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: size.height * 248 / 812,
                              width: size.width * 165 / 375,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF141E31),
                              ),
                              child: Center(
                                child: Text("Participants\nphoto here",
                                    style: TextStyle(color: Color(0xFFBBC0C6))),
                              ),
                            ))
                      ],
                    ),
                  ),
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
              SizedBox(
                height: size.height * 54 / 812,
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
                                  "Total Amount ₹" + widget.prize!,
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  "₹" +
                                      widget.prize! +
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
                                        if (int.parse(widget.prize!) <=
                                            widget.balance) {
                                          postDataToFirestore();
                                          postDataToFirestoreUser();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(app_user.uid)
                                              .set({
                                            "Wallet": {
                                              "Balance": FieldValue.increment(
                                                  int.parse(widget.prize!) *
                                                      -1),
                                            }
                                          }, SetOptions(merge: true));
                                          Fluttertoast.showToast(
                                              msg: "Contest Creted!");
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
                        "Create Contest",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))),
              SizedBox(
                height: size.height * 20 / 812,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
