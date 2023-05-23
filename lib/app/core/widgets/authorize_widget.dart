import 'package:sfl/locator.dart';
import 'package:flutter/widgets.dart';

import '../enums/user_permission_enum.dart';

class AuthorizeWidget extends StatelessWidget {
  const AuthorizeWidget(
      {super.key,
      required this.child,
      this.fallback,
      required this.requiredPermission});
  final UserPermissionEnum requiredPermission;
  final Widget? fallback;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final result = userService().checkPermission(requiredPermission);
    if (!result && fallback != null) {
      return fallback!;
    }
    return Visibility(
      visible: result,
      child: child,
    );
  }
}
