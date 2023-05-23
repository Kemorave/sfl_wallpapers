// ignore_for_file: constant_identifier_names

import 'package:sfl/app/data/repositories/collection_repository.dart';
import 'package:sfl/app/data/repositories/incident_repository.dart';
import 'package:sfl/app/data/repositories/notification_repository.dart';

import 'repositories/user_repository.dart';

class UnitOfWork {
  static const API_BASE = "https://api.pexels.com/v1/";
  static const STAGING_API_BASE = "https://api.pexels.com/v1/";
  UnitOfWork();
  final UserRepository userRepository = UserRepository();
  final IncidentRepository incidentRepository = IncidentRepository();
  final CollectionRepository categoryRepository = CollectionRepository();
  final NotificationRepository notificationRepository =
      NotificationRepository();
  dispose() {
    userRepository.dispose();
    categoryRepository.dispose();
    incidentRepository.dispose();
    notificationRepository.dispose();
  }
}
