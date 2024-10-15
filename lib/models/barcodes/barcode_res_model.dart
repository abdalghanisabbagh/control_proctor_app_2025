import '../student/student_res_model.dart';
import '../student_seat/student_seat_res_model.dart';

class BarcodeResModel {
  int? attendanceStatusId;

  String? barcode;

  int? examMissionID;
  String? examVersion;
  int? iD;
  int? isCheating;
  StudentResModel? student;
  String? studentDegree;
  int? studentID;
  StudentSeatNumberResModel? studentSeatNumberResModel;
  int? studentSeatNumnbersID;
  BarcodeResModel({
    this.iD,
    this.examMissionID,
    this.studentID,
    this.studentSeatNumnbersID,
    this.barcode,
    this.attendanceStatusId,
    this.studentDegree,
    this.examVersion,
    this.isCheating,
    this.student,
    this.studentSeatNumberResModel,
  });
  BarcodeResModel.fromJson(json) {
    iD = json['ID'];
    examMissionID = json['Exam_Mission_ID'];
    studentID = json['Student_ID'];
    studentSeatNumnbersID = json['student_seat_numbers_ID'];
    barcode = json['Barcode'];
    attendanceStatusId = json['AttendanceStatusId'];
    studentDegree = json['StudentDegree'];
    examVersion = json['Exam_Version'];
    isCheating = json['isCheating'];
    student = json['student'] != null
        ? StudentResModel.fromJson(json['student'])
        : null;

    studentSeatNumberResModel = json['student_seat_numbers'] != null
        ? StudentSeatNumberResModel.fromJson(json['student_seat_numbers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Exam_Mission_ID'] = examMissionID;
    data['Student_ID'] = studentID;
    data['student_seat_numbers_ID'] = studentSeatNumnbersID;
    data['Barcode'] = barcode;
    data['AttendanceStatusId'] = attendanceStatusId;
    data['StudentDegree'] = studentDegree;
    data['Exam_Version'] = examVersion;
    data['isCheating'] = isCheating;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (studentSeatNumberResModel != null) {
      data['student_seat_numbers'] = studentSeatNumberResModel!.toJson();
    }
    return data;
  }
}
