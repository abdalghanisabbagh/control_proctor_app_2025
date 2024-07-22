import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_proctor/controller/profile_controller.dart';
import 'package:get/get.dart' hide Response;

import '../configurations/app_links.dart';
import '../enums/req_type_enum.dart';
import '../models/login_response/login_res_model.dart';
import '../models/token_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/token_service.dart';
import '../tools/response_handler.dart';

class LoginController extends GetxController {
  RxBool showPass = true.obs;
  bool isLoading = false;

  TokenService tokenService = Get.find<TokenService>();

  ProfileController profileController = Get.find<ProfileController>();

  setShowPass() {
    showPass.value = !showPass.value;
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    bool isLogin = false;
    // update(['login_btn']);
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

  // Future<String?> refreshToken() async {
  //   if (tokenService.tokenModel == null) {
  //     return null;
  //   }
  //   String refresh = tokenService.tokenModel!.rToken;
  //   var dio = Dio(
  //     BaseOptions(
  //       baseUrl: AppLinks.baseUrl,
  //     ),
  //   );

  //   // DioException Error in the networklayer can not be resolved by the library
  //   var response = await dio
  //       .post(AuthLinks.refresh, data: {'refreshToken': refresh}).onError(
  //     (error, stackTrace) {
  //       ErrorHandler.handle(error);
  //       return Response(requestOptions: RequestOptions(path: 'error'));
  //     },
  //   );
  //   // if response is good we get new access token need to replace
  //   //  update refresh token in local storage and profile controller

  //   tokenService.saveNewAccessToken(response.data['data']);
  //   return response.data['data'];
  // }
}
