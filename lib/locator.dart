import 'package:sfl/app/core/services/data_collecting_service.dart';
import 'package:sfl/app/core/services/error_control_service.dart';
import 'package:sfl/app/core/services/api/secure_local_data_service.dart';
import 'package:sfl/app/core/services/api/navigation_service.dart';
import 'package:sfl/app/core/services/fire_store_service.dart';
import 'package:sfl/app/core/services/localization_service.dart';
import 'package:sfl/app/core/services/user_data_service.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/services/api/local_data_service.dart';
import 'app/core/services/notification_service.dart';
import 'app/core/services/performance_monitoring_service.dart';
import 'app/data/unit_of_work.dart';

final _locator = GetIt.I;
T locate<T extends Object>({String? tag}) => _locator.get<T>(instanceName: tag);
void singleTone<T extends Object>(T obj, {String? tag}) =>
    _locator.registerSingleton<T>(obj, instanceName: tag);
void factoryRegister<T extends Object>(T Function() obj) =>
    _locator.registerFactory<T>(obj);

NavigationService navigation() => locate<NavigationService>();
SecureLocalDataService secureLocalStorage() => locate<SecureLocalDataService>();
LocalDataService localStorage() => locate<LocalDataService>();
UserDataService userService() => locate<UserDataService>();
LocalizationService language() => locate<LocalizationService>();
ErrorControlService errorControl() => locate<ErrorControlService>();
DataCollectingService analytics() => locate<DataCollectingService>();
NotificationService notification() => locate<NotificationService>();
PerformanceMonitoringService performance() =>
    locate<PerformanceMonitoringService>();
FireStoreService fireStore() =>
    locate<FireStoreService>();

void initLocator() {
  singleTone(SecureLocalDataService());
  singleTone(LocalDataService(GetStorage()));
  singleTone(LocalizationService());
  singleTone(FireStoreService());
  singleTone(DataCollectingService());
  singleTone(PerformanceMonitoringService());
  singleTone(NotificationService());
  singleTone(ErrorControlService());
  singleTone(NavigationService());
  factoryRegister<UnitOfWork>(() => UnitOfWork());
  singleTone(UserDataService());
}
