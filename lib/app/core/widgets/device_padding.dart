import 'package:sfl/app/core/utils/device_util.dart';
import 'package:flutter/material.dart';

class DevicePadding extends StatelessWidget {
  const DevicePadding(
      {super.key,
      required this.child,
      required this.mobilePadding,
      required this.tabletPadding});
  final EdgeInsets mobilePadding;
  final EdgeInsets tabletPadding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DeviceUtils.getDeviceType() == DeviceType.tablet
          ? tabletPadding
          : mobilePadding,
      child: child,
    );
  }
}
