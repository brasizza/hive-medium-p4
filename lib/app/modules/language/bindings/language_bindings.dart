import 'package:get/get.dart';
import '../controllers/language_controller.dart';

class LanguageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController());
  }
}
