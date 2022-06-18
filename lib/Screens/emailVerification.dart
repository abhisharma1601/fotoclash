import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/sign_up.dart';
import 'package:fotoclash/Screens/smtp.dart';

class EmailverificationScreen extends StatefulWidget {
  EmailverificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailverificationScreen> createState() =>
      _EmailverificationScreenState();
}

class _EmailverificationScreenState extends State<EmailverificationScreen> {
  bool isemailverified = false;
  bool wait = true;
  int start = 30;
  Timer? timer;
  int _sentOtp = 0;
  int _otp = 0;

  @override
  void initState() {
    super.initState();
    starttimer();
    send_otp();
  }

  void send_otp() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    Fluttertoast.showToast(
        msg: "OTP sent on $email, check your spam folder if not recieved!");
    _sentOtp = Random().nextInt(1000000) +
        Random().nextInt(10000) +
        Random().nextInt(100);
    verify_email(email, _sentOtp);
  }

  void starttimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (_timer) {
      if (start == 0) {
        setState(() {
          wait = false;
          _timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/infinity-office/48/005_084_email_mail_verification_tick-1024.png"),
              height: 280,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: TextFormField(
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value.toString().length < 4) {
                      return "Enter valid OTP!";
                    }
                    return null;
                  },
                  onChanged: ((value) {
                    _otp = int.parse(value);
                  }),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.orange)),
                      hintText: "Enter OTP sent on email",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.white))),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Haven't recieved email?\n     send again in ",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextSpan(
                      text: "00:$start ",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "sec",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Visibility(
                visible: !wait,
                child: InkWell(
                  onTap: () {
                    starttimer();
                    send_otp();
                    setState(() {
                      wait = true;
                      start = 30;
                    });
                  },
                  child: Text(
                    "Resend",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
              height: 26,
            ),
            GestureDetector(
              onTap: () {
                if (_otp == _sentOtp) {
                  Fluttertoast.showToast(msg: "email verified!");
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({"verified": true}, SetOptions(merge: true));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  Fluttertoast.showToast(msg: "OTP not correct!");
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                child: Text(
                  "verify",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  "Wrong email ?",
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
