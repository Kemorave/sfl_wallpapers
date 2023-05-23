// ignore_for_file: invalid_annotation_target

import '../model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_responce_dto.freezed.dart';
part 'login_responce_dto.g.dart';

@unfreezed
class LoginResponceDTO with _$LoginResponceDTO {
  factory LoginResponceDTO({
    bool? success,
    String? message,
    UserModel? user,
    @JsonKey(name: 'access_token') String? accessToken,
    String? refreshToken,
  }) = _LoginResponceDTO;

  factory LoginResponceDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponceDTOFromJson(json);
}
