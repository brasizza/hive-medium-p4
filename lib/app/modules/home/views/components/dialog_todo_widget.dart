import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_tutorial/app/data/models/task_model.dart';
import 'package:hive_tutorial/app/modules/home/controllers/dialog_controller.dart';
import 'package:hive_tutorial/app/modules/home/controllers/home_controller.dart';

class DialogTodo extends GetView<DialogController> {
  final TaskModel? todo;
  DialogTodo({Key? key, this.todo}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController tileTextController = TextEditingController(text: (todo != null ? todo!.title : ''));
    final TextEditingController descriptionTextController = TextEditingController(text: (todo != null ? todo!.description : ''));
    final TextEditingController tagTextController = TextEditingController(text: (todo != null ? todo!.tag : ''));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'dialog.title_page'.tr,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: tileTextController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: 'dialog.title_field'.tr,
                    ),
                    validator: (String? value) {
                      if (value == '') {
                        return 'dialog.title_validation'.tr;
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionTextController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'dialog.description_field'.tr,
                    ),
                  ),
                  TextFormField(
                    controller: tagTextController,
                    decoration: InputDecoration(
                      labelText: 'dialog.tags_field'.tr,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Obx(() => CheckboxListTile(
                        title: Text(
                          'dialog.task_done'.tr,
                        ),
                        value: controller.todoCheck.value,
                        onChanged: (newVal) {
                          controller.todoCheck.value = newVal!;
                        })),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              if (todo != null) {
                                Get.find<HomeController>().updateTask(
                                  todo,
                                  title: tileTextController.text,
                                  description: descriptionTextController.text,
                                  tag: tagTextController.text,
                                  done: controller.todoCheck.value,
                                );
                              } else {
                                Get.find<HomeController>().addTask(
                                  title: tileTextController.text,
                                  description: descriptionTextController.text,
                                  tag: tagTextController.text,
                                  done: controller.todoCheck.value,
                                );
                              }
                              Get.close(0);
                            }
                          },
                          child: Text('label.save'.tr)),
                      Visibility(
                        visible: (todo != null),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(title: 'dialog.delete_task.title'.trParams({'task_id': todo!.id.toString()}), content: Text('dialog.delete_task.description'.tr), actions: [
                                OutlinedButton(
                                    onPressed: () {
                                      Get.close(1);
                                    },
                                    child: Text('label.no'.tr)),
                                OutlinedButton(
                                    onPressed: () async {
                                      await Get.find<HomeController>().deleteTask(todo);
                                      Get.close(2);
                                    },
                                    child: Text('label.yes'.tr)),
                              ]);
                            },
                            child: Text('label.delete'.tr),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ],
    );
  }
}
