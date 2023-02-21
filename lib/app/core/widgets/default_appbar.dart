
import 'package:flutter/material.dart';
import 'package:sfl/app/core/widgets/transparent_clip.dart';

class DefaultAppbar extends PreferredSize {
  DefaultAppbar(AppBar par, {Key? key})
      : super(
          key: key,
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: TransparentClip(par),
        );
}
