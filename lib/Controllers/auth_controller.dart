import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/Models/userModel.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods extends GetxController {
  final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
  RxMap<dynamic, dynamic> userInfo = {}.obs;

  Future signUp({String? userName, String? email, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fa.UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    if (user.additionalUserInfo!.isNewUser) {
      prefs.setString(
          "userName", user.user!.displayName ?? userName.toString());
      prefs.setString("email", user.user!.email ?? email.toString());
      prefs.setString("phoneNumber", user.user!.phoneNumber.toString());
      prefs.setString("uuid", user.user!.uid);
    } else {
      throw Exception("User Already Exists");
    }
  }

  Future signIn({String? email, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      fa.UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      prefs.setString(
          "userName", user.user!.displayName ?? email.split("@")[0].toString());
      prefs.setString("email", user.user!.email ?? email.toString());
      prefs.setString("phoneNumber", user.user!.phoneNumber.toString());
      userInfo["userName"] = user.user!.displayName ?? email.split("@")[0];
      prefs.setString("uuid", user.user!.uid);
    } catch (e) {
      throw Exception("Please Enter Valid Details");
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Fluttertoast.showToast(msg: "Please fill email field");
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await GoogleSignIn().disconnect();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> isDocumentExists() async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection("Users").doc().get();
  if(document.exists){
    return true;
  }else{
    return false;
  }
  }

  postDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    UserModel.name = user.displayName ?? user.email.toString().split("@")[0];
    await firebaseFirestore.collection("Users").doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'userName': user.displayName ?? user.email.toString().split("@")[0],
      'phoneNumber': user.phoneNumber ?? "No PhoneNumber",
    });
  }


  Future signInWithGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final fa.AuthCredential credential = fa.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await GoogleSignIn().disconnect();
 
    final dynamic authResult = await _auth.signInWithCredential(credential);
    final fa.User user = authResult.user;
   DocumentSnapshot document =
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();
  if(document.exists){
    print("User Already Exists");
  }else{
    postDataToFirestore();
    prefs.setString(
        "userName",
        googleSignInAccount.displayName ??
            googleSignInAccount.email.split("@")[0]);
    prefs.setString("email", googleSignInAccount.email);
    prefs.setString("imageUrl", googleSignInAccount.photoUrl.toString());
    prefs.setString("phoneNumber", "");
    prefs.setString("uuid", user.uid);
  }
    
  }
}
