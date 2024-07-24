import 'package:control_proctor/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource_manager/ReusableWidget/loading_indicators.dart';
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
          fontSize: FontSize.s18,
          color: ColorManager.white,
        ),
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),
      ),
      body: GetBuilder<StudentsInExamRoomController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : controller.studentBarcodeInExamRoom != null
                  ? GridView(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: [
                        for (int i = 0;
                            i <
                                controller.studentBarcodeInExamRoom!
                                    .barcodesResModel!.barcodes!.length;
                            i++)
                          Card(
                            child: Column(
                              children: [
                                Text(
                                  controller
                                      .studentBarcodeInExamRoom!
                                      .barcodesResModel!
                                      .barcodes![i]
                                      .studentSeatNumberResModel!
                                      .seatNumber
                                      .toString(),
                                  style: nunitoRegularStyle(
                                    fontSize: FontSize.s18,
                                    color: ColorManager.black,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  controller
                                      .studentBarcodeInExamRoom!
                                      .barcodesResModel!
                                      .barcodes![i]
                                      .student!
                                      .firstName
                                      .toString(),
                                  style: nunitoRegularStyle(
                                    fontSize: FontSize.s18,
                                    color: ColorManager.black,
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(vertical: 10),
                          ),
                      ],
                    )
                  : const Center();
        },
      ),
    );
  }
}
