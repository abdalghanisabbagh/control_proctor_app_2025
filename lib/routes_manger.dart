import 'package:control_proctor/bindings/bindings.dart';
import 'package:control_proctor/screens/attendance.dart';
import 'package:control_proctor/screens/login_form.dart';
import 'package:control_proctor/screens/next_exams_screen.dart';
import 'package:control_proctor/screens/students_in_exam_room/students_in_exam_room_screen.dart';
import 'package:get/get.dart';

import 'screens/all_exams_screen.dart';

class Routes {
  static const String initialRoute = "/login";
  static const String loginRoute = "/login";
  static const String nextExams = "/NextExams";
  static const String allExams = "/AllExams";
  static const String attendance = "/Attendance";
  static const String studentsInExamRoom = "/StudentsInExamRoom";

  static List<GetPage> routes = [
    GetPage(
      name: loginRoute,
      page: () => LoginForm(),
      transition: Transition.fade,
      binding: LoginBinding(),
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      binding: NextExamBindings(),
      name: nextExams,
      page: () => const NextExamsPage(),
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      binding: AllExamBindings(),
      name: allExams,
      page: () => const AllExams(),
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: attendance,
      page: () => const Attendance(),
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      binding: StudentsInExamRoomBinding(),
      name: studentsInExamRoom,
      page: () => const StudentsInExamRoomScreen(),
      transitionDuration: const Duration(seconds: 1),
    ),
  ];
}
