import 'package:get/get.dart';

import 'bindings/bindings.dart';
import 'screens/all_exams_screen.dart';
import 'screens/attendance.dart';
import 'screens/login_form.dart';
import 'screens/next_exams_screen.dart';
import 'screens/students_in_exam_room/students_in_exam_room_screen.dart';

class Routes {
  static const String allExams = "/AllExams";
  static const String attendance = "/Attendance";
  static const String initialRoute = "/login";
  static const String loginRoute = "/login";
  static const String nextExams = "/NextExams";
  static final unknownRoute = GetPage(
    name: Routes.loginRoute,
    page: () => LoginForm(),
    transition: Transition.fade,
    binding: LoginBinding(),
    transitionDuration: const Duration(seconds: 1),
  );
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
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      binding: AllExamBindings(),
      name: allExams,
      page: () => const AllExams(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: attendance,
      page: () => const Attendance(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      binding: StudentsInExamRoomBinding(),
      name: studentsInExamRoom,
      page: () => const StudentsInExamRoomScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];

  static const String studentsInExamRoom = "/StudentsInExamRoom";
}
