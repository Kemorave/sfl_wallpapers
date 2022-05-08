import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDataModelModel {
  final String userId;
  final int downloadCounter;
  final bool isEnabled;

  UserDataModelModel(
      {required this.userId,
      required this.downloadCounter,
      required this.isEnabled});
  /* 
  factory UserDataModelModel.fromJson(Map<String, dynamic> json) {
    return UserDataModelModel(
        userId: json['userId'],
        downloadCounter: json['downloadCounter'],
        isEnabled: json['isEnabled']);
  }
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "downloadCounter": downloadCounter,
      "isEnabled": isEnabled
    };
  } */
}
