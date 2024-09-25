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
import 'web_socket_controller.dart';

class LoginController extends GetxController {
  bool isLoading = false;
  PackageInfo? packageInfo;
  ProfileController profileController = Get.find<ProfileController>();
  bool showPass = true;
  TokenService tokenService = Get.find<TokenService>();

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
        Get.put<WebSocketController>(
          WebSocketController(),
          permanent: true,
        );
        isLogin = true;
      },
    );

    isLoading = false;
    update();
    return isLogin;
  }

  @override
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
