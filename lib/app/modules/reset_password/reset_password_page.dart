// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:sfl/app/core/widgets/default_appbar.dart';

import 'reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.viewIndex.value = 0;
    return Scaffold(
      appBar: DefaultAppbar(
        AppBar(
          title: const Text('Reset Password '),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                return IndexedStack(
                  alignment: Alignment.center,
                  index: controller.viewIndex.value,
                  children: [
                    SendEmailStep(),
                    CodeVerifyStep(),
                    InputPasswordStep()
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class SendEmailStep extends GetView<ResetPasswordController> {
  SendEmailStep({Key? key}) : super(key: key);
  final reEmailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Aw man you forgot yours too ?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        LottieBuilder.asset(
          "assets/morty_cry.json",
          height: 250,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 20),
          child: Text(
            "I feel ya man why do we always have to remember those things man ? why cant we just get in its me right ? ugh",
            overflow: TextOverflow.clip,
          ),
        ),
        Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(() {
              return TextFormField(
                  autofocus: false,
                  controller: reEmailTextEditingController,
                  textInputAction: TextInputAction.next,
                  readOnly: controller.isBusy.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                      ),
                      border: InputBorder.none,
                      hintText: 'Email'));
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Obx(() {
            return controller.isBusy.value
                ? const CircularProgressIndicator()
                : GFButton(
                    size: 50,
                    enableFeedback: controller.isBusy.isFalse,
                    text: "Send rest email",
                    shape: GFButtonShape.pills,
                    onPressed: () async {
                      if (reEmailTextEditingController.text.isEmpty ||
                          !reEmailTextEditingController.text.contains("@")) {
                        GFToast.showToast("Invalid email no can do", context);
                      } else {
                        var ss = await controller.sendResetMessage(
                            reEmailTextEditingController.text);
                        if (ss.result == false) {
                          GFToast.showToast(
                              ss.failur?.errorMessage ?? "Error", context);
                        }
                      }
                    });
          }),
        )
      ],
    );
  }
}

class CodeVerifyStep extends GetView<ResetPasswordController> {
  CodeVerifyStep({Key? key}) : super(key: key);
  final confirmTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Verify code has been sent to email check your inbox",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.email,
            size: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                textAlign: TextAlign.center,
                readOnly: controller.isBusy.value,
                controller: confirmTextEditingController,
                decoration: const InputDecoration(hintText: "Code"),
                maxLength: 10,
                keyboardType: TextInputType.number,
                maxLines: 1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Obx(() {
            return controller.isBusy.value
                ? const CircularProgressIndicator()
                : GFButton(
                    size: 50,
                    shape: GFButtonShape.pills,
                    onPressed: () async {
                      if (confirmTextEditingController.text.isEmpty) {
                        GFToast.showToast("Code empty", context);
                        return;
                      }
                      var ss = await controller.verifyPasswordResetCode(
                          confirmTextEditingController.text);
                      if (ss.result == false) {
                        GFToast.showToast(ss.failur?.errorMessage, context);
                      }
                    },
                    text: "Confirm",
                  );
          }),
        )
      ],
    );
  }
}

class InputPasswordStep extends GetView<ResetPasswordController> {
  InputPasswordStep({Key? key}) : super(key: key);
  final confirmPasswordTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Column(
      children: [
        const Text(
          "Please write a password that is easy to remember next time",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.password_rounded,
            size: 100,
          ),
        ),
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.zero,
            child: Obx(() {
              return Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    TextFormField(
                        readOnly: controller.isBusy.value,
                        controller: passwordTextEditingController,
                        validator: (a) {
                          return (a?.isEmpty == true ||
                                  a == null ||
                                  a.length >= 6)
                              ? null
                              : "Too short, must be over 6 characters";
                        },
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            ),
                            hintText: 'New password')),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      indent: 00,
                      endIndent: 0,
                      color: Colors.black12,
                    ),
                    TextFormField(
                        readOnly: controller.isBusy.value,
                        controller: confirmPasswordTextEditingController,
                        validator: (a) {
                          return a != passwordTextEditingController.text
                              ? "Password not match"
                              : null;
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                  onTap: () {
                                    controller.hidePass.toggle();
                                  },
                                  child: Icon(
                                    controller.hidePass.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: 24,
                                  )),
                            ),
                            hintText: 'Renter password')),
                  ]),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Obx(() {
            return controller.isBusy.value
                ? const CircularProgressIndicator()
                : GFButton(
                    size: 50,
                    shape: GFButtonShape.pills,
                    onPressed: () async {
                      _formKey.currentState?.validate();
                      if (passwordTextEditingController.text.isEmpty ||
                          passwordTextEditingController.text.length < 6) {
                        GFToast.showToast("Invalid password", context);
                        return;
                      }
                      if (passwordTextEditingController.text !=
                          confirmPasswordTextEditingController.text) {
                        GFToast.showToast("Passwords not match", context);
                        return;
                      }
                      var res = await controller
                          .resetPassword(passwordTextEditingController.text);
                      if (res.result == false) {
                        GFToast.showToast(res.failur?.errorMessage, context);
                      }
                    },
                    text: "Change password",
                  );
          }),
        )
      ],
    );
  }
}
