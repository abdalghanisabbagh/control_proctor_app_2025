import '../class_room/class_room_res_model.dart';

class StudentResModel {
  StudentResModel({
    this.iD,
    this.blbId,
    this.gradesID,
    this.gradeName,
    this.schoolsID,
    this.cohortID,
    this.cohortName,
    this.schoolClassID,
    this.schoolClassName,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.email,
    this.secondLang,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.classRoomResModel,
    this.active,
    this.religion,
  });

  StudentResModel.fromJson(json) {
    iD = json['ID'];
    blbId = json['Blb_Id'];
    gradesID = json['Grades_ID'];
    schoolsID = json['Schools_ID'];
    cohortID = json['Cohort_ID'];
    schoolClassID = json['School_Class_ID'];
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    email = json['Email'];
    secondLang = json['Second_Lang'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    religion = json['Religion'];
    active = json['Active'];
  }

  int? active;
  int? blbId;
  ClassRoomResModel? classRoomResModel;
  int? cohortID;
  String? cohortName;
  String? createdAt;
  int? createdBy;
  String? email;
  String? firstName;
  String? gradeName;
  int? gradesID;
  int? iD;
  int? schoolClassID;
  String? schoolClassName;
  int? schoolsID;
  String? secondLang;
  String? secondName;
  String? thirdName;
  DateTime? updatedAt;
  int? updatedBy;
  String? religion;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Blb_Id'] = blbId;
    data['Grades_ID'] = gradesID;
    data['Schools_ID'] = schoolsID;
    data['Cohort_ID'] = cohortID;
    data['School_Class_ID'] = schoolClassID;
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    data['Email'] = email;
    data['Second_Lang'] = secondLang;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Active'] = active;
    data['Religion'] = religion;
    return data;
  }
}
