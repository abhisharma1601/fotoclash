import 'package:fotoclash/Controllers/auth_controller.dart';
import 'package:fotoclash/Controllers/user_class.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthMethods());
    Get.put(user_class( name: "",
    uid: "",
    username: "",
    phone: "",
    email: "",
    photo: "",
    place: "",
    data: [],
    bio: "",
    balance: 0));
  }
}