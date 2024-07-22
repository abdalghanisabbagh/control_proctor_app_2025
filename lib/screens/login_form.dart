import 'package:control_proctor/screens/next_exams_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:control_proctor/controller/login_controller.dart';
import 'package:control_proctor/resource_manager/ReusableWidget/loading_indicators.dart';
import 'package:control_proctor/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_proctor/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_proctor/resource_manager/assets_manager.dart';
import 'package:control_proctor/resource_manager/color_manager.dart';
import 'package:control_proctor/resource_manager/validations.dart';

class LoginForm extends GetView<LoginController> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        onKeyEvent: (value) {
          if (value.logicalKey == LogicalKeyboardKey.enter) {
            _login(
              controller.login,
              emailController.text,
              passwordController.text,
              formKey,
              context,
            );
          }
        },
        focusNode: FocusNode()..requestFocus(),
        child: Center(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Control Proctor",
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        AssetsManager.assetsbarcodeLogo,
                        fit: BoxFit.fill,
                        height: 160,
                        width: 160,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 30,
                        child: Divider(
                          color: ColorManager.bgSideMenu,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      MytextFormFiled(
                        controller: emailController,
                        myValidation: Validations.requiredValidator,
                        title: "Email",
                        suffixIcon: Icon(
                          Icons.mail_outline,
                          color: ColorManager.glodenColor,
                        ),
                      ),
                      Obx(() {
                        return MytextFormFiled(
                          obscureText: controller.showPass.value,
                          controller: passwordController,
                          myValidation: Validations.requiredValidator,
                          enableBorderColor: ColorManager.grey,
                          title: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.showPass.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorManager.glodenColor,
                            ),
                            onPressed: () {
                              controller.setShowPass();
                            },
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 32,
                      ),
                      controller.isLoading
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: FittedBox(
                                child: LoadingIndicators.getLoadingIndicator(),
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _login(
                                    controller.login,
                                    emailController.text,
                                    passwordController.text,
                                    formKey,
                                    context,
                                  );
                                },
                                child: const Text("Login"),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _login(
    Future<bool> Function(String email, String password) login,
    String email,
    String password,
    GlobalKey<FormState> formKey,
    BuildContext context) async {
  if (formKey.currentState!.validate()) {
    final isSuccess = await login(email, password);
    if (isSuccess) {
      MyFlashBar.showSuccess(
        'You have been logged in successfully',
        'Success',
      ).show(Get.context!);
      Get.to(() => const NextExams());
    } else {
      MyFlashBar.showError(
        'Login failed. Please try again.',
        'Error',
      ).show(Get.context!);
    }
  }
}
