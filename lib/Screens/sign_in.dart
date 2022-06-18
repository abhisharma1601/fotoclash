import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Controllers/auth_controller.dart';
import 'package:fotoclash/Screens/emailVerification.dart';
import 'package:fotoclash/Screens/forget_pass.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/sign_up.dart';
import 'package:get/get.dart';

import '../Widgets/webview.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  AuthMethods authMethods = Get.find();
  Future<void> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      authMethods.signIn(email: email, password: password).then((value) async {
        Fluttertoast.showToast(msg: "Login Successful");

        try {
          var key = await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
          if ((key.data() as dynamic)["verified"]) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => EmailverificationScreen()));
          }
        } catch (e) {
          print("with error");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => EmailverificationScreen()));
        }
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mailField = TextFormField(
        style: const TextStyle(color: Colors.white),
        autofocus: false,
        controller: emailC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailC.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail_outline, color: Colors.white),
          hintText: "Email",
          hintStyle: const TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
          filled: true,
          fillColor: const Color.fromRGBO(34, 38, 51, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passField = TextFormField(
        style: const TextStyle(color: Colors.white),
        obscureText: _isObscure,
        autofocus: false,
        controller: passC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid password");
          }
        },
        onSaved: (value) {
          passC.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
          hintText: "Password",
          hintStyle: const TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
          filled: true,
          fillColor: const Color.fromRGBO(34, 38, 51, 1),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey.withOpacity(0.7),
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("background.png"), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.transparent,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 18, right: 18),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 10 / 865,
                            ),
                            const Text(
                              "Please login to continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 40 / 865,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                15 /
                                                865,
                                      ),
                                      mailField,
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                20 /
                                                865,
                                      ),
                                      passField,
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                40 /
                                                865,
                                      ),
                                      Container(
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
                                                signIn(emailC.text, passC.text);
                                              },
                                              child: const Text(
                                                "Login",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ))),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ])),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width *
                                    100 /
                                    365,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const ForgetPass()));
                                },
                                child: const Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       checkColor: Colors.black,
                            //       activeColor: Colors.white,
                            //       value: isChecked,
                            //       onChanged: (bool? value) {
                            //         setState(() {
                            //           isChecked = value!;
                            //         });
                            //       },
                            //     ),
                            //     Expanded(
                            //       child: GestureDetector(
                            //         onTap: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) => WebSurf(
                            //                       url:
                            //                           "https://fotoclash.com/privacy.html")));
                            //         },
                            //         child: Text(
                            //             "Remember me and and keep my session started. See our Privacy Police and Terms",
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.w400,
                            //                 color: Color.fromRGBO(
                            //                     107, 112, 118, 1),
                            //                 fontSize: 16)),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  260 /
                                  865,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp()));
                                },
                                child: const Text(
                                  "Create an New account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ])))),
        ),
      ),
    );
  }
}
