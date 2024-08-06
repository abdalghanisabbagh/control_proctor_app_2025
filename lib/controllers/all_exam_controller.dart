import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/control_mission/control_missions_res_model.dart';
import '../models/failure_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../tools/response_handler.dart';

class AllExamController extends GetxController {
  bool isLoadingGetControlMission = false;
  List<ValueItem> optionsControlMission = <ValueItem>[];

  Future<void> getControlMissionByproctor() async {
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

  @override
  void onInit() {
    getControlMissionByproctor();

    super.onInit();
  }
}
