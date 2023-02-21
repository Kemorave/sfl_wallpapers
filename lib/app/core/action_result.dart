
import 'failur.dart';

class ActionResult<Result> {
  final Failur? failur;
  final Result? result;

  ActionResult([this.failur, this.result]);
}
