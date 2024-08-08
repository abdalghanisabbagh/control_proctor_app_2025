import '../exam mission/exam_missions_res_model.dart';
import '../exam%20room/exam_room_res_model.dart';

class NextExamResModel {
  ExamMissionsResModel? examMissionsResModel;

  ExamRoomResModel? examRoomResModel;

  String? month;
  bool? period;
  String? year;
  NextExamResModel(
      {this.examRoomResModel,
      this.month,
      this.year,
      this.period,
      this.examMissionsResModel});
  NextExamResModel.fromJson(json) {
    examRoomResModel = json['exam_room'] != null
        ? ExamRoomResModel.fromJson(json['exam_room'])
        : null;
    month = json['Month'];
    year = json['Year'];
    period = json['Period'];
    examMissionsResModel = json['examMissions'] != null
        ? ExamMissionsResModel.fromJson(json['examMissions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examRoomResModel != null) {
      data['exam_room'] = examRoomResModel!.toJson();
    }
    data['Month'] = month;
    data['Year'] = year;
    data['Period'] = period;
    if (examMissionsResModel != null) {
      data['examMissions'] = examMissionsResModel!.toJson();
    }
    return data;
  }
}
