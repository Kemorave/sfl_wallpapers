import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_status_model.freezed.dart';
part 'data_status_model.g.dart';

@unfreezed
class DataStatusModel with _$DataStatusModel {
  factory DataStatusModel(
      {required int id,
      required String? arabicName,
      required String? englishName,
      required String? color,
      required int? incidentsCount}) = _DataStatusModel;

  factory DataStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DataStatusModelFromJson(json);
}
