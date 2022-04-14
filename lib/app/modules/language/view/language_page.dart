import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/language_controller.dart';

class LanguagePage extends GetView<LanguageController> {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.languages.length,
            itemBuilder: (_, index) {
              final _lang = controller.languages[index];
              return GestureDetector(
                onTap: () async {
                  await Get.find<GetStorage>(tag: 'preferences').write('language', _lang);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: SizedBox(
                      child: Image.asset(
                    'assets/flags/' + _lang.flag,
                    gaplessPlayback: false,
                  )),
                ),
              );
            }));
  }
}
