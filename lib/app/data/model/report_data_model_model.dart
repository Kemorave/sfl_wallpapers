import 'package:freezed_annotation/freezed_annotation.dart';

import 'incident_model.dart';

part 'report_data_model_model.freezed.dart';
part 'report_data_model_model.g.dart';

@freezed
class ReportDataModelModel with _$ReportDataModelModel {
  factory ReportDataModelModel({
    int? targetCount,
    int? allCount,
    int? allWithinPriorityRangeIncidentsCount,
    double? precentage,
    List<IncidentModel>? incidentList,
  }) = _ReportDataModelModel;

  factory ReportDataModelModel.fromJson(Map<String, dynamic> json) =>
      _$ReportDataModelModelFromJson(json);
}
