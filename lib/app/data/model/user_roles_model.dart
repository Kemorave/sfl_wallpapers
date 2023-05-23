import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_roles_model.freezed.dart';
part 'user_roles_model.g.dart';

@unfreezed
class UserRolesModel with _$UserRolesModel {
  factory UserRolesModel(
      {required String roleID,
      required String? roleName,
      required List<String>? permissions}) = _UserRolesModel;

  factory UserRolesModel.fromJson(Map<String, dynamic> json) =>
      _$UserRolesModelFromJson(json);
}
