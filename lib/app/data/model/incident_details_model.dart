import 'package:sfl/app/data/model/category_model.dart';
import 'package:sfl/app/data/model/incident_history_model.dart';
import 'package:sfl/app/data/model/priority_level_model.dart';
import 'package:sfl/app/data/model/sub_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount_unit_model.dart';
import 'baladia_model.dart';
import 'department_model.dart';
import 'data_status_model.dart';
import 'image_model.dart';
import 'user_model.dart';
import 'mobdra_model.dart';

part 'incident_details_model.freezed.dart';
part 'incident_details_model.g.dart';

@unfreezed
class IncidentDetailsModel with _$IncidentDetailsModel {
  factory IncidentDetailsModel({
    required String id,
    required String? lat,
    required String? long,
    required String? notes,
    required String? createDate,
    required String? createHijriDate,
    required String? createTime,
    required String? incidentStatusColor,
    required String? districtName,
    required String? streetName,
    required String? address,
    required bool? isNew,
    required String? userFullName,
    required int? imagesCount,
    required String? assignedUserId,
    required String? baladiaID,
    required int? departmentID,
    required int? neighborhoodID,
    required int? roadID,
    required String? updateDate,
    required String? updatedByUserId,
    required String? assigningDate,
    required String? assigningNote,
    required String? updateStatusDate,
    required String? statusNote,
    required String? statusUpdateUserId,
    required String? mobadraID,
    required double? unitValue,
    required String? statusLong,
    required String? statusLat,
    required String? statusLocation,
    required MobdraModel? mobadra,
    required DataStatusModel? status,
    required String? road,
    required String? neighborhood,
    required DepartmentModel? department,
    required BaladiaModel? baladia,
    required PriorityLevelModel? priorityLevel,
    required CategoryModel? category,
    required SubCategoryModel? subCategory,
    required AmountUnitModel? amountUnit,
    required List<ImageModel> images,
    required List<IncidentHistoryModel>? incidentHistory,
    required UserModel? statusUpdateUser,
    required UserModel? assignedUser,
    required UserModel? createdUser,
    required UserModel? updatedByUser,
  }) = _IncidentDetailsModel;

  factory IncidentDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentDetailsModelFromJson(json);
}
