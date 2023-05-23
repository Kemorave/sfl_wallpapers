class IncidentCategoryInfoModel {
  bool? success;
  Data? data;
  String? message;

  IncidentCategoryInfoModel({this.success, this.data, this.message});

  IncidentCategoryInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<IncidentList>? incidentList;

  Data({this.incidentList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['incidentList'] != null) {
      incidentList = <IncidentList>[];
      json['incidentList'].forEach((v) {
        incidentList!.add(IncidentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (incidentList != null) {
      data['incidentList'] = incidentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IncidentList {
  String? incidentSubCategoryArabicName;
  int? allCompletedIncidentsCount;
  int? remainIncidentsCount;
  int? totalIncidentsCount;

  IncidentList(
      {this.incidentSubCategoryArabicName,
      this.allCompletedIncidentsCount,
      this.remainIncidentsCount,
      this.totalIncidentsCount});

  IncidentList.fromJson(Map<String, dynamic> json) {
    incidentSubCategoryArabicName = json['incidentSubCategoryArabicName'];
    allCompletedIncidentsCount = json['allCompletedIncidentsCount'];
    remainIncidentsCount = json['remainIncidentsCount'];
    totalIncidentsCount = json['totalIncidentsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['incidentSubCategoryArabicName'] = incidentSubCategoryArabicName;
    data['allCompletedIncidentsCount'] = allCompletedIncidentsCount;
    data['remainIncidentsCount'] = remainIncidentsCount;
    data['totalIncidentsCount'] = totalIncidentsCount;
    return data;
  }
}
