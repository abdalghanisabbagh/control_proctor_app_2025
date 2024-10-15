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
import '../resource_manager/ReusableWidget/show_dialogue.dart';
import '../tools/response_handler.dart';

class AllExamController extends GetxController {
  bool isLoadingGetControlMission = false;
  bool isLoadingGetNextExam = false;
  List<NextExamResModel> nextExamList = [];
  List<ValueItem> optionsControlMission = <ValueItem>[];

  /// Gets a list of control missions by proctor id.
  ///
  /// After getting the list of control missions, it will be converted to a list of [ValueItem]
  /// and stored in [optionsControlMission].
  ///
  /// The loading state is stored in [isLoadingGetControlMission].
  ///
  /// If the request failed, it will show an error dialogue with the message from the response.
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

  /// Gets a list of exam missions by control mission id.
  ///
  /// After getting the list of exam missions, it will be stored in [nextExamList].
  ///
  /// The loading state is stored in [isLoadingGetNextExam].
  ///
  /// If the request failed, it will show an error dialogue with the message from the response.
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

  /// The on init method of the all exam controller.
  ///
  /// This method is called by the [Get] framework when the controller is initialized.
  ///
  /// It calls [getControlMissionsByProctorId] to get the list of control missions
  /// by the proctor id. This method is called only once and is reused when the
  /// page is navigated to.
  void onInit() {
    getControlMissionsByProctorId();

    super.onInit();
  }
}
