import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Controllers/user_class.dart';
import 'homeBinding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, unselectedWidgetColor: Colors.white),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return const SignUp();
        },
      ),
    );
  }
}
