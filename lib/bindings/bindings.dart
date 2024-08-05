import 'package:control_proctor/services/services.dart';
import 'package:get/get.dart';

import '../controllers/all_exam_controller.dart';
import '../controllers/controllers.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentsInExamRoomService>(
      StudentsInExamRoomService(),
      permanent: true,
    );
    Get.put(
      TokenService(),
      permanent: true,
    );

    Get.put<ProfileController>(
      ProfileController(),
      permanent: true,
    );

    Get.put<SideMenuController>(
      SideMenuController(),
      permanent: true,
    );
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
      fenix: true,
    );
  }
}

class NextExamBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NextExamController>(
      () => NextExamController(),
      fenix: true,
    );
  }
}
class AllExamBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllExamController>(
      () => AllExamController(),
      fenix: true,
    );
  }
}

class StudentsInExamRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentsInExamRoomController>(
      () => StudentsInExamRoomController(),
      fenix: true,
    );
  }
}
