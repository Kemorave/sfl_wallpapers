import 'package:sfl/app/data/model/incident_model.dart';
import 'package:sfl/app/data/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'data_status_model.dart';
import 'image_model.dart';
import 'sub_category_model.dart';

part 'incident_history_model.freezed.dart';
part 'incident_history_model.g.dart';

@unfreezed
class IncidentHistoryModel with _$IncidentHistoryModel {
  factory IncidentHistoryModel({
    required String id,
    required String incidentId,
    required IncidentModel incident,
    required String historyCreationDate,
    required List<ImageModel>? historicalImages,
    String? notes,
    String? createDate,
    String? createHijriDate,
    String? createTime,
    String? districtName,
    String? streetName,
    String? address,
    String? lat,
    String? long,
    String? location,
    required double? unitValue,
    required int? amountUnitId,
    required String? amountUnit,
    required int categoryId,
    required String? category,
    required int? subCategoryId,
    required SubCategoryModel? subCategory,
    required int incidentStatusId,
    required DataStatusModel? status,
    required String? updateStatusDate,
    required String? statusNote,
    required String? statusUpdateUserId,
    required String? statusUpdateUser,
    required String? statusLat,
    required String? statusLong,
    required String? statusLocation,
    required String? assignedUserId,
    required String? assigningDate,
    required String? assigningNote,
    required UserModel? assignedUser,
    required String? createdUserId,
    required String? createdUser,
    required String? updateDate,
    required String? updatedByUserId,
    required String? updatedByUser,
    required String? baladiaID,
    required String? baladia,
    required int? departmentID,
    required String? department,
    required String? neighborhoodID,
    required String? neighborhood,
    required String? roadID,
    required String? road,
    required String? mobadraID,
    required String? mobadra,
    required int? priorityLevelID,
    required dynamic priorityLevel,
    required int? refId,
  }) = _IncidentHistoryModel;

  factory IncidentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentHistoryModelFromJson(json);
}
