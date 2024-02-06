import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wd_store/net/interceptor/token_interceptor.dart';
import 'package:wd_store/utils/loading_util.dart';
import 'package:wd_store/utils/log_util.dart';

import '../entity/respon_entity.dart';
import '../utils/sp_util.dart';
import 'net_api.dart';
import 'interceptor/auth_interceptor.dart';
import 'interceptor/custom_transformer.dart';

class DioUtil {
  // 连接超时时间
  static const int connectTimeout = 10000;

  // 响应超时时间
  static const int receiveTimeout = 6000;

  static Dio _dio = Dio();

  Dio get dio => _dio;

  factory DioUtil() => _getInstance();

  static DioUtil get instance => _getInstance();
  static DioUtil? _instance;

  static DioUtil _getInstance() {
    _instance ??= DioUtil._internal();
    return _instance!;
  }

  DioUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: NetApi.BASE_URL,
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
      responseType: ResponseType.json,
      headers: {"Authorization": SPUtil().get('token'), "version": "1.0.0"},
    );

    _dio = Dio(options);

    // _dio.transformer = CustomTransformer()..jsonDecodeCallback = parseJson;

    Dio tokenDio = Dio(options);
    //TODO
    tokenDio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    tokenDio.interceptors.add(TokenInterceptors());

    _dio.interceptors.add(AuthInterceptor(tokenDio: tokenDio));
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Map<String, dynamic> _parseAndDecode(String response) {
    return jsonDecode(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  Future<Map<String, dynamic>?> request(
    String url, {
    bool show = true,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    String? method = "GET",
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (show) LoadingUtils.show(); //todo
    if (method != null && method != "GET") {
      if (options != null) {
        options?.method = method;
      } else {
        options = Options(method: method);
      }
    }
    Response<Map<String, dynamic>> response =
        await _dio.request<Map<String, dynamic>>(url,
            data: data,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
    LoadingUtils.dismiss();
    if (response.data is Map<String, dynamic>) {
      var model = BaseResponse.fromJson(response.data as Map<String, dynamic>);
      return model.data;
    }
    return null;
  }

// Future<Response<T>> request<T>(
//     String url, {
//       bool show = true,
//       Object? data,
//       Map<String, dynamic>? queryParameters,
//       CancelToken? cancelToken,
//       Options? options,
//       ProgressCallback? onSendProgress,
//       ProgressCallback? onReceiveProgress,
//     }) async {
//   if (show) LoadingUtils.show();
//   Response<Map<String,dynamic>> response = await _dio.request<Map<String,dynamic>>(url,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//       options: options,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress);
//
//   if (response.data is Map<String, dynamic>) {
//     //TODO
//     var model = BaseResponse.fromJson(response.data as Map<String, dynamic>);
//     response.data= model.data as T?;
//   }
//   LoadingUtils.dismiss();
//   // BaseResponse baseResponse = BaseResponse.fromJson(response.data as Map<String, dynamic>);
//   return response;
// }
}
