import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../locator.dart';
import '../../data/model/incident_model.dart';
import '../enums/incident_status_enum.dart';
import '../services/localization_service.dart';

extension IncidentModelExtentionExtension on IncidentModel {
  String get languageCode => language().locale.lang;

  String? localizedTitle() {
    return '${localizedCategoryName() ?? ''}-'
        '${localizedSubCategoryName() ?? ''} ('
        '${id.substring(0, 3)})';
  }

  String? localizedCategoryName() {
    switch (languageCode) {
      case LanguageCodes.englishCode:
        return incidentCategoryEnglishName;

      case LanguageCodes.arabicCode:
        return incidentCategoryArabicName;
    }
    return 'unknown language code';
  }

  String? localizedSubCategoryName() {
    switch (languageCode) {
      case LanguageCodes.englishCode:
        return incidentSubCategoryEnglishName;

      case LanguageCodes.arabicCode:
        return incidentSubCategoryArabicName;
    }
    return 'unknown language code';
  }

  String? localizedStatusName() {
    switch (languageCode) {
      case LanguageCodes.englishCode:
        return incidentStatusEnglishName;

      case LanguageCodes.arabicCode:
        return incidentStatusArabicName;
    }
    return 'unknown language code';
  }

  String? localizedPriorityName() {
    switch (languageCode) {
      case LanguageCodes.englishCode:
        return priorityTextEnglish;

      case LanguageCodes.arabicCode:
        return priorityTextArabic;
    }
    return 'unknown language code';
  }

  IncidentStatusEnum status() {
    switch (incidentStatusId) {
      case 10:
        return IncidentStatusEnum.newlyCreated;
      case 11:
        return IncidentStatusEnum.assigned;
      case 12:
        return IncidentStatusEnum.solved;
      case 15:
        return IncidentStatusEnum.reponed;
      case 14:
        return IncidentStatusEnum.solvedInitially;
      default:
        return IncidentStatusEnum.unkown;
    }
  }

  BitmapDescriptor markerIcon() {
    switch (status()) {
      case IncidentStatusEnum.newlyCreated:
        return BitmapDescriptor.defaultMarkerWithHue(180);
      case IncidentStatusEnum.assigned:
        return BitmapDescriptor.defaultMarkerWithHue(200);
      case IncidentStatusEnum.solved:
        return BitmapDescriptor.defaultMarkerWithHue(100);
      case IncidentStatusEnum.reponed:
        return BitmapDescriptor.defaultMarkerWithHue(350);
      case IncidentStatusEnum.solvedInitially:
        return BitmapDescriptor.defaultMarkerWithHue(310);
      case IncidentStatusEnum.unkown:
        return BitmapDescriptor.defaultMarkerWithHue(257);
      case IncidentStatusEnum.canceled:
        return BitmapDescriptor.defaultMarkerWithHue(121);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }
}
