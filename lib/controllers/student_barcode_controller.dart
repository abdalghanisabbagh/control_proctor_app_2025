import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_proctor/models/barcodes/barcode_res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/student_barcode_in_exam_room/student_barcode_in_exam_room.dart';
import '../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../resource_manager/ReusableWidget/show_dialogue.dart';
import '../services/students_in_exam_room_service.dart';
import '../tools/response_handler.dart';

class StudentsInExamRoomController extends GetxController {
  bool isLoading = true;
  bool locked = true;
  final TextEditingController passwordController = TextEditingController();
  StudentBarcodeInExamRoom? studentBarcodeInExamRoom;
  List<BarcodeResModel> barcodes = [];
  bool validating = false;

  /// Activate a student in the exam room.
  ///
  /// Activates a student based on the student's id.
  ///
  /// The student's attendance status is set to 13 (active) if the request is successful.
  ///
  /// If the request fails, an error dialogue is shown with the error message from the response.
  Future<void> activateStudent(int id) async {
    final responseHandler = ResponseHandler<void>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentUuid}/$id/activate',
      body: {},
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
    );
    await response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (_) async {
        // studentBarcodeInExamRoom!.barcodesResModel!.barcodes!
        // barcodes
        //     .firstWhereOrNull((element) => element.student?.iD == id)!
        //     .attendanceStatusId = 13;

        await getAllStudentsInExamRoom();
        // update();
      },
    );
  }

  /// Gets all students in the exam room.
  ///
  /// The loading state is stored in [isLoading].
  ///
  /// The selected exam room id and selected exam mission id are retrieved from the
  /// [StudentsInExamRoomService] using [selectedExamRoomId] and [selectedExamMissionId]
  /// respectively.
  ///
  /// The response is handled by the [ResponseHandler] and if the request fails,
  /// an error dialogue is shown with the error message from the response.
  ///
  /// If the request is successful, the [studentBarcodeInExamRoom] is set to the
  /// response and the [isLoading] is set to false.
  Future<void> getAllStudentsInExamRoom() async {
    isLoading = true;
    update();

    final selectedExamRoomId =
        await Get.find<StudentsInExamRoomService>().selectedExamRoomId;
    final selectedExamMissionIds =
        await Get.find<StudentsInExamRoomService>().selectedExamMissionId;

    barcodes = [];
    for (var i = 0; i < selectedExamMissionIds!.length; i++) {
      await getStudents(selectedExamRoomId!, selectedExamMissionIds[i]!);
    }
    isLoading = false;
    update();
  }

  Future getStudents(int roomId, int missionId) async {
    final response =
        await ResponseHandler<StudentBarcodeInExamRoom>().getResponse(
      path: "${StudentsLinks.studentBarcodesExamRoom}/$roomId",
      converter: StudentBarcodeInExamRoom.fromJson,
      params: {
        'examMissionId': missionId,
      },
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        print(l.message);
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.context!);
      },
      (r) {
        studentBarcodeInExamRoom = r;
        barcodes.addAll(r.barcodesResModel?.barcodes ?? []);
        print(missionId);
      },
    );
  }

  /// Marks a student as cheating in the exam room.
  ///
  /// Calls the [markCheatingStudent] endpoint with the student's barcode and
  /// gets the list of students in the exam room again after the request is
  /// done. The [isLoading] state is set to true when the function is called and
  /// to false when the function is done.
  ///
  /// If the request fails, an error dialogue is shown with the error message
  /// from the response.
  void markStudentCheating({required String barcode}) async {
    final ResponseHandler responseHandler = ResponseHandler<void>();

    await responseHandler.getResponse(
      path: '${StudentsLinks.markCheatingStudent}/$barcode',
      type: ReqTypeEnum.GET,
      converter: (_) {},
    );
    getAllStudentsInExamRoom();
  }

  @override

  /// Deletes the selected exam room and exam mission from the hive box when the
  /// page is closed.
  void onClose() async {
    await Future.wait([
      Get.find<StudentsInExamRoomService>().deleteFromHiveBox(),
    ]);
    barcodes.clear();
    studentBarcodeInExamRoom = null;
    super.onClose();
  }

  @override

  /// The on init method of the students in exam room controller.
  ///
  /// This method is called by the [Get] framework when the controller is initialized.
  ///
  /// It calls [getAllStudentsInExamRoom] to get all students in the exam room.
  ///
  /// The method is called only once and is reused when the page is navigated to.
  void onInit() async {
    await Future.wait([
      getAllStudentsInExamRoom(),
    ]);
    super.onInit();
  }

  /// Unlocks the exam room by validating the proctor's principle password.
  ///
  /// Sets the [validating] state to true when the function is called and to false
  /// when the function is done. The [passwordController] is cleared when the
  /// function is done.
  ///
  /// If the request fails, an error dialogue is shown with the error message
  /// from the response.
  ///
  /// If the request is successful, a success flash bar is shown with the message
  /// "Validated Successfully" and the [locked] state is set to false.
  void unlock() {
    validating = true;
    update();
    final ResponseHandler responseHandler = ResponseHandler<void>();

    responseHandler
        .getResponse(
      path: ProctorsLinks.validatePrinciple,
      type: ReqTypeEnum.POST,
      body: {
        "password": passwordController.text,
      },
      converter: (_) {},
    )
        .then(
      (value) {
        passwordController.clear();
        validating = false;
        update();
        value.fold(
          (l) => MyAwesomeDialogue(
                  title: 'Error', desc: l.message, dialogType: DialogType.error)
              .showDialogue(Get.context!),
          (_) {
            Get.back();
            MyFlashBar.showSuccess('Validated Successfully', 'Success').show(
              Get.key.currentContext!,
            );
            locked = false;
            update();
          },
        );
      },
    );
  }

  /// Unmarks a student as cheating in the exam room.
  ///
  /// Calls the [unMarkCheatingStudent] endpoint with the student's barcode.
  ///
  /// If the request fails, an error dialogue is shown with the error message
  /// from the response.
  ///
  /// If the request is successful, the list of students in the exam room is
  /// retrieved again by calling [getAllStudentsInExamRoom].
  void unMarkCheatingStudent({required String barcode}) async {
    final ResponseHandler responseHandler = ResponseHandler();

    await responseHandler
        .getResponse(
      path: '${StudentsLinks.unMarkCheatingStudent}/$barcode',
      body: {},
      converter: (_) {},
      type: ReqTypeEnum.GET,
    )
        .then((value) {
      value.fold(
        (l) {
          MyAwesomeDialogue(
            title: 'Error',
            desc: l.message,
            dialogType: DialogType.error,
          ).showDialogue(Get.key.currentContext!);
        },
        (_) {},
      );
    });
    getAllStudentsInExamRoom();
  }
}
