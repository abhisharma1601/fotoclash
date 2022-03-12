import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Models/userModel.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/sign_in.dart';
import 'package:fotoclash/Widgets/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  DateTime? _dateTime;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController bio = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final imagestore =
      FirebaseStorage.instance.ref().child("user_image").child(".jpg");
  postDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child("Profiles")
        .child(user.uid + '.jpg');
    ref.putFile(_userImageFile!).whenComplete(() async {
      String url = await ref.getDownloadURL();
      await firebaseFirestore.collection("Users").doc(user.uid).update({
        'fullname': fullname.text,
        'bio': bio.text,
        'imageUrl': url,
      });
    });
    Fluttertoast.showToast(msg: "Data updated sucessfully. Please Login");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final fullnameField = TextFormField(
        style: const TextStyle(color: Colors.white),
        autofocus: false,
        controller: fullname,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Fullname cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Name");
          }
        },
        onSaved: (value) {
          fullname.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person, color: Colors.white),
          hintText: "Full Name",
          hintStyle: const TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
          filled: true,
          fillColor: const Color.fromRGBO(34, 38, 51, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final bioField = TextFormField(
      style: const TextStyle(color: Colors.white),
      autofocus: false,
      controller: bio,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Bio");
        }
        return null;
      },
      onSaved: (value) {
        bio.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Bio',
        hintStyle: const TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
        filled: true,
        fillColor: const Color.fromRGBO(34, 38, 51, 1),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("background.png"), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Container(
                color: Colors.transparent,
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 18, right: 18),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Profile Setup",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 50 / 865,
                          ),
                          Center(child: UImagePicker(_pickedImage)),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 40 / 865,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              15 /
                                              865,
                                    ),
                                    fullnameField,
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              28 /
                                              865,
                                    ),
                                    bioField,
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              30 /
                                              865,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                205 /
                                                865,
                                      ),
                                      child: Container(
                                          width: MediaQuery.of(context).size.width *
                                              339 /
                                              360,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFFE65100),
                                                    Color(0xFFFFE0B2)
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
                                                              right: 75,
                                                              left: 75,
                                                              top: 15,
                                                              bottom: 15)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.transparent),
                                                  shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                  )),
                                              onPressed: () {
                                                postDataToFirestore();
                                              },
                                              child: const Text(
                                                "Done",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ))),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ])),
                        ])))),
      ),
    );
  }
}
