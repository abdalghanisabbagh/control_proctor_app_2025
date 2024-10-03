import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../resource_manager/ReusableWidget/loading_indicators.dart';
import '../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../resource_manager/constants/app_constants.dart';
import '../resource_manager/validations.dart';
import '../routes_manger.dart';

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
      Get.toNamed(Routes.nextExams);
    }
  }
}

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
                        'assets/logos/barcode.png',
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
                      const SizedBox(
                        width: 30,
                        child: Divider(
                          color: ColorManager.bgSideMenu,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      MyTextFormFiled(
                        autofillHints: const [
                          AutofillHints.username,
                        ],
                        controller: emailController,
                        myValidation: Validations.requiredValidator,
                        title: "User Name",
                      ),
                      GetBuilder<LoginController>(
                        id: 'pass_icon',
                        builder: (_) {
                          return MyTextFormFiled(
                            autofillHints: const [
                              AutofillHints.password,
                            ],
                            obscureText: controller.showPass,
                            controller: passwordController,
                            myValidation: Validations.requiredValidator,
                            enableBorderColor: ColorManager.grey,
                            title: "Password",
                            suffixIcon: GetBuilder<LoginController>(
                              builder: (_) {
                                return IntrinsicHeight(
                                  child: IntrinsicWidth(
                                    child: IconButton(
                                      icon: AnimatedSwitcher(
                                        duration: AppConstants.mediumDuration,
                                        transitionBuilder: (child, animation) {
                                          final rotateAnimation = Tween<double>(
                                                  begin: 0.0, end: 1.0)
                                              .animate(animation);
                                          final reverseAnimation =
                                              Tween<double>(
                                                      begin: 1.0, end: 0.0)
                                                  .animate(animation);
                                          return RotationTransition(
                                            turns: controller.showPass
                                                ? rotateAnimation
                                                : reverseAnimation,
                                            child: FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                          );
                                        },
                                        layoutBuilder:
                                            (currentChild, previousChildren) {
                                          return Stack(
                                            fit: StackFit.loose,
                                            children: [
                                              // Show the current child.
                                              if (currentChild != null)
                                                Positioned.fill(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: currentChild,
                                                  ),
                                                ),
                                              // Show the previous children in a stack.
                                              ...previousChildren.map(
                                                (child) {
                                                  return Positioned.fill(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: IgnorePointer(
                                                        child: child,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                        switchInCurve: Curves.easeOutExpo,
                                        switchOutCurve: Curves.easeInExpo,
                                        child: controller.showPass
                                            ? const Icon(
                                                key: ValueKey(1),
                                                Icons.visibility,
                                                color: ColorManager.glodenColor,
                                              )
                                            : const Icon(
                                                key: ValueKey(2),
                                                Icons.visibility_off,
                                                color: ColorManager.glodenColor,
                                              ),
                                      ),
                                      onPressed: () {
                                        controller.setShowPass();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      GetBuilder<LoginController>(
                        builder: (_) {
                          if (controller.isLoading) {
                            return SizedBox(
                              width: 50,
                              height: 50,
                              child: FittedBox(
                                child: LoadingIndicators.getLoadingIndicator(),
                              ),
                            );
                          } else {
                            return SizedBox(
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
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<LoginController>(
                        builder: (_) {
                          return Text(
                            controller.packageInfo?.version ??
                                'getting version...',
                            style: nunitoBlack.copyWith(
                              fontSize: 16,
                              color: ColorManager.grey,
                            ),
                          );
                        },
                      ),
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
