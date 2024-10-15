import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart' hide Response;
import 'package:package_info_plus/package_info_plus.dart';

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/login_response/login_res_model.dart';
import '../models/token_model.dart';
import '../resource_manager/ReusableWidget/show_dialogue.dart';
import '../services/token_service.dart';
import '../tools/response_handler.dart';
import 'profile_controller.dart';

class LoginController extends GetxController {
  bool isLoading = false;
  PackageInfo? packageInfo;
  ProfileController profileController = Get.find<ProfileController>();
  bool showPass = true;
  TokenService tokenService = Get.find<TokenService>();

  /// Logs the user in with the provided username and password.
  ///
  /// Shows an error dialogue if the request fails.
  ///
  /// Saves the user's profile to the hive box if the request is successful.
  ///
  /// Sets the [isLoading] state to true when the function is called and to false when the function is done.
  ///
  /// Returns true if the login was successful, false otherwise.
  Future<bool> login(String username, String password) async {
    isLoading = true;
    bool isLogin = false;
    update();
    ResponseHandler<LoginResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${AuthLinks.login}?mobile=1",
      converter: LoginResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "userName": username,
        "password": password,
      },
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.context!);
        isLogin = false;
      },
      (r) {
        tokenService.saveTokenModelToHiveBox(
          TokenModel(
            aToken: r.accessToken!,
            rToken: r.refreshToken!,
          ),
        );
        profileController.saveProfileToHiveBox(r.userProfile!);
        isLogin = true;
      },
    );

    isLoading = false;
    update();
    return isLogin;
  }

  @override

  /// The on init method of the login controller.
  ///
  /// This method is called by the [Get] framework when the controller is initialized.
  ///
  /// It calls [PackageInfo.fromPlatform] to get the package information of the app.
  /// This information is used in the login page to show the version of the app.
  ///
  /// It calls [update] at the end to notify the widgets that depend on this controller
  /// to rebuild.
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    update();
  }

  setShowPass() {
    showPass = !showPass;
    update(['pass_icon']);
  }
}
