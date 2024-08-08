import '../class_room/class_room_res_model.dart';

class ExamRoomResModel {
  ExamRoomResModel({this.id, this.name, this.stage, this.classRoomResModel});

  ExamRoomResModel.fromJson(json) {
    id = json['ID'];
    name = json['Name'];
    stage = json['Stage'];
    classRoomResModel = ClassRoomResModel.fromJson(json['school_class']);
  }

  int? id;
  String? name;
  String? stage;
  ClassRoomResModel? classRoomResModel;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['Stage'] = stage;
    data['school_class'] = classRoomResModel?.toJson();
    return data;
  }
}
