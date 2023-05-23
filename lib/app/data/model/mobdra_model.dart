import 'package:sfl/app/data/model/incident_model.dart';
import 'package:sfl/app/data/model/sub_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'baladia_model.dart';

part 'mobdra_model.freezed.dart';
part 'mobdra_model.g.dart';

@freezed
class MobdraModel with _$MobdraModel {
  factory MobdraModel({
    String? id,
    String? arabicName,
    String? englishName,
    DateTime? startDate,
    DateTime? endDate,
    List<BaladiaModel>? mobadraBaladias,
    List<SubCategoryModel>? mobadraIncidentSubCategories,
    List<IncidentModel>? incidents,
    String? scope,
  }) = _MobdraModel;

  factory MobdraModel.fromJson(Map<String, dynamic> json) =>
      _$MobdraModelFromJson(json);
}
