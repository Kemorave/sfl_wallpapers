import 'package:sfl/locator.dart';
import 'package:get/get.dart';

import '../../data/unit_of_work.dart';

mixin ApiCallMixin {
  final api = locate<UnitOfWork>();
}
mixin DisposableApiCallMixin on GetLifeCycleBase {
  final api = locate<UnitOfWork>();
  @override
  void onClose() {
    super.onClose();
    api.dispose();
  }
}
