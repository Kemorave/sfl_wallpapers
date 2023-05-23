import 'package:sfl/app/core/base_controller.dart';
import 'package:sfl/app/core/state_enum.dart';
import 'package:sfl/app/core/widgets/state/error_state_widget.dart';
import 'package:flutter/material.dart';

class ControllerStateWidget extends StatelessWidget {
  const ControllerStateWidget(
      {Key? key,
      required this.controller,
      required this.child,
      this.loadingWidget})
      : super(key: key);
  final BaseController controller;
  final Widget? loadingWidget;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (controller.isBusy.value && loadingWidget != null) return loadingWidget!;
    switch (controller.state.value) {
      case StateEnum.error:
        return ErrorStateWidget(
          failur: controller.error.value,
        );
      default:
        break;
    }
    return child;
  }
}
