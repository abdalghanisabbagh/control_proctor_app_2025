import 'package:control_proctor/models/barcodes/barcodes_res_model.dart';
import 'package:control_proctor/models/subject/subjects_res_model.dart';

class StudentBarcodeInExamRoom {
  SubjectsResModel? subjectsResModel;

  BarcodesResModel? barcodesResModel;

  StudentBarcodeInExamRoom({this.subjectsResModel, this.barcodesResModel});

  StudentBarcodeInExamRoom.fromJson(json) {
    subjectsResModel = json['subject'] != null
        ? SubjectsResModel.fromJson(json['subject'])
        : null;
    barcodesResModel = json['student_barcodes'] != null
        ? BarcodesResModel.fromJson(json['student_barcodes'])
        : null;
  }
}
