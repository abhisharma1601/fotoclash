import 'package:get/get.dart';

class user_class extends GetxController {
  RxMap<dynamic, dynamic> userInfo = {}.obs;
  user_class({
    required this.name,
    required this.uid,
    required this.username,
    required this.phone,
    required this.email,
    required this.photo,
    required this.place,
    required this.data,
    required this.bio,
    required this.balance,
  });
  String name, uid, username, phone, email, photo, place, bio;
  List data;
  int balance;
  
}
