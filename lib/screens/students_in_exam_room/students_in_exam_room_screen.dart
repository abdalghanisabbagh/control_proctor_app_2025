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
                  ? Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.qr_code,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.lock_outline,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20, vertical: 10),
                        Expanded(
                          child: GridView(
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
                                      Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          color: ColorManager.primary,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller
                                                .studentBarcodeInExamRoom!
                                                .barcodesResModel!
                                                .barcodes![i]
                                                .studentSeatNumberResModel!
                                                .seatNumber
                                                .toString(),
                                            style: nunitoRegularStyle(
                                              fontSize: FontSize.s18,
                                              color: ColorManager.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          color: ColorManager.bgSideMenu,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller
                                                .studentBarcodeInExamRoom!
                                                .barcodesResModel!
                                                .barcodes![i]
                                                .student!
                                                .firstName
                                                .toString(),
                                            style: nunitoRegularStyle(
                                              fontSize: FontSize.s18,
                                              color: ColorManager.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Center();
        },
      ),
    );
  }
}
