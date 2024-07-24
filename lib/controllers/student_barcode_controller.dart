import 'package:control_proctor/models/student_barcode_in_exam_room/student_barcode_in_exam_room.dart';
import 'package:get/get.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../tools/response_handler.dart';

class StudentsInExamRoomController extends GetxController {
  StudentBarcodeInExamRoom? studentBarcodeInExamRoom;

  @override
  void onInit() async {
    Future.wait([
      getAllStudentsInExamRoom(),
    ]);
    super.onInit();
  }

  Future<void> getAllStudentsInExamRoom() async {
    final response =
        await ResponseHandler<StudentBarcodeInExamRoom>().getResponse(
      path: "${StudentsLinks.studentBarcodesExamRoom}/",
      converter: StudentBarcodeInExamRoom.fromJson,
      type: ReqTypeEnum.GET,
    );
  }
}
