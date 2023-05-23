import 'package:sfl/app/core/failur.dart';
import 'package:get/get.dart';

class ActionResult<T > {
  final Failur? error;
  final T? result;
  final Response? responce;
  bool get hasError => error != null;
  static ActionResult<A> empty<A >() => ActionResult<A>();
  static Future<ActionResult<X>> runAsync<X >(
      Future<X> Function() fun) async {
    try {
      return ActionResult(result: await fun());
    } catch (e) {
      return ActionResult<X>(error: Failur(error: e));
    }
  }

  static ActionResult<X> run<X >(X Function() fun) {
    try {
      return ActionResult(result: fun());
    } catch (e) {
      return ActionResult<X>(error: Failur(error: e));
    }
  }

  ActionResult({this.error, this.result, this.responce});
}
