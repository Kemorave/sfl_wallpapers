class IncidentsFetchOptions {
  int? pageSize;
  int? currentPage;
  int? categoryId;
  int? subCategoryId;
  String? createdUserId;
  Distance? distance;
  IcidentFilterModel? icidentFilterModel;

  IncidentsFetchOptions(
      {this.pageSize = 100,
      this.currentPage = 1,
      this.categoryId = 0,
      this.subCategoryId = 0,
      this.createdUserId = 'string',
      this.distance,
      this.icidentFilterModel}) {
    distance ??= Distance(distanceInMeter: 0, lat: 0, long: 0);
    icidentFilterModel ??= IcidentFilterModel(baladiaDepartmentIdsList: []);
  }

  IncidentsFetchOptions.fromJson(Map<String, dynamic> json) {
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    createdUserId = json['createdUserId'];
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    icidentFilterModel = json['icidentFilterModel'] != null
        ? IcidentFilterModel.fromJson(json['icidentFilterModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageSize'] = pageSize;
    data['currentPage'] = currentPage;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['createdUserId'] = createdUserId;
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (icidentFilterModel != null) {
      data['icidentFilterModel'] = icidentFilterModel!.toJson();
    }
    return data;
  }
}

class Distance {
  double? lat;
  double? long;
  double? distanceInMeter;

  Distance({this.lat, this.long, this.distanceInMeter});

  Distance.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    distanceInMeter = json['distanceInMeter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    data['distanceInMeter'] = distanceInMeter;
    return data;
  }
}

class IcidentFilterModel {
  String? createDateFrom;
  String? createDateTo;
  String? address;
  String? lat;
  String? lng;
  int? distanceInMeter;
  int? amountUnitId;
  bool? isPriority;
  int? unitValue;
  List<int>? categoryIds;
  List<int>? subCategoryIds;
  List<int>? incidentStatusIds;
  String? statusNote;
  List<String>? statusUpdateUserId;
  List<String>? assignedUserIds;
  String? assigningDateFrom;
  String? assigningDateTo;
  String? assigningNote;
  List<String>? createdUserIds;
  String? updateDateFrom;
  String? updateDateTo;
  List<String>? updatedByUserIds;
  List<String>? baladiaIDs;
  List<int>? departmentIDs;
  List<int>? neighborhoodIDs;
  List<int>? roadIDs;
  List<String>? mobadraIDs;
  List<int>? priorityLevelIDs;
  List<BaladiaDepartmentIdsList>? baladiaDepartmentIdsList;

  IcidentFilterModel(
      {this.createDateFrom,
      this.createDateTo,
      this.address,
      this.lat,
      this.lng,
      this.distanceInMeter,
      this.amountUnitId,
      this.isPriority,
      this.unitValue,
      this.categoryIds,
      this.subCategoryIds,
      this.incidentStatusIds,
      this.statusNote,
      this.statusUpdateUserId,
      this.assignedUserIds,
      this.assigningDateFrom,
      this.assigningDateTo,
      this.assigningNote,
      this.createdUserIds,
      this.updateDateFrom,
      this.updateDateTo,
      this.updatedByUserIds,
      this.baladiaIDs,
      this.departmentIDs,
      this.neighborhoodIDs,
      this.roadIDs,
      this.mobadraIDs,
      this.priorityLevelIDs,
      this.baladiaDepartmentIdsList});

  IcidentFilterModel.fromJson(Map<String, dynamic> json) {
    createDateFrom = json['createDateFrom'];
    createDateTo = json['createDateTo'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    distanceInMeter = json['distanceInMeter'];
    amountUnitId = json['amountUnitId'];
    isPriority = json['isPriority'];
    unitValue = json['unitValue'];
    categoryIds = json['categoryIds'].cast<int>();
    subCategoryIds = json['subCategoryIds'].cast<int>();
    incidentStatusIds = json['incidentStatusIds'].cast<int>();
    statusNote = json['statusNote'];
    statusUpdateUserId = json['statusUpdateUserId'].cast<String>();
    assignedUserIds = json['assignedUserIds'].cast<String>();
    assigningDateFrom = json['assigningDateFrom'];
    assigningDateTo = json['assigningDateTo'];
    assigningNote = json['assigningNote'];
    createdUserIds = json['createdUserIds'].cast<String>();
    updateDateFrom = json['updateDateFrom'];
    updateDateTo = json['updateDateTo'];
    updatedByUserIds = json['updatedByUserIds'].cast<String>();
    baladiaIDs = json['baladiaIDs'].cast<String>();
    departmentIDs = json['departmentIDs'].cast<int>();
    neighborhoodIDs = json['neighborhoodIDs'].cast<int>();
    roadIDs = json['roadIDs'].cast<int>();
    mobadraIDs = json['mobadraIDs'].cast<String>();
    priorityLevelIDs = json['priorityLevelIDs'].cast<int>();
    if (json['baladiaDepartmentIdsList'] != null) {
      baladiaDepartmentIdsList = <BaladiaDepartmentIdsList>[];
      json['baladiaDepartmentIdsList'].forEach((v) {
        baladiaDepartmentIdsList!.add(BaladiaDepartmentIdsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (baladiaDepartmentIdsList != null) {
      data['baladiaDepartmentIdsList'] =
          baladiaDepartmentIdsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BaladiaDepartmentIdsList {
  String? baladiaId;
  List<int>? departmentIds;

  BaladiaDepartmentIdsList({this.baladiaId, this.departmentIds});

  BaladiaDepartmentIdsList.fromJson(Map<String, dynamic> json) {
    baladiaId = json['baladiaId'];
    departmentIds = json['departmentIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baladiaId'] = baladiaId;
    data['departmentIds'] = departmentIds;
    return data;
  }
}
