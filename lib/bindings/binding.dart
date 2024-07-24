import 'package:control_proctor/controller/login_controller.dart';
import 'package:control_proctor/controller/next_exam_controller.dart';
import 'package:control_proctor/controller/profile_controller.dart';
import 'package:control_proctor/services/token_service.dart';
import 'package:get/get.dart';

import '../controller/side_menu_controller.dart';

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
