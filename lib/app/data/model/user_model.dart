// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'baladia_model.dart';
import 'user_roles_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@unfreezed
class UserModel with _$UserModel {
  factory UserModel(
      {String? id,
      String? fullName,
      String? userName,
      String? email,
      String? mobile,
      String? phoneNumber,
      List<String>? roles,
      List<UserRolesModel>? userRoles,
      List<String>? department,
      @JsonKey(name: 'baladias') List<BaladiaModel>? municipalities,
      String? firstName,
      String? lastName,
      String? officeId,
      String? job,
      String? idNumber}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
