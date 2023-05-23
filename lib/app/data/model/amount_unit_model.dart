import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount_unit_model.freezed.dart';
part 'amount_unit_model.g.dart';

@unfreezed
class AmountUnitModel with _$AmountUnitModel {
  factory AmountUnitModel({
    required int? id,
    required int? incidentsCount,
    required int? subCategoryCount,
    required String? arabicName,
    required String? englishName,
  }) = _AmountUnitModel;

  factory AmountUnitModel.fromJson(Map<String, dynamic> json) =>
      _$AmountUnitModelFromJson(json);
}
