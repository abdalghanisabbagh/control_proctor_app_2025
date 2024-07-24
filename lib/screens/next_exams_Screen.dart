import 'package:control_proctor/screens/widget/next_exam_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource_manager/color_manager.dart';
import '../../resource_manager/font_manager.dart';
import '../../resource_manager/styles_manager.dart';
import '../controller/next_exam_controller.dart';
import '../resource_manager/ReusableWidget/loading_indicators.dart';
import 'widget/side_menu.dart';

class NextExamPage extends GetView<NextExamController> {
  const NextExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Next Exams'),
          backgroundColor: ColorManager.bgSideMenu,
          titleTextStyle: nunitoRegularStyle(
              fontSize: FontSize.s18, color: ColorManager.white),
          iconTheme: IconThemeData(
            color: ColorManager.white,
          ),
        ),
        drawer: SideMenu(),
        drawerScrimColor: ColorManager.white,
        body: GetBuilder<NextExamController>(
          builder: (controller) {
            if (controller.isLoadingGetNextExam) {
              return Expanded(
                child: Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                ),
              );
            }

            if (controller.nextExamList.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'No items available',
                    style: nunitoBoldStyle(),
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: controller.nextExamList.length,
                itemBuilder: (context, index) {
                  return GetBuilder<NextExamController>(
                      //  id: controller.nextExamList[index].,
                      builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NextExamWidget(
                        nextExamResModel: controller.nextExamList[index],
                      ),
                    );
                  });
                },
              ),
            );
          },
        ));
  }
}
