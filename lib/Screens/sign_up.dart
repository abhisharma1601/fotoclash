import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Controllers/auth_controller.dart';
import 'package:fotoclash/Models/userModel.dart';
import 'package:fotoclash/Screens/set_profile.dart';
import 'package:fotoclash/Screens/sign_in.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final _auth = FirebaseAuth.instance;
  final states = [
    'Delhi',
    'Maharashtra',
    "Andaman and Nicobar",
    "Andhra Pradesh",
    "Goa",
    "Gujarat",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Kerala",
    "	Bihar",
    "	Madhya Pradesh",
    "Rajasthan"
        "	Tamil Nadu"
  ];
  String? value;
  bool isChecked = false;
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  AuthMethods authMethods = Get.find();
  final _auth = FirebaseAuth.instance;
  final TextEditingController username = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final TextEditingController mobileC = TextEditingController();
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDataToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    UserModel.name = username.text;

    await firebaseFirestore.collection("Users").doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'userName': username.text,
      'fullname': fullname.text,
      'phoneNo': mobileC.text,
      'State': value,
      "Data": [0, 0, 0],
      "Wallet": {}
    }, SetOptions(merge: true));

    Fluttertoast.showToast(msg: "Account created successfully !!");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SetProfile()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
        style: const TextStyle(color: Colors.white),
        autofocus: false,
        controller: username,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("UserName cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Name");
          }
        },
        onSaved: (value) {
          username.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          hintText: "User Name",
          hintStyle: const TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
          filled: true,
          fillColor: const Color.fromRGBO(34, 38, 51, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
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
    final mobileField = TextFormField(
      style: const TextStyle(color: Colors.white),
      autofocus: false,
      controller: mobileC,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter phone number");
        }
        return null;
      },
      onSaved: (value) {
        mobileC.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Phone Number',
        hintStyle: const TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
        filled: true,
        fillColor: const Color.fromRGBO(34, 38, 51, 1),
        prefix: const Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: Text(
            '+91',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      maxLength: 10,
    );
    final selectState = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(34, 38, 51, 1),
      ),
      child: DropdownButton(
          value: value,
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: Colors.white,
          hint: const Text(
            "Select State",
            style: TextStyle(color: Color.fromRGBO(107, 112, 118, 1)),
          ),
          dropdownColor: const Color.fromRGBO(34, 38, 51, 1),
          items: states.map(buildMenuItem).toList(),
          isExpanded: true,
          iconSize: 36,
          onChanged: (value) {
            setState(() => this.value = value.toString());
          }),
    );
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
            return ("Fullname cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Name");
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
                              "Signup",
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
                              "Please Sign up to continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 20 / 865,
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
                                      usernameField,
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                20 /
                                                865,
                                      ),
                                      fullnameField,
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                15 /
                                                865,
                                      ),
                                      mobileField,
                                      selectState,
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
                                                20 /
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
                                                signUp(emailC.text, passC.text);
                                              },
                                              child: const Text(
                                                "SignUp",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ])),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                      "I agree with Terms and Privacy policy Weld.com",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(107, 112, 118, 1),
                                          fontSize: 16)),
                                )
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 20 / 865,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: const Text(
                                  "Sign In to my account",
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
