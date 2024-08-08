import '../class_room/class_room_res_model.dart';

class ExamRoomResModel {
  ClassRoomResModel? classRoomResModel;

  int? id;

  String? name;
  String? stage;
  ExamRoomResModel({this.id, this.name, this.stage, this.classRoomResModel});
  ExamRoomResModel.fromJson(json) {
    id = json['ID'];
    name = json['Name'];
    stage = json['Stage'];
    classRoomResModel = ClassRoomResModel.fromJson(json['school_class']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['Stage'] = stage;
    data['school_class'] = classRoomResModel?.toJson();
    return data;
  }
}
