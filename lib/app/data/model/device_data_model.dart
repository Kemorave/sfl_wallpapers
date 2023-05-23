import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_data_model.freezed.dart';
part 'device_data_model.g.dart';

@freezed
class DeviceDataModel with _$DeviceDataModel {

  factory DeviceDataModel(
      {required String? userId,
      String? id,
      String? userName,
      required String? devieToken}) = _DeviceDataModel;

  factory DeviceDataModel.fromJson(Map<String, dynamic> json) => _$DeviceDataModelFromJson(json);
}