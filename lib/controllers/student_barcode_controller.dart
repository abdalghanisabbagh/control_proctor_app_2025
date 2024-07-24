import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_proctor/models/student_barcode_in_exam_room/student_barcode_in_exam_room.dart';
import 'package:control_proctor/services/students_in_exam_room_service.dart';
import 'package:get/get.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../tools/response_handler.dart';

class StudentsInExamRoomController extends GetxController {
  StudentBarcodeInExamRoom? studentBarcodeInExamRoom;

  bool isLoading = true;

  @override
  void onInit() async {
    await Future.wait([
      getAllStudentsInExamRoom(),
    ]);
    super.onInit();
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
}
