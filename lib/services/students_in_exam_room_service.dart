import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentsInExamRoomService extends GetxService {
  List<int?>? _selectedExamMissionId;
  int? _selectedExamRoomId;

  FutureOr<List<int?>?> get selectedExamMissionId async {
    if (_selectedExamMissionId == null) {
      await getFromHiveBox();
    }
    return _selectedExamMissionId;
  }

  FutureOr<int?> get selectedExamRoomId async {
    if (_selectedExamRoomId == null) {
      await getFromHiveBox();
    }
    return _selectedExamRoomId;
  }

  Future<void> deleteFromHiveBox() async {
    _selectedExamRoomId = null;
    _selectedExamMissionId = null;
    await Future.wait([
      Hive.box('StudentsInExamRoom').clear(),
    ]);
  }

  Future<void> getFromHiveBox() async {
    _selectedExamRoomId =
        await Hive.box('StudentsInExamRoom').get('selectedExamRoomId');
    _selectedExamMissionId = (await Hive.box('StudentsInExamRoom')
            .get('selectedExamMissionId') as List<dynamic>?)
        ?.map((e) => e as int?)
        .toList();
  }

  Future<void> saveToHiveBox() async {
    await Future.wait([
      Hive.box('StudentsInExamRoom').put(
        'selectedExamRoomId',
        _selectedExamRoomId,
      ),
      Hive.box('StudentsInExamRoom').put(
        'selectedExamMissionId',
        _selectedExamMissionId,
      ),
    ]);

    await Hive.box('StudentsInExamRoom').flush();
  }

  void setSelectedExamMissionId(List<int> ids) {
    _selectedExamMissionId = ids;
  }

  Future<void> setSelectedExamRoomAndExamMissionId({
    int? examRoomId,
    List<int?>? examMissionIds,
  }) async {
    _selectedExamRoomId = examRoomId;
    _selectedExamMissionId = examMissionIds;

    await saveToHiveBox();
  }

  void setSelectedExamRoomId(int id) {
    _selectedExamRoomId = id;
  }
}
