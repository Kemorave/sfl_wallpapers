import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PerformanceMonitoringService extends GetxService {
  final _service = FirebasePerformance.instance;
  @override
  void onInit() {
    super.onInit();
    _service.setPerformanceCollectionEnabled(!kDebugMode);
  }

  HttpMetric newHttpMetric(String url, HttpMethod method) =>
      _service.newHttpMetric(url, method);
}
