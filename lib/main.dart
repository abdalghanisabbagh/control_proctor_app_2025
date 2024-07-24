import 'package:control_proctor/bindings/binding.dart';
import 'package:control_proctor/main_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TokenBindings().dependencies();
  await Future.wait([
    Hive.initFlutter(),
    Hive.openBox('Token'),
    Hive.openBox('Profile'),
    Hive.openBox('StudentsInExamRoom'),
  ]);

  runApp(MyApp());
}
