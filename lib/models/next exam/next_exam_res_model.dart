import 'package:control_proctor/models/exam%20room/exam_room_res_model.dart';

import '../exam mission/exam_missions_res_model.dart';

class NextExamResModel {
  ExamRoomResModel? examRoomResModel;
  String? month;
  String? year;
  bool? period;
  ExamMissionsResModel? examMissionsResModel;

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
    examMissionsResModel = json['exam_missions'] != null
        ? ExamMissionsResModel.fromJson(json['exam_missions'])
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
      data['exam_missions'] = examMissionsResModel!.toJson();
    }
    return data;
  }
}
