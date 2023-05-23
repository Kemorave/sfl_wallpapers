import 'package:sfl/app/data/model/user_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/model/device_data_model.dart';

class FireStoreService extends GetxService {
  final _firestore = FirebaseFirestore.instance;
  late final devices = _firestore.collection('devices');

  Future<DeviceDataModel?> getDeviceData(String token) async {
    var res =
        await devices.limit(1).where('devieToken', isEqualTo: token).get();
    if (res.docs.isNotEmpty) {
      var dataJson = res.docs.first.data();
      dataJson['id'] = res.docs.first.id;
      return DeviceDataModel.fromJson(dataJson);
    }
    return null;
  }

  Future<void> saveNewDeviceLogin(UserModel user, String token) async {
    var deviceData = await getDeviceData(token);
    if (deviceData != null) {
      return;
    }
    await devices.add(DeviceDataModel(
            devieToken: token,
            userId: user.id,
            userName: user.fullName ?? user.firstName ?? user.lastName)
        .toJson());
  }

  Future<void> deleteDeviceLogin(UserModel user, String token) async {
    var deviceData = await getDeviceData(token);
    if (deviceData == null) {
      return;
    }
    await devices.doc(deviceData.id).delete();
  }
}
