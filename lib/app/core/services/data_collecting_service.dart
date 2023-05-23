import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class DataCollectingService extends GetxService {
  final service = FirebaseAnalytics.instance;

  @override
  void onInit() async {
    super.onInit();
    await service.setAnalyticsCollectionEnabled(true);
  }

  Future<void> logDetectionResult(String category, bool recognizedByAi) {
    return service.logEvent(
        name: 'ai_detection_result',
        callOptions: AnalyticsCallOptions(global: true),
        parameters: {
          'category': category,
          'detected_by_ai': recognizedByAi.toString()
        });
  }

  Future<void> logAppOpen() {
    return service.logAppOpen();
  }
}
