// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'incident_model.freezed.dart';
part 'incident_model.g.dart';

@unfreezed
class IncidentModel with _$IncidentModel {
  factory IncidentModel({
    @Default('') String id,
    DateTime? createDate,
    @Default('') String createHijriDate,
    @Default('') String createTime,
    String? incidentStatusArabicName,
    String? amountUnitName,
    String? incidentStatusEnglishName,
    String? incidentStatusColor,
    String? incidentUnitArabicName,
    String? incidentUnitEnglishName,
    double? unitValue,
    String? districtName,
    String? streetName,
    String? address,
    String? incidentCategoryArabicName,
    String? incidentCategoryEnglishName,
    String? incidentSubCategoryArabicName,
    String? incidentSubCategoryEnglishName,
    bool? isNew,
    String? userFullName,
    int? imagesCount,
    int? transactonCount,
    String? priorityTextArabic,
    String? priorityTextEnglish,
    int? incidentStatusId,
    int? categoryId,
    int? subCategoryId,
    int? amountUnitId,
    int? amountValue,
    String? lat,
    String? long,
    String? notes,
    @JsonKey(name: 'priorityLevelID') int? priority,
  }) = _IncidentModel;

  factory IncidentModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentModelFromJson(json);
}
