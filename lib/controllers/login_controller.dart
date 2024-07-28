import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_proctor/controllers/profile_controller.dart';
import 'package:get/get.dart' hide Response;

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/login_response/login_res_model.dart';
import '../models/token_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/token_service.dart';
import '../tools/response_handler.dart';

class LoginController extends GetxController {
  bool showPass = true;
  bool isLoading = false;

  TokenService tokenService = Get.find<TokenService>();

  ProfileController profileController = Get.find<ProfileController>();

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

    response.fold((l) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.context!);
      isLogin = false;
    }, (r) {
      tokenService.saveTokenModelToHiveBox(TokenModel(
        aToken: r.accessToken!,
        rToken: r.refreshToken!,
        dToken: DateTime.now().toIso8601String(),
      ));
      profileController.saveProfileToHiveBox(r.userProfile!);
      isLogin = true;
    });

    isLoading = false;
    update();
    return isLogin;
  }

  setShowPass() {
    showPass = !showPass;
  }
}
