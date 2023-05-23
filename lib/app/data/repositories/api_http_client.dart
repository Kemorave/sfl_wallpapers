import 'dart:async';

import 'package:sfl/app/data/unit_of_work.dart';
import 'package:sfl/locator.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mutex/mutex.dart';

import '../../core/exceptions/repository_disposed_exception.dart';
import '../dto/refresh_token_dto.dart';
import 'base/i_http_client.dart';

class ApiHttpClient implements IHttpClient {
  late final GetConnect _httpclient = _constructClient();
  static final _lockMutex = Mutex();
  bool _disposed = false;

  GetConnect _constructClient() {
    final client = GetConnect(withCredentials: true);
    client.baseUrl =
        kDebugMode ? UnitOfWork.API_BASE : UnitOfWork.STAGING_API_BASE;
    client.timeout = const Duration(seconds: 60);
    client.httpClient.addRequestModifier<dynamic>(_attachHeaders);
    client.httpClient.addAuthenticator<dynamic>(_refreshToken);
    if (kDebugMode) {
      client.httpClient.addRequestModifier<dynamic>(_debugRequest);
      client.httpClient.addResponseModifier<dynamic>(_debugResponse);
    }
    return client;
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    final metric =
        performance().newHttpMetric(_httpclient.baseUrl! + url, HttpMethod.Get);
    await metric.start();
    var res = await _disposeContainer(_httpclient.get<T>(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    ));
    metric.httpResponseCode = res.statusCode;
    metric.responseContentType = 'application/json';
    await metric.stop();
    return res;
  }

  @override
  Future<Response<T>> post<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final metric = performance()
        .newHttpMetric(_httpclient.baseUrl! + url, HttpMethod.Post);
    await metric.start();
    var res = await _disposeContainer(_httpclient.post<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ));
    metric.httpResponseCode = res.statusCode;
    metric.responseContentType = 'application/json';
    await metric.stop();
    return res;
  }

  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final metric =
        performance().newHttpMetric(_httpclient.baseUrl! + url, HttpMethod.Put);
    await metric.start();
    var res = await _disposeContainer(_httpclient.put<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ));

    metric.httpResponseCode = res.statusCode;
    metric.responseContentType = 'application/json';
    await metric.stop();
    return res;
  }

  @override
  Future<Response<T>> patch<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final metric = performance()
        .newHttpMetric(_httpclient.baseUrl! + url, HttpMethod.Patch);
    await metric.start();
    var res = await _disposeContainer(_httpclient.patch<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ));
    metric.httpResponseCode = res.statusCode;
    metric.responseContentType = 'application/json';
    await metric.stop();
    return res;
  }

  @override
  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    final metric = performance()
        .newHttpMetric(_httpclient.baseUrl! + url, HttpMethod.Trace);
    await metric.start();
    var res = await _disposeContainer(_httpclient.request<T>(
      url,
      method,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    ));
    metric.httpResponseCode = res.statusCode;
    metric.responseContentType = 'application/json';
    await metric.stop();
    return res;
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    final metric = performance()
        .newHttpMetric(_httpclient.baseUrl! + url, HttpMethod.Delete);
    await metric.start();
    var res = await _disposeContainer(_httpclient.delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    ));
    metric.httpResponseCode = res.statusCode;
    metric.responseContentType = 'application/json';
    await metric.stop();
    return res;
  }

  FutureOr<Request> _refreshToken(Request request) async {
    try {
      await _lockMutex.acquire();
      var refreshToken = await userService().getRefreshToken();
      if (refreshToken == null) return request;
      final lastAT = request.headers["x-access-token"];
      if (lastAT != (await _attachHeaders(request)).headers["x-access-token"]) {
        return request;
      }
      var res = await _httpclient
          .post('/api/auth/refreshtoken', {'refreshToken': refreshToken});
      if (res.isOk) {
        var refreshDTO = RefreshTokenDTO.fromJson(res.body);
        await userService().setAccessToken(refreshDTO.accessToken);
        await userService().setRefreshToken(refreshDTO.refreshToken);
        await _attachHeaders(request);
      } else if (res.unauthorized || res.statusCode == 403) {
        await userService().setRefreshToken(null);
      }
      return request;
    } finally {
      _lockMutex.release();
    }
  }

  FutureOr<Request> _attachHeaders(Request request) async {
    if (await userService().isLogedIn()) {
      request.headers["Authorization"] =
          "Bearer ${await userService().getAccessToken()}";
    }
    return request;
  }

  FutureOr<Request> _debugRequest(Request request) async {
    Get.printInfo(
        info:
            "[Http request] for ${request.url.toString()} \nmethod:${request.method} \ncontent-type:${request.headers['content-type']}");
    return request;
  }

  // ignore: unused_element
  FutureOr _debugResponse(Request request, Response response) async {
    Get.printInfo(
        info:
            "[Http response] for ${request.url.toString()} \ncode:${response.statusCode} ");
    return response;
  }

  Future<Response<T>> _disposeContainer<T>(Future<Response<T>> future) {
    try {
      return future;
    } catch (e) {
      if (_disposed) {
        throw RepositoryDisposedException();
      }
      rethrow;
    }
  }

  @override
  dispose() {
    _disposed = true;
    _httpclient.dispose();
  }
}
