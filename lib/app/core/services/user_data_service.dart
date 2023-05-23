import 'dart:convert';
import 'package:sfl/app/core/mixins/api_call_mixin.dart';
import 'package:sfl/locator.dart';
import 'package:sfl/app/core/services/api/secure_local_data_service.dart';
import 'package:get/get.dart';

import '../../data/dto/login_responce_dto.dart';
import '../../data/model/user_model.dart';
import '../enums/user_permission_enum.dart';

class UserDataService extends GetxService with ApiCallMixin {
  final String _userKey = 'userKSR';
  final String _tokenKey = 'tokenKSR';
  final String _refreshTokenKey = 'rtokenKSR';
  final SecureLocalDataService _localDataService = secureLocalStorage();
  late UserModel? _user;
  UserModel get user => _user ?? UserModel();

  bool checkPermission(UserPermissionEnum permission) {
    return user.userRoles?.any((element) =>
            element.permissions?.any((pr) => pr == permission.value) ??
            false) ??
        false;
  }

  Future<void> loadUser() async {
    if (await isLogedIn()) {
      _user = (await getUser())!;
    }
  }

  Future<void> refreshUserData() async {
    if (await isLogedIn()) {
      final res = await api.userRepository.getProfile();
      _user = _user!.copyWith(
          email: res.result!.email,
          phoneNumber: res.result!.phoneNumber,
          idNumber: res.result!.idNumber);
      await setUser(_user!);
    }
  }

  Future<bool> isLogedIn() => _localDataService.hasKey(_userKey);

  Future<UserModel?> getUser() async {
    if (!await _localDataService.hasKey(_userKey)) {
      return null;
    }
    var json = jsonDecode((await _localDataService.getKey(_userKey))!);
    var user = UserModel.fromJson(json);
    return user;
  }

  Future<void> login(LoginResponceDTO loginResponceDTO) async {
    _user = loginResponceDTO.user;
    await setUser(loginResponceDTO.user!);
    if (loginResponceDTO.refreshToken != null) {
      await setRefreshToken(loginResponceDTO.refreshToken!);
    }
    await setAccessToken(loginResponceDTO.accessToken!);
    var token = await notification().getToken();
    if (token != null) {
      await fireStore().saveNewDeviceLogin(_user!, token);
    }
  }

  Future<void> logout() async {
    await _localDataService.removeKey(_userKey);
    await _localDataService.removeKey(_tokenKey);
    await _localDataService.removeKey(_refreshTokenKey);
    Future.microtask(() async {
      var token = await notification().getToken();
      if (token != null && _user != null) {
        await fireStore().deleteDeviceLogin(_user!, token);
      }
      _user = null;
    });
  }

  Future<void> setUser(UserModel user) {
    _user = user;
    return _localDataService.setKey(_userKey, json.encode(user.toJson()));
  }

  Future<void> setAccessToken(String token) {
    return _localDataService.setKey(_tokenKey, token);
  }

  Future<String?> getAccessToken() {
    return _localDataService.getKey(_tokenKey);
  }

  Future<String?> getRefreshToken() {
    return _localDataService.getKey(_refreshTokenKey);
  }

  Future<void> setRefreshToken(String? token) {
    if (token == null) return _localDataService.removeKey(_refreshTokenKey);
    return _localDataService.setKey(_refreshTokenKey, token);
  }
}
