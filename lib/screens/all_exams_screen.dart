import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/all_exam_controller.dart';
import '../resource_manager/ReusableWidget/drop_down_button.dart';
import '../resource_manager/ReusableWidget/loading_indicators.dart';
import 'widget/next_exam_widget.dart';
import 'widget/side_menu.dart';

class AllExams extends GetView<AllExamController> {
  const AllExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Exams'),
        backgroundColor: ColorManager.bgSideMenu,
        titleTextStyle: nunitoRegularStyle(
          fontSize: FontSize.s18,
          color: ColorManager.white,
        ),
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),
      ),
      drawer: SideMenu(),
      body: Column(
        children: [
          GetBuilder<AllExamController>(
            builder: (_) {
              if (controller.isLoadingGetControlMission) {
                return Center(
                  child: SizedBox(
                    width: Get.width * 0.4,
                    height: 50,
                    child: FittedBox(
                      child: LoadingIndicators.getLoadingIndicator(),
                    ),
                  ),
                );
              }

              return SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MultiSelectDropDownView(
                    hintText: "Select Control Mission",
                    onOptionSelected: (selectedItem) {
                      selectedItem.isNotEmpty
                          ? controller.getExamMissionsByControlMissionId(
                              controlMissionId: selectedItem.first.value)
                          : controller.nextExamList.clear();

                      controller.update();
                    },
                    options: controller.optionsControlMission,
                  ),
                ),
              );
            },
          ),
          GetBuilder<AllExamController>(
            builder: (controller) {
              if (controller.isLoadingGetNextExam) {
                return Expanded(
                  child: Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                );
              }
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: controller.nextExamList.isEmpty
                            ? Center(
                                child: Text(
                                  "No items available",
                                  style: nunitoBoldStyle(),
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.nextExamList.length,
                                itemBuilder: (context, index) {
                                  var nextExamResModel =
                                      controller.nextExamList[index];
                                  if (nextExamResModel.examMissionsResModel
                                          ?.data?.isEmpty ??
                                      true) {
                                    return Container();
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      nextExamResModel
                                          .examMissionsResModel!.data!.length,
                                      (i) {
                                        var mission = nextExamResModel
                                            .examMissionsResModel!.data![i];
                                        return NextExamWidget(
                                          nextExamResModel: nextExamResModel,
                                          examMissionResModel: mission,
                                          index: i,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
