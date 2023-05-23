import 'package:freezed_annotation/freezed_annotation.dart';

part 'priority_level_model.freezed.dart';
part 'priority_level_model.g.dart';

@unfreezed
class PriorityLevelModel with _$PriorityLevelModel {
  factory PriorityLevelModel({
    required int id,
    required String arabicName,
    required String englishName,
    required String colorCode,
  }) = _PriorityLevelModel;

  factory PriorityLevelModel.fromJson(Map<String, dynamic> json) =>
      _$PriorityLevelModelFromJson(json);
}
