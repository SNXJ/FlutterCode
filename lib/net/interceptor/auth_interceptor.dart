import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wd_store/entity/login_data_entity.dart';
import 'package:wd_store/entity/respon_entity.dart';
import 'package:wd_store/utils/loading_util.dart';
import 'package:wd_store/utils/sp_util.dart';

import '../../main.dart';
import '../../utils/log_util.dart';
import '../net_api.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final Dio tokenDio;
  final int _statusCode = 401;
  final int _expiredCode = 403;

  AuthInterceptor({required this.tokenDio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {'Authorization': SPUtil().get("token")};
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    var options = response.requestOptions;
    if (response.data['code'] == _expiredCode) {
      debugPrint('${options.path}，需要刷新token');
      bool isAuth = await refreshToken();
      debugPrint('刷新token完成');
      if (isAuth) {
        Response responseRetry = await _retry(options);
        debugPrint('重试:${options.path}');
        debugPrint('重试响应:${responseRetry.data.toString()}');
        handler.resolve(responseRetry);
      } else {
        _gotoLogin();
        handler.next(response);
      }
    } else if (response.data['code'] == _statusCode) {
      _gotoLogin();
      handler.next(response);
    } else {
      handler.next(response);
    }
    // handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    formatError(err);
    LoadingUtils.dismiss();
    super.onError(err, handler);
  }

  Future<bool> refreshToken() async {
    debugPrint('刷新token开始');
    String mpLoginURL = NetApi.TOKEN_REFRESH;
    Map<String, dynamic> params = {
      "refreshToken": SPUtil().get("refreshToken")
    };
    Response response =
    await tokenDio.request(mpLoginURL, queryParameters: params);
    if (response.data['code'] == 0) {
      Map<String, dynamic> resp = json.decode(response.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(resp);
      LoginData loginData = LoginData.fromJson(baseResponse.data!);
      SPUtil().setString("token", loginData.accessToken);
      SPUtil().setString("refreshToken", loginData.refreshToken);
      return true;
    } else {
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    return tokenDio.request<dynamic>(
        requestOptions.path, data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(
            method: requestOptions.method, headers: requestOptions.headers));
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.connectionTimeout) {
      // It occurs when url is opened timeout.
      LogUtils.e("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      LogUtils.e("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      LogUtils.e("响应超时");
    } else if (e.type == DioErrorType.badResponse) {
      // When the server response, but with a incorrect status, such as 404, 503...
      LogUtils.e("响应异常:${e.message}");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      LogUtils.e("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      LogUtils.e("未知错误");
    }
  }

  _gotoLogin() {
    MyApp.navigatorKey.currentState?.pushNamed("/login");
    // Navigator.push(
    //   MyApp.navigatorKey.currentContext!,
    //   CupertinoPageRoute(builder: (context) => const LoginPage()),
    // );
  }
}
