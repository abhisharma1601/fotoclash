import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Screens/emailVerification.dart';
import 'package:fotoclash/Screens/home_screen.dart';
import 'package:fotoclash/Screens/Profile/set_profile.dart';
import 'package:fotoclash/Screens/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fotoclash/Screens/sign_up.dart';
import 'package:fotoclash/Wallet/wallet.dart';
import 'package:fotoclash/Widgets/updateapp.dart';
import 'package:get/get.dart';
import 'Controllers/user_class.dart';
import 'homeBinding.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  String latest_ver = "";
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    try {
      get_screen(auth_check.currentUser!.uid);
      _initPackageInfo().then((value) => print(_packageInfo.version));
      update();
    } catch (e) {}

    super.initState();
  }

  Future<bool> update() async {
    await FirebaseFirestore.instance
        .collection("AppData")
        .doc("Version")
        .get()
        .then((value) {
      ;
      latest_ver = value.data()!["Version"];
    });

    if (_packageInfo.version == latest_ver) {
      return false;
    } else {
      return true;
    }
  }

  void get_screen(String uid) async {
    print(uid);
    var key =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    try {
      var image = (key.data() as dynamic)["imageUrl"];
      if (image.toString() == 'null') {
        setState(() {
          screen = SetProfile();
        });
      } else {
        if (await update()) {
          setState(() {
            screen = UpdateApp();
          });
        } else if (!(key.data() as dynamic)["verified"]) {
          setState(() {
            screen = EmailverificationScreen();
          });
        } else {
          setState(() {
            screen = HomeScreen();
          });
        }
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: HomeBinding(),
        title: 'FotoClash',
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Mulish',
                ),
            primarySwatch: Colors.blue,
            unselectedWidgetColor: Colors.white),
        home: check_user() ? Login() : screen);
  }
}
