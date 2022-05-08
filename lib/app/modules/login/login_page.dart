// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:animator/animator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sfl/app/core/common_states.dart';
import 'package:sfl/app/core/theme/main_colors.dart';

import '../../core/widgets/default_appbar.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final myBS = BoxShadow(
      blurStyle: BlurStyle.outer,
      blurRadius: 3,
      color: Colors.black.withOpacity(0.7),
      spreadRadius: 4,
      offset: Offset(0, 0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SingleChildScrollView(
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 100,
                            child: Animator<double>(
                              cycles: 0,
                              duration: Duration(milliseconds: 1500),
                              curve: Curves.easeInOut,
                              tween: Tween<double>(begin: 0, end: 7),
                              builder: (bc, st, ch) => Column(
                                children: [
                                  SizedBox(
                                    height: st.value * 3,
                                  ),
                                  Container(
                                    child: ch,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: MainColors.mainColor
                                                  .withOpacity(0.3),
                                              blurRadius: 20,
                                              offset: Offset(0, 5))
                                        ]),
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.camera_rounded,
                                size: 75,
                                color: MainColors.mainColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hello",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        GFListTile(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          title: GFTypography(
                            text: "Welcome back",
                            type: GFTypographyType.typo1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                controller.errMessage.value,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Form(
                              autovalidateMode: AutovalidateMode.always,
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      readOnly: controller.isBusy.value,
                                      controller: emailEditingController,
                                      validator: (a) {
                                        return controller
                                                .emailErrMessage.value.isEmpty
                                            ? null
                                            : controller.emailErrMessage.value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.email,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Email')),
                                  const Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 00,
                                    endIndent: 0,
                                    color: Colors.black12,
                                  ),
                                  TextFormField(
                                      readOnly: controller.isBusy.value,
                                      controller: passwordEditingController,
                                      validator: (a) {
                                        return controller.passwordErrMessage
                                                .value.isEmpty
                                            ? null
                                            : controller
                                                .passwordErrMessage.value;
                                      },
                                      obscureText: controller.hidePass.value,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.lock,
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 4, 0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  controller.hidePass.toggle();
                                                },
                                                child: Icon(
                                                  controller.hidePass.value
                                                      ? Icons.visibility_rounded
                                                      : Icons
                                                          .visibility_off_rounded,
                                                  size: 24,
                                                )),
                                          ),
                                          hintText: 'Password')),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        GFButton(
                          text: "Forgot password ?",
                          onPressed: () => Get.toNamed("/reset-password"),
                          type: GFButtonType.transparent,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ProgressButton.icon(
                                      state: controller.state.value ==
                                              CommonStates.succes
                                          ? ButtonState.success
                                          : controller.isBusy.value
                                              ? ButtonState.loading
                                              : ButtonState.idle,
                                      iconedButtons: {
                                        ButtonState.idle: IconedButton(
                                            text: "Login",
                                            icon: Icon(Icons.login,
                                                color: Colors.white),
                                            color: MainColors.mainColor),
                                        ButtonState.loading: IconedButton(
                                            text: "Loading",
                                            color: MainColors.mainColor),
                                        ButtonState.fail: IconedButton(
                                            text: "Failed",
                                            icon: Icon(Icons.cancel,
                                                color: Colors.white),
                                            color: Colors.red.shade300),
                                        ButtonState.success: IconedButton(
                                            text: controller.message.value,
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                            color: Colors.green.shade400)
                                      },
                                      onPressed: () {
                                        if (controller.isBusy.value ||
                                            controller.state.value ==
                                                CommonStates.succes) {
                                          return;
                                        }
                                        if (!controller.triggerCheck(
                                            emailEditingController.text,
                                            passwordEditingController.text)) {
                                        } else {
                                          controller.signInWithEmail(
                                              emailEditingController.text,
                                              passwordEditingController.text);
                                        }
                                        _formKey.currentState?.validate();
                                      },
                                    ),
                                  ),
                                ),
                                GFButton(
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  text: "Register",
                                  shape: GFButtonShape.pills,
                                  size: 50,
                                  icon: Icon(
                                    Icons.person_add,
                                    color: MainColors.mainColor,
                                  ),
                                  onPressed: () => Get.toNamed("/register"),
                                  type: GFButtonType.outline,
                                )
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          height: 25,
                          thickness: 0,
                          indent: 0,
                          color: Colors.transparent,
                        ),
                        GFTypography(
                          text: "Or continue with social account",
                          showDivider: false,
                          type: GFTypographyType.typo6,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 0,
                          indent: 0,
                          color: Colors.transparent,
                        ),
                        Row(
                          children: [
                            GFButton(
                              boxShadow: myBS,
                              color: Color.fromARGB(255, 255, 255, 255),
                              onPressed: controller.signInWithFacebook,
                              textColor: Colors.black,
                              shape: GFButtonShape.pills,
                              text: "Facebook",
                              icon: Icon(
                                Icons.facebook,
                                color: Color.fromARGB(255, 7, 73, 255),
                              ),
                            ),
                            const Divider(
                              height: 20,
                              thickness: 0,
                              indent: 020,
                              color: Colors.transparent,
                            ),
                            GFButton(
                              boxShadow: myBS,
                              shape: GFButtonShape.pills,
                              color: Color.fromARGB(255, 255, 255, 255),
                              textColor: Colors.black,
                              onPressed: controller.signInWithGoogle,
                              text: "Google    ",
                              icon: Image.asset(
                                "assets/google.png",
                                height: 24,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  borderOnForeground: true,
                ),
              ),
            ),
          )),
    ));
  }
}
