import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentsInExamRoomService extends GetxService {
  int? _selectedExamMissionId;
  int? _selectedExamRoomId;

  FutureOr<int?> get selectedExamMissionId async {
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
    _selectedExamMissionId =
        await Hive.box('StudentsInExamRoom').get('selectedExamMissionId');
  }

  Future<void> saveTohiveBox() async {
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

  void setSelectedExamMissionId(int id) {
    _selectedExamMissionId = id;
  }

  Future<void> setSelectedExamRoomAndExamMissionId({
    int? examRoomId,
    int? examMissionId,
  }) async {
    _selectedExamRoomId = examRoomId;
    _selectedExamMissionId = examMissionId;

    await saveTohiveBox();
  }

  void setSelectedExamRoomId(int id) {
    _selectedExamRoomId = id;
  }
}
