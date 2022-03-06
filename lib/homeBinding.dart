import 'package:fotoclash/Controllers/auth_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthMethods());
  }
}