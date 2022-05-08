import 'dart:ui';

import 'package:flutter/widgets.dart';

class TransparentClip extends ClipRRect {
  TransparentClip(Widget child,
      {Key? key,
      BorderRadius? borderRadius =
          const BorderRadius.vertical(bottom: Radius.circular(20))})
      : super(
            key: key,
            borderRadius: borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: child,
            ));
}
