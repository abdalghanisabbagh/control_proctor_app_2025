import 'package:control_proctor/controllers/next_exam_controller.dart';
import 'package:control_proctor/models/next%20exam/next_exam_res_model.dart';
import 'package:control_proctor/routes_manger.dart';
import 'package:control_proctor/services/students_in_exam_room_service.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/exam mission/exam_mission_res_model.dart';

class NextExamWidget extends GetView<NextExamController> {
  final NextExamResModel nextExamResModel;
  final ExamMissionResModel examMissionResModel;
  final int index;

  const NextExamWidget({
    super.key,
    required this.nextExamResModel,
    required this.examMissionResModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(examMissionResModel.startTime!);
    String formattedTime =
        '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';

    return InkWell(
      onTap: () async {
        await Get.find<StudentsInExamRoomService>()
            .setSelectedExamRoomAndExamMissionId(
          examMissionId: nextExamResModel.examMissionsResModel!.data![index].iD,
          examRoomId: nextExamResModel.examRoomResModel!.id,
        );
        Get.toNamed(Routes.studentsInExamRoom);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.bgSideMenu,
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
                          "Session: ${nextExamResModel.period == true ? "One" : "Two"} ",
                          style: nunitoLightStyle().copyWith(
                            fontSize: 14,
                            color: ColorManager.white,
                          )),
                      const Spacer(),
                      Text("${nextExamResModel.month!} ",
                          style: nunitoLightStyle().copyWith(
                            fontSize: 14,
                            color: ColorManager.white,
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Room: ${nextExamResModel.examRoomResModel!.name!}",
                          style: nunitoLightStyle().copyWith(
                            fontSize: 14,
                            color: ColorManager.white,
                          )),
                      const Spacer(),
                      Text(
                          "Class: ${nextExamResModel.examRoomResModel!.classRoomResModel!.name!}",
                          style: nunitoLightStyle().copyWith(
                            fontSize: 14,
                            color: ColorManager.white,
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                          "Subject: ${examMissionResModel.subjectResModel!.name!} (${examMissionResModel.gradeResModel!.name!})",
                          style: nunitoLightStyle().copyWith(
                            fontSize: 14,
                            color: ColorManager.white,
                          )),
                      const Spacer(),
                      Text(
                        "Start in: $formattedTime",
                        style: nunitoLightStyle().copyWith(
                          fontSize: 14,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
