import '../grade/grade_res_model.dart';
import '../subject/subject_res_model.dart';

class ExamMissionResModel {
  int? duration;

  String? endTime;

  GradeResModel? gradeResModel;
  int? iD;
  String? month;
  bool? period;
  String? startTime;
  SubjectResModel? subjectResModel;
  String? year;
  ExamMissionResModel({
    this.iD,
    this.month,
    this.year,
    this.period,
    this.duration,
    this.startTime,
    this.endTime,
    this.gradeResModel,
    this.subjectResModel,
  });
  ExamMissionResModel.fromJson(json) {
    iD = json['ID'];
    month = json['Month'];
    year = json['Year'];
    period = json['Period'];
    duration = json['duration'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    gradeResModel =
        json['grades'] == null ? null : GradeResModel.fromJson(json['grades']);
    subjectResModel = json['subjects'] == null
        ? null
        : SubjectResModel.fromJson(json['subjects']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (iD != null) data['ID'] = iD;
    if (month != null) data['Month'] = month;
    if (year != null) data['Year'] = year;
    if (period != null) data['Period'] = period;
    if (duration != null) data['duration'] = duration;
    if (startTime != null) data['start_time'] = startTime;
    if (endTime != null) data['end_time'] = endTime;

    return data;
  }
}
