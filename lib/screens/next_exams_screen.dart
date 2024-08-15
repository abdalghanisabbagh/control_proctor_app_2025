import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/next_exam_controller.dart';
import '../resource_manager/ReusableWidget/loading_indicators.dart';
import 'widget/next_exam_widget.dart';
import 'widget/side_menu.dart';

class NextExamsPage extends GetView<NextExamController> {
  const NextExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController to control the text field
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Exams'),
        backgroundColor: ColorManager.bgSideMenu,
        titleTextStyle: nunitoRegularStyle(
          fontSize: FontSize.s18,
          color: ColorManager.white,
        ),
        iconTheme: const IconThemeData(
          color: ColorManager.white,
        ),
      ),
      drawer: SideMenu(),
      drawerScrimColor: ColorManager.white,
      body: Column(
        children: [
          GetBuilder<NextExamController>(
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          controller.filterList(value);
                        },
                        decoration: const InputDecoration(
                          labelText: "Search Room Name",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                controller.fetchDataForSelectedDate(pickedDate);
                              }
                            },
                            child: Text(
                              controller.selectedDate != null
                                  ? DateFormat('EEE, d/M/yyyy')
                                      .format(controller.selectedDate!)
                                  : DateFormat('EEE, d/M/yyyy')
                                      .format(DateTime.now()),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              searchController.clear();
                              controller.resetFilters();
                            },
                            child: Text(
                              "Reset filters",
                              style: nunitoRegularStyle().copyWith(
                                color: ColorManager.glodenColor,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: controller.filteredNextExamList.isEmpty
                            ? Center(
                                child: Text(
                                  "No items available",
                                  style: nunitoBoldStyle(),
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    controller.filteredNextExamList.length,
                                itemBuilder: (context, index) {
                                  var nextExamResModel =
                                      controller.filteredNextExamList[index];

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
