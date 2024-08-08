import '../next%20exam/next_exam_res_model.dart';

class NextExamsResModel {
  List<NextExamResModel>? data;

  NextExamsResModel({this.data});

  NextExamsResModel.fromJson(json) {
    data = List<NextExamResModel>.from(
        json.map((e) => NextExamResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
