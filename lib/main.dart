import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worker_manager/worker_manager.dart';

import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await workerManager.init();

  await Future.wait([
    Hive.initFlutter(),
    Hive.openBox('Token'),
    Hive.openBox('Profile'),
    Hive.openBox('StudentsInExamRoom'),
  ]);

  runApp(MyApp());
}
