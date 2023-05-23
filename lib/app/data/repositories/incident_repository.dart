import 'package:cached_annotation/cached_annotation.dart';
import 'package:sfl/app/core/extentions/responce_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/action_result.dart';
import '../cache/cache_helper.dart';
import '../dto/incidents_fetch_options_dto.dart';
import '../model/incident_category_info_model.dart';
import '../model/incident_details_model.dart';
import '../model/incident_model.dart';
import '../model/priority_level_model.dart';
import '../model/report_data_model_model.dart';
import '../network/server_responce.dart';
import 'api_http_client.dart';
import 'base/i_disposible_repository.dart';
import 'base/i_http_client.dart';

part 'incident_repository.cached.dart';

@WithCache()
abstract class IncidentRepository implements IDisposibleRepository {
  factory IncidentRepository() = _IncidentRepository;
  @override
  late IHttpClient client = ApiHttpClient();

  @override
  void dispose() {
    client.dispose();
  }

  Future<ActionResult> createIncident(Map<String, dynamic> json) async {
    var mp = FormData(json);
    var res = await client.post("Incidents/", mp);

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: ServerResponce.fromJson(res.body));
  }

  Future<ActionResult> resolveIncidentInitialy(
      Map<String, dynamic> json) async {
    var mp = FormData(json);
    var res = await client.post("Incidents/DoneInitially", mp);

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: ServerResponce.fromJson(res.body));
  }

  @Cached(
    persistentStorage: true,
    syncWrite: true,
    ttl: 86400,
    where: asyncShouldCache,
  )
  Future<Map<String, dynamic>?> getPeriorityLevels() async {
    var res = await client.get("PriorityLevels");

    res.ensureSuccess();
    return res.body;
  }

  Future<ActionResult<List<IncidentModel>>> getIncidents(
      IncidentsFetchOptions options) async {
    var json = options.toJson();
    var res = await client.post(
        "Incidents/Get/?currentPage=${options.currentPage}", json);

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: await compute(
            deserializeModels,
            (ServerResponce.fromJson(res.body ?? {}).data as List<dynamic>?) ??
                []));
  }

  static List<PriorityLevelModel> deserializePriorityLevelModels(
      List<dynamic> list) {
    return list
        .map<PriorityLevelModel>((e) => PriorityLevelModel.fromJson(e))
        .toList();
  }

  static List<IncidentModel> deserializeModels(List<dynamic>? list) {
    if (list == null) {
      return [];
    }
    return list.map<IncidentModel>((e) => IncidentModel.fromJson(e)).toList();
  }

  Future<ActionResult<IncidentDetailsModel>> getIncidentDetails(
      String id) async {
    var res = await client.get("Incidents/GetDetails/$id");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: IncidentDetailsModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }

  Future<ActionResult<IncidentCategoryInfoModel>>
      getincidentsCategoriesInfo() async {
    var res = await client.get(
        "Report/GetTotalIncidentList?userId=undefined&mode=5&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res, result: IncidentCategoryInfoModel.fromJson((res.body)));
  }

  Future<ActionResult<ReportDataModelModel>> getNewIncidentsReport() async {
    var res = await client.get(
        "Report/GetNewIncidents?userId=undefined&mode=1&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: ReportDataModelModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }

  Future<ActionResult<ReportDataModelModel>>
      getCompletedIncidentsReport() async {
    var res = await client.get(
        "Report/GetCompletedIncidents?userId=undefined&mode=1&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: ReportDataModelModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }

  Future<ActionResult<ReportDataModelModel>>
      getUnconfirmedIncidentsReport() async {
    var res = await client.get(
        "Report/GetwaitingForSolvingConfirmationIncidents?userId=undefined&mode=1&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: ReportDataModelModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }

  Future<ActionResult<ReportDataModelModel>>
      getReopenedIncidentsReport() async {
    var res = await client.get(
        "Report/GetReopenedIncidents?userId=undefined&mode=1&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: ReportDataModelModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }

  Future<ActionResult<ReportDataModelModel>> getTotalIncidentsReport() async {
    var res = await client.get(
        "Report/GetTotalOfIncidents?userId=undefined&mode=1&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: ReportDataModelModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }

  Future<ActionResult<ReportDataModelModel>>
      getWithinPriorityRangeIncidentsReport() async {
    var res = await client.get(
        "Report/GetWithinPriorityRangeIncidents?userId=undefined&mode=1&baladiaId=undefined&departmentId=-1");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: ReportDataModelModel.fromJson(
            ServerResponce.fromJson(res.body).data));
  }
}
