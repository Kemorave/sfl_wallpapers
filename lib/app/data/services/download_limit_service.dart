import 'package:get/get.dart';

class DownloadLimitService extends GetxService {
  final downloadTimes = 0.obs;
  final maxDownloadTimes = 10.obs;
  void OnDownload() {}
}
