import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_dto.freezed.dart';
part 'refresh_token_dto.g.dart';

@unfreezed
class RefreshTokenDTO with _$RefreshTokenDTO {
  factory RefreshTokenDTO({
    required String accessToken,
    required String refreshToken,
  }) = _RefreshTokenDTO;

  factory RefreshTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDTOFromJson(json);
}
