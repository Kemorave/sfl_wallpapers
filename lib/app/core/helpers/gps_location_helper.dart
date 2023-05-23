import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/utils.dart';

import '../exceptions/permissions_exception.dart';
import '../vm.dart';

class GpsLocationHelper {
  static Future<Position> getCurrentPosition({bool? lastOne}) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ViewModel.snackBar(
            title: 'Permission needed', message: 'Location Permission Denied.');
        throw PermissionsException('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ViewModel.snackBar(
          title: 'Permission needed',
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      throw PermissionsException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (lastOne == true) {
      var res = (await Geolocator.getLastKnownPosition());
      if (res == null) {
        Get.printInfo(info: 'No last location found');
      } else {
        return Future.value(res);
      }
    }
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10));
    } on TimeoutException {
      throw const LocationServiceDisabledException();
    } catch (e) {
      rethrow;
    }
  }
}
