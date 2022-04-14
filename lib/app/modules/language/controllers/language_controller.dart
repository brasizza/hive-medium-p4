import 'package:get/get.dart';
import 'package:hive_tutorial/app/data/models/language_model.dart';

class LanguageController extends GetxController {
  final languages = <Language>[].obs;
  @override
  void onInit() {
    languages.add(Language(lang: 'pt', contryCode: 'BR', flag: 'brazil.png'));
    languages.add(Language(lang: 'en', contryCode: 'US', flag: 'usa.png'));
    super.onInit();
  }
}
