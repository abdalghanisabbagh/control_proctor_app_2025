import '../barcodes/barcodes_res_model.dart';
import '../subject/subject_res_model.dart';

class StudentBarcodeInExamRoom {
  SubjectResModel? subjectsResModel;

  BarcodesResModel? barcodesResModel;

  StudentBarcodeInExamRoom({this.subjectsResModel, this.barcodesResModel});

  StudentBarcodeInExamRoom.fromJson(json) {
    subjectsResModel = json['subject'] != null
        ? SubjectResModel.fromJson(json['subject'])
        : null;
    barcodesResModel = json['student_barcodes'] != null
        ? BarcodesResModel.fromJson(json['student_barcodes'])
        : null;
  }
}
