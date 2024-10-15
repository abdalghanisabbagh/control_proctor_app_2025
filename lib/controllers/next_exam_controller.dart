import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/failure_model.dart';
import '../models/next exam/next_exam_res_model.dart';
import '../models/next%20exam/next_exams_res_model.dart';
import '../resource_manager/ReusableWidget/show_dialogue.dart';
import '../tools/response_handler.dart';
import 'controllers.dart';

class NextExamController extends GetxController {
  List<NextExamResModel> filteredNextExamList = [];
  bool isLoadingGetNextExam = false;
  List<NextExamResModel> nextExamList = [];
  DateTime? selectedDate;
  final userId = Get.find<ProfileController>().cachedUserProfile!.iD;

  /// This method is called when the selected date is changed. It stores the
  /// selected date and calls [filterList] to filter the list of next exams
  /// based on the selected date and the query string.
  ///
  /// If the query string is empty and the selected date is null, it will show
  /// all exams. Otherwise, it will show the exams that match the query string
  /// and are on the selected date.
  void fetchDataForSelectedDate(DateTime date) {
    selectedDate = date;
    filterList('');
  }

  /// This method is called when the query string is changed. It filters the list
  /// of next exams based on the query string and the selected date.
  ///
  /// If the query string is empty and the selected date is null, it will show
  /// all exams. Otherwise, it will show the exams that match the query string
  /// and are on the selected date.
  void filterList(String query) {
    if (query.isEmpty && selectedDate == null) {
      filteredNextExamList = nextExamList;
    } else {
      filteredNextExamList = nextExamList.where((exam) {
        final matchQuery = exam.examRoomResModel?.name
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false;
        final matchDate = selectedDate == null
            ? true
            : exam.examMissionsResModel?.data?.any((mission) {
                  final examDate = DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(mission.startTime!));
                  final selectedFormattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate!);
                  return examDate == selectedFormattedDate;
                }) ??
                false;
        return matchQuery && matchDate;
      }).toList();
    }
    update();
  }

  /// Gets all exam missions by proctor id.
  ///
  /// The loading state is stored in [isLoadingGetNextExam].
  ///
  /// If the request failed, it will show an error dialogue with the message from the response.
  ///
  /// The list of exam missions will be stored in [nextExamList] and [filteredNextExamList] when the request is successful.
  Future<void> getAllExamMissionsByProctorId() async {
    isLoadingGetNextExam = true;

    update();
    ResponseHandler<NextExamsResModel> responseHandler = ResponseHandler();
    Either<Failure, NextExamsResModel> response =
        await responseHandler.getResponse(
      path: ExamLinks.examRoomNextExam,
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
        filteredNextExamList = nextExamList;

        isLoadingGetNextExam = false;
        update();
      },
    );
  }

  @override

  /// The on init method of the next exam controller.
  ///
  /// This method is called by the [Get] framework when the controller is initialized.
  ///
  /// It calls [getAllExamMissionsByProctorId] to get all exam missions by proctor id.
  /// The method is called only once and is reused when the page is navigated to.
  void onInit() {
    super.onInit();
    getAllExamMissionsByProctorId();
  }

  /// Resets the selected date and query string filters to their default values.
  ///
  /// This method is typically called when the user navigates away from the page
  /// and the filters should be reset to their default state.
  void resetFilters() {
    selectedDate = null;
    filterList('');
  }
}
