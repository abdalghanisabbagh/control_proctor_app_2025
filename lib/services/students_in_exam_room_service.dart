import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentsInExamRoomService extends GetxService {
  int? _selectedExamRoomId;
  int? _selectedExamMissionId;

  FutureOr<int?> get selectedExamRoomId async {
    if (_selectedExamRoomId == null) {
      await getFromHiveBox();
    }
    return _selectedExamRoomId;
  }

  FutureOr<int?> get selectedExamMissionId async {
    if (_selectedExamMissionId == null) {
      await getFromHiveBox();
    }
    return _selectedExamMissionId;
  }

  void setSelectedExamRoomId(int id) {
    _selectedExamRoomId = id;
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

  Future<void> deleteFromHiveBox() async {
    _selectedExamRoomId = null;
    _selectedExamMissionId = null;
    await Future.wait([
      Hive.box('StudentsInExamRoom').clear(),
    ]);
  }
}
