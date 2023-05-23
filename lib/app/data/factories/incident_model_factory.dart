import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/incident_model.dart';

class IncidentModelFactory {
  IncidentModelFactory._();
  static Future<Map<String, dynamic>> prepareNewIncidentModel(
      IncidentModel model,
      List<XFile> images,
      int categoryId,
      int subCategoryId) async {
    var files = <MultipartFile>[];
    for (var file in images) {
      files.add(MultipartFile(await file.readAsBytes(), filename: file.name));
    }
    var map = <String, dynamic>{};

    map['Lat'] = model.lat;
    map['Long'] = model.long;
    map['AmountUnitId'] = model.amountUnitId;
    map['UnitValue'] = model.amountValue;
    map['Priority'] = model.priority;
    map['ImagesFiles'] = files;
    map['CategoryId'] = categoryId;
    map['SubCategoryId'] = subCategoryId;
    map['Notes'] = model.notes;
    return map;
  }

  static Future<Map<String, dynamic>> prepareInitialSolutionModel(
      List<XFile> images,
      String lat,
      String long,
      String note,
      String incidentId) async {
    var files = <MultipartFile>[];
    for (var file in images) {
      files.add(MultipartFile(await file.readAsBytes(), filename: file.name));
    }
    var map = <String, dynamic>{};

    map['IncidentID'] = incidentId.toString();
    map['Notes'] = note;
    map['Lat'] = lat;
    map['Lng'] = long;
    map['Images'] = files;
    return map;
  }
}
