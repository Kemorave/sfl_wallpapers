import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_responce.freezed.dart';
part 'server_responce.g.dart';

@unfreezed
class ServerResponce with _$ServerResponce {
  factory ServerResponce(
    bool? success,
    String? message,
    dynamic data,
  ) = _ServerResponce;

  factory ServerResponce.fromJson(Map<String, dynamic>? json) =>
      _$ServerResponceFromJson(json ?? {});
}
