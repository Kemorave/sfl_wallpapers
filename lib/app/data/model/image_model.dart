import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@unfreezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    int? id,
    String? name,
    String? path,
    bool? isPrimary,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}
