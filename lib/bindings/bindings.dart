import 'package:get/get.dart';

import '../controllers/all_exam_controller.dart';
import '../controllers/controllers.dart';
import '../services/services.dart';

/// AllExamBindings is a binding that provides an instance of [AllExamController]
/// to the [Get] framework. The [AllExamController] is a controller that
/// is responsible for managing the state of the all exams page.
class AllExamBindings extends Bindings {
  /// The dependencies of the all exams page. This method is called by the
  /// [Get] framework when the page is navigated to.
  @override
  void dependencies() {
    /// The [AllExamController] is a controller that is responsible for managing
    /// the state of the all exams page. It is created with the [Get.lazyPut]
    /// method, which ensures that the controller is created only once and is
    /// reused when the page is navigated to.
    Get.lazyPut<AllExamController>(
      () => AllExamController(),
      fenix: true,
    );
  }
}

class InitialBindings extends Bindings {
  @override

  /// The initial bindings of the app. This method is called by the
  /// [Get] framework when the app is initialized.
  ///
  /// The [StudentsInExamRoomService] is a service that is responsible for
  /// managing the state of the students in exam room. It is created with the
  /// [Get.put] method and is marked as permanent, which means that it is
  /// created only once and is reused when the app is restarted.
  ///
  /// The [TokenService] is a service that is responsible for managing the
  /// access token of the user. It is created with the [Get.put] method and is
  /// marked as permanent, which means that it is created only once and is
  /// reused when the app is restarted.
  ///
  /// The [ProfileController] is a controller that is responsible for managing
  /// the profile of the user. It is created with the [Get.put] method and is
  /// marked as permanent, which means that it is created only once and is
  /// reused when the app is restarted.
  ///
  /// The [SideMenuController] is a controller that is responsible for managing
  /// the side menu of the app. It is created with the [Get.put] method and is
  /// marked as permanent, which means that it is created only once and is
  /// reused when the app is restarted.
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

/// The login binding of the app. This method is called by the
/// [Get] framework when the login page is navigated to.
///
/// The [LoginController] is a controller that is responsible for managing the
/// state of the login page. It is created with the [Get.lazyPut] method, which
/// ensures that the controller is created only once and is reused when the
/// page is navigated to.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
      fenix: true,
    );
  }
}

/// The next exam binding of the app. This method is called by the
/// [Get] framework when the next exam page is navigated to.
///
/// The [NextExamController] is a controller that is responsible for managing
/// the state of the next exam page. It is created with the [Get.lazyPut]
/// method, which ensures that the controller is created only once and is reused
/// when the page is navigated to.
class NextExamBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NextExamController>(
      () => NextExamController(),
      fenix: true,
    );
  }
}

/// The students in exam room binding of the app. This method is called by the
/// [Get] framework when the students in exam room page is navigated to.
///
/// The [StudentsInExamRoomController] is a controller that is responsible for
/// managing the state of the students in exam room page. It is created with the
/// [Get.lazyPut] method, which ensures that the controller is created only once
/// and is reused when the page is navigated to.
class StudentsInExamRoomBinding extends Bindings {
  @override
  void dependencies() {
    /// Create an instance of the [StudentsInExamRoomController] and put it in
    /// the [Get] framework. The [fenix] property is set to true so that the
    /// controller is not recreated when the page is navigated to.
    Get.lazyPut<StudentsInExamRoomController>(
      () => StudentsInExamRoomController(),
      fenix: true,
    );
  }
}
