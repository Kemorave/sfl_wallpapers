import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sfl/app/core/theme/main_colors.dart';
import 'package:sfl/app/core/widgets/default_appbar.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        AppBar(
          title: const Text('Resgistration'),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Joining us is simple",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.person_add,
                      size: 100,
                      color: MainColors.mainColor,
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Obx(() {
                        return Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              TextFormField(
                                  textInputAction: TextInputAction.next,
                                  readOnly: controller.isBusy.value,
                                  controller: emailTextEditingController,
                                  validator: (a) {
                                    return (a?.isEmpty == true ||
                                            a?.contains("@") == true)
                                        ? null
                                        : "Email invalid";
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
                                  textInputAction: TextInputAction.next,
                                  obscureText: controller.hidePass.value,
                                  controller: passwordTextEditingController,
                                  readOnly: controller.isBusy.value,
                                  validator: (a) {
                                    return (a?.isEmpty == true ||
                                            a == null ||
                                            a.length >= 6)
                                        ? null
                                        : "Too short, must be over 6 characters";
                                  },
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.lock,
                                      ),
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
                                      border: InputBorder.none,
                                      hintText: 'Password')),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                indent: 00,
                                endIndent: 0,
                                color: Colors.black12,
                              ),
                              TextFormField(
                                  controller:
                                      confirmPasswordTextEditingController,
                                  readOnly: controller.isBusy.value,
                                  validator: (a) {
                                    return a !=
                                            passwordTextEditingController.text
                                        ? "Password not match"
                                        : null;
                                  },
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.lock,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Renter password')),
                            ]),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Obx(() {
                      return controller.isBusy.value
                          ? const CircularProgressIndicator()
                          : GFButton(
                              size: 50,
                              shape: GFButtonShape.pills,
                              onPressed: () async {
                                if (emailTextEditingController.text.isEmpty ||
                                    !emailTextEditingController.text
                                        .contains("@")) {
                                  GFToast.showToast("Invalid email", context);
                                  return;
                                }
                                if (passwordTextEditingController
                                        .text.isEmpty ||
                                    passwordTextEditingController.text.length <
                                        6) {
                                  GFToast.showToast(
                                      "Invalid password", context);
                                  return;
                                }
                                if (passwordTextEditingController.text !=
                                    confirmPasswordTextEditingController.text) {
                                  GFToast.showToast(
                                      "Passwords not match", context);
                                  return;
                                }
                                var res = await controller.register(
                                    emailTextEditingController.text,
                                    passwordTextEditingController.text);
                                if (res.result == null) {
                                  GFToast.showToast(
                                      res.failur?.message, context);
                                }
                              },
                              text: "Register",
                            );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
