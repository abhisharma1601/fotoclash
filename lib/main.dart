import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/set_profile.dart';
import 'package:fotoclash/Screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'Controllers/user_class.dart';
import 'homeBinding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

var store = FirebaseFirestore.instance;
var auth_check = FirebaseAuth.instance;

user_class app_user = user_class(
    name: "",
    uid: "",
    username: "",
    phone: "",
    email: "",
    photo: "",
    place: "",
    data: [],
    bio: "",
    balance: 0);

Widget screen = CircularProgressIndicator();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    get_screen(auth_check.currentUser!.uid);
    super.initState();
  }

  void get_screen(String uid) async {
    print(uid);
    var key =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    try {
      var image = (key.data() as dynamic)["imageUrl"];
      print(image.toString());
      if (image.toString() == 'null') {
        setState(() {
          screen = SetProfile();
        });
      } else {
        setState(() {
          screen = HomeScreen();
        });
      }
    } catch (e) {
      setState(() {
        screen = SetProfile();
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: HomeBinding(),
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Mulish',
                ),
            primarySwatch: Colors.blue,
            unselectedWidgetColor: Colors.white),
        home: auth_check.currentUser!.uid.isEmpty ? SignUp() : screen);
  }
}
