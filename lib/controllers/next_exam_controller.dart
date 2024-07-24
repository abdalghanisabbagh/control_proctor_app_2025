import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_proctor/models/next%20exam/next_exams_res_model.dart';
import 'package:control_proctor/tools/response_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/failure_model.dart';
import '../models/next exam/next_exam_res_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';

class NextExamController extends GetxController {
  bool isLoadingGetNextExam = false;
  List<NextExamResModel> nextExamList = [];

  @override
  void onInit() {
    super.onInit();
    getAllExamMissionsByControlMission(16);
  }

  Future<void> getAllExamMissionsByControlMission(int controlMissionId) async {
    isLoadingGetNextExam = true;

    update();
    ResponseHandler<NextExamsResModel> responseHandler = ResponseHandler();
    Either<Failure, NextExamsResModel> response =
        await responseHandler.getResponse(
      path: "${ExamLinks.examRoomNextExam}/16",
      converter: NextExamsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoadingGetNextExam = false;
        update();
      },
      (r) {
        nextExamList = r.data!;

        isLoadingGetNextExam = false;
        update();
      },
    );
  }
}
