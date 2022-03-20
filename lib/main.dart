import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/Profile/set_profile.dart';
import 'package:fotoclash/Screens/sign_in.dart';
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

FirebaseFirestore store = FirebaseFirestore.instance;
FirebaseAuth auth_check = FirebaseAuth.instance;

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

Widget screen = Scaffold(
  backgroundColor: Colors.transparent,
  body: Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("background.png"), fit: BoxFit.cover)),
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.orange,
      ),
    ),
  ),
);

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    try {
      get_screen(auth_check.currentUser!.uid);
    } catch (e) {}

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

  bool check_user() {
    try {
      print(auth_check.currentUser!.uid);
      return false;
    } catch (e) {
      return true;
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
        home: check_user() ? Login() : screen);
  }
}
