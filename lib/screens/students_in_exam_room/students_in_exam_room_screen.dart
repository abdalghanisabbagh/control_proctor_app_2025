import 'package:control_proctor/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource_manager/color_manager.dart';
import '../../resource_manager/font_manager.dart';
import '../../resource_manager/styles_manager.dart';

class StudentsInExamRoomScreen extends GetView<StudentsInExamRoomController> {
  const StudentsInExamRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students In Exam Room'),
        backgroundColor: ColorManager.bgSideMenu,
        titleTextStyle: nunitoRegularStyle(
            fontSize: FontSize.s18, color: ColorManager.white),
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),
      ),
      drawerScrimColor: ColorManager.white,
    );
  }
}
