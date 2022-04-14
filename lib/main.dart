import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/app/core/translation.dart';
import 'package:hive_tutorial/app/data/models/language_model.dart';
import 'package:hive_tutorial/app/data/models/task_model.dart';

import 'app/routes/app_pages.dart';

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Box<TaskModel> _taskBox = await Hive.openBox<TaskModel>('tasks');
  Get.put<Box<TaskModel>>(
    _taskBox,
    permanent: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  await _initGetStorage();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translations: await AppTranslation().init(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('pt', 'BR'),
    ),
  );
}

_initGetStorage() async {
  await GetStorage.init('preferences');
  final storage = GetStorage('preferences');
  Get.put<GetStorage>(storage, tag: 'preferences', permanent: true);
}
