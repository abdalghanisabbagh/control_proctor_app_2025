import 'package:control_proctor/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/all_exam_controller.dart';
import '../resource_manager/ReusableWidget/drop_down_button.dart';
import '../resource_manager/ReusableWidget/loading_indicators.dart';
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

              if (controller.optionsControlMission.isEmpty) {
                return Text(
                  'No items available',
                  style: nunitoBoldStyle(),
                );
              }

              return SizedBox(
                width: Get.width * 0.4,
                child: MultiSelectDropDownView(
                  hintText: "Select Control Mission",
                  onOptionSelected: (selectedItem) {
                    //  controller.setSelectedItemControlMission(selectedItem);
                  },
                  options: controller.optionsControlMission,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
