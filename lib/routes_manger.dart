import 'package:control_proctor/bindings/binding.dart';
import 'package:control_proctor/screens/attendance.dart';
import 'package:control_proctor/screens/next_exams_Screen.dart';
import 'package:control_proctor/screens/login_form.dart';
import 'package:get/get.dart';

import 'screens/all_exams_screen.dart';

class Routes {
  static const String initialRoute = "/login";
  static const String loginRoute = "/login";
  static const String nextExams = "/NextExams";
  static const String allExams = "/AllExams";
  static const String attendance = "/Attendance";

  static List<GetPage> routes = [
    GetPage(
        name: loginRoute,
        page: () => LoginForm(),
        transition: Transition.fade,
        binding: LoginBinding(),
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        binding: NextExamBindings(),
        name: nextExams,
        page: () => const NextExamPage(),
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: allExams,
        page: () => const AllExams(),
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: attendance,
        page: () => const Attendance(),
        transitionDuration: const Duration(seconds: 1)),
  ];
}
