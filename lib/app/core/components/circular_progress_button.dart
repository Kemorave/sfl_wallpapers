import 'package:sfl/app/core/theme/app_theme_data.dart';
import 'package:sfl/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class CircularProgressButton {
  static ProgressButton icon({
    IconedButton? idle,
    required bool isBusy,
    String? successMessage,
    String? loadingMessage,
    String? idleMessage,
    String? failMessage,
    bool? hasError,
    bool? successfull,
    IconedButton? loading,
    IconedButton? fail,
    IconedButton? success,
    Map<ButtonState, IconedButton>? iconedButtons,
    Function? onPressed,
    ButtonState? state,
    Function? animationEnd,
    maxWidth = 400.0,
    minWidth = 58.0,
    height,
    radius = 10.0,
    progressIndicatorSize = 35.0,
    double iconPadding = 4.0,
    TextStyle? textStyle,
    CircularProgressIndicator? progressIndicator,
    MainAxisAlignment? progressIndicatorAlignment,
    EdgeInsets padding = EdgeInsets.zero,
    List<ButtonState> minWidthStates = const <ButtonState>[ButtonState.loading],
  }) {
    return ProgressButton.icon(
      iconedButtons: iconedButtons ??
          {
            ButtonState.idle: idle ??
                IconedButton(
                    icon: const Icon(Icons.check, color: Colors.white),
                    text: idleMessage ?? language().strings.ok,
                    color: CustomColor.darkGreenColor),
            ButtonState.loading: loading ??
                IconedButton(
                    text: loadingMessage ?? language().strings.loading,
                    color: Get.theme.primaryColor),
            ButtonState.fail: fail ??
                IconedButton(
                    text: failMessage ?? language().strings.error,
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    color: Colors.red.shade300),
            ButtonState.success: success ??
                IconedButton(
                    text: successMessage ??
                        language()
                            .strings
                            .successMessageTitle, //controller.message.value,
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
          },
      minWidth: minWidth,
      animationEnd: animationEnd,
      onPressed: onPressed,
      height: height ?? 45.0.sp,
      iconPadding: iconPadding,
      maxWidth: maxWidth,
      minWidthStates: minWidthStates,
      padding: padding,
      progressIndicator: progressIndicator,
      progressIndicatorAlignment: progressIndicatorAlignment,
      progressIndicatorSize: progressIndicatorSize,
      radius: radius,
      textStyle: textStyle ??
          Theme.of(Get.context!)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white, fontSize: 14.sp),
      state: state ??
          (isBusy
              ? ButtonState.loading
              : hasError == true
                  ? ButtonState.fail
                  : successfull == true
                      ? ButtonState.success
                      : ButtonState.idle),
    );
  }
}
