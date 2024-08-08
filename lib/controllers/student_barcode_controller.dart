import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/student_barcode_in_exam_room/student_barcode_in_exam_room.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/students_in_exam_room_service.dart';
import '../tools/response_handler.dart';

class StudentsInExamRoomController extends GetxController {
  StudentBarcodeInExamRoom? studentBarcodeInExamRoom;

  bool isLoading = true;

  Future<void> activateStudent(int id) async {
    final responseHandler = ResponseHandler<void>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentUuid}/$id/activate',
      body: {},
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (_) {},
    );

    update();
    return;
  }

  Future<void> getAllStudentsInExamRoom() async {
    isLoading = true;
    update();

    final selectedExamRoomId =
        await Get.find<StudentsInExamRoomService>().selectedExamRoomId;
    final selectedExamMissionId =
        await Get.find<StudentsInExamRoomService>().selectedExamMissionId;

    final response =
        await ResponseHandler<StudentBarcodeInExamRoom>().getResponse(
      path: "${StudentsLinks.studentBarcodesExamRoom}/$selectedExamRoomId",
      converter: StudentBarcodeInExamRoom.fromJson,
      params: {
        'examMissionId': selectedExamMissionId,
      },
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) => {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.context!),
      },
      (r) {
        studentBarcodeInExamRoom = r;
      },
    );

    isLoading = false;
    update();
  }

  @override
  void onClose() async {
    await Future.wait([
      Get.find<StudentsInExamRoomService>().deleteFromHiveBox(),
    ]);
    super.onClose();
  }

  @override
  void onInit() async {
    await Future.wait([
      getAllStudentsInExamRoom(),
    ]);
    super.onInit();
  }
}
