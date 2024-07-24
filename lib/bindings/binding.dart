import 'package:control_proctor/services/services.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentsInExamRoomService>(
      StudentsInExamRoomService(),
      permanent: true,
    );
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put<TokenService>(
      TokenService(),
      permanent: true,
    );
    Get.put<ProfileController>(
      ProfileController(),
      permanent: true,
    );
  }
}

class TokenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TokenService(), permanent: true);
  }
}

class NextExamBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NextExamController>(
      NextExamController(),
      permanent: true,
    );
    Get.put<SideMenuController>(
      SideMenuController(),
      permanent: true,
    );
  }
}

class StudentsInExamRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentsInExamRoomController>(
      StudentsInExamRoomController(),
      permanent: true,
    );
  }
}
