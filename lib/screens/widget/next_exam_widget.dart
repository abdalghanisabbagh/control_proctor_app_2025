import 'package:control_proctor/controllers/next_exam_controller.dart';
import 'package:control_proctor/models/next%20exam/next_exam_res_model.dart';
import 'package:control_proctor/routes_manger.dart';
import 'package:control_proctor/services/students_in_exam_room_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource_manager/color_manager.dart';

class NextExamWidget extends GetView<NextExamController> {
  final NextExamResModel nextExamResModel;
  final int index;

  const NextExamWidget({
    super.key,
    required this.nextExamResModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.find<StudentsInExamRoomService>()
            .setSelectedExamRoomAndExamMissionId(
          examMissionId: nextExamResModel.examMissionsResModel!.data!.first.iD,
          examRoomId: nextExamResModel.examRoomResModel!.id,
        );
        Get.toNamed(Routes.studentsInExamRoom);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Room: ${nextExamResModel.examRoomResModel!.name!}",
                        style: const TextStyle(
                          color: ColorManager.primary,
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${nextExamResModel.month!} ",
                        style: const TextStyle(
                          color: ColorManager.primary,
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Class: ${nextExamResModel.examRoomResModel!.classRoomResModel!.name!}",
                        style: const TextStyle(
                          color: ColorManager.primary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Session: ${nextExamResModel.period == true ? "One" : "Two"} ",
                    style: const TextStyle(
                      color: ColorManager.primary,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(children: [
                    Text(
                      "Subject: ${nextExamResModel.examMissionsResModel!.data![index].subjectResModel!.name!}(${nextExamResModel.examMissionsResModel!.data![index].gradeResModel!.name!})",
                      style: const TextStyle(
                        color: ColorManager.primary,
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Strart in: ${DateTime.parse(nextExamResModel.examMissionsResModel!.data![index].startTime!).hour}:${DateTime.parse(nextExamResModel.examMissionsResModel!.data![index].startTime!).minute} ",
                      style: const TextStyle(
                        color: ColorManager.primary,
                        fontSize: 10,
                      ),
                    ),
                  ])
                ],
              ),
            ),
            // controller.isLoadingGeneratePdf
            //     ? Center(
            //         child: SizedBox(
            //           height: 50,
            //           width: 50,
            //           child: FittedBox(
            //             child: LoadingIndicators.getLoadingIndicator(),
            //           ),
            //         ),
            //       )
            //     : InkWell(
            //         onTap: () {
            //           controller.generatePdfSeatNumber(
            //               gradeId: examMissionObject.gradesID!,
            //               controlMissionName: controlMissionObject.name!,
            //               controlMissionId: controlMissionObject.iD!);
            //         },
            //         child: Container(
            //           height: 50,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             borderRadius: const BorderRadius.only(
            //               bottomLeft: Radius.circular(10),
            //               bottomRight: Radius.circular(10),
            //             ),
            //             color: ColorManager.bgSideMenu,
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               const Text("Generate Pdf"),
            //               const SizedBox(width: 20),
            //               Icon(Icons.print, color: ColorManager.white),
            //             ],
            //           ),
            //         ),
            //       )
          ],
        ),
      ),
    );
  }
}
