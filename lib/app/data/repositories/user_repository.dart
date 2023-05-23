import 'package:sfl/app/core/action_result.dart';
import 'package:sfl/app/core/extentions/responce_extension.dart';
import 'package:sfl/app/data/model/user_model.dart';
import 'package:sfl/app/data/network/server_responce.dart';

import '../dto/login_responce_dto.dart';
import 'base/i_disposible_repository.dart';

class UserRepository extends IDisposibleRepository {
  UserRepository();

  Future<ActionResult<LoginResponceDTO>> login(
      String email, String password, String? deviceToken) async {
    var res = await client.post("Account/login",
        {'userName': email, 'password': password, 'deviceToken': deviceToken});

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: LoginResponceDTO.fromJson(res.body));
  }

  Future<ActionResult<bool>> logout(String? deviceToken) async {
    var res = await client.post("Account/logout", {'deviceToken': deviceToken});
    res.ensureSuccess();
    return ActionResult(responce: res, result: res.isOk);
  }

  Future<ActionResult<ServerResponce>> sendForgotPasswordMessage(
      String email) async {
    var res = await client.post("Account/Forgot", {
      'email': email,
    });

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: ServerResponce.fromJson(res.body));
  }

  Future<ActionResult<ServerResponce>> verifyForgotPasswordCode(
      String email, String code) async {
    var res = await client.post("Account/Verify", {
      'email': email,
      'code': code,
    });

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: ServerResponce.fromJson(res.body));
  }

  Future<ActionResult<ServerResponce>> resetPassword(
      String email, String code, String newPassword) async {
    var res = await client.post("Account/Reset", {
      'email': email,
      'code': code,
      'password': newPassword,
    });

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: ServerResponce.fromJson(res.body));
  }

  Future<ActionResult> updateProfile(UserModel user) async {
    final json = user.toJson();
    var res = await client.post("Account/Info", json);

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: LoginResponceDTO.fromJson(res.body));
  }

  Future<ActionResult<UserModel>> getProfile() async {
    var res = await client.get("Account/Info");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: UserModel.fromJson(ServerResponce.fromJson(res.body).data));
  }
}
