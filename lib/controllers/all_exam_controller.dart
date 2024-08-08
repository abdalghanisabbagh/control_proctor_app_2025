import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/control_mission/control_missions_res_model.dart';
import '../models/failure_model.dart';
import '../models/next exam/next_exam_res_model.dart';
import '../models/next%20exam/next_exams_res_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../tools/response_handler.dart';

class AllExamController extends GetxController {
  bool isLoadingGetControlMission = false;
  bool isLoadingGetNextExam = false;
  List<ValueItem> optionsControlMission = <ValueItem>[];
  List<NextExamResModel> nextExamList = [];

  Future<void> getControlMissionsByProctorId() async {
    isLoadingGetControlMission = true;

    update();

    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path: ProctorsLinks.getControlMissionByProctor,
      converter: ControlMissionsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsControlMission = items;
      },
    );
    isLoadingGetControlMission = false;
    update();
  }

  Future<void> getExamMissionsByControlMissionId(
      {required int controlMissionId}) async {
    isLoadingGetNextExam = true;

    update();

    ResponseHandler<NextExamsResModel> responseHandler = ResponseHandler();
    Either<Failure, NextExamsResModel> response =
        await responseHandler.getResponse(
      path: '${ProctorsLinks.getControlMissionByProctor}/$controlMissionId',
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
      },
      (r) {
        nextExamList = r.data!;
      },
    );
    isLoadingGetNextExam = false;
    update();
  }

  @override
  void onInit() {
    getControlMissionsByProctorId();

    super.onInit();
  }
}
