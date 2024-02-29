import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wd_store/entity/login_data_entity.dart';
import 'package:wd_store/utils/sp_util.dart';
import '../entity/respon_entity.dart';
import '../main.dart';
import '../utils/loading_util.dart';
import '../utils/log_util.dart';
import '../utils/toast_util.dart';
import '../api/net_api.dart';
@Deprecated("replaced HttpUtil")
class HttpUtil {
  static late HttpUtil instance;

  late Dio dio;
  late BaseOptions options;

  static HttpUtil getInstance() {
    instance ??= HttpUtil();
    return instance;
  }

  HttpUtil() {
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: NetApi.BASE_URL,
      //连接服务器超时时间，单位是秒.
      connectTimeout: const Duration(seconds: 10),
      //响应流上前后两次接受到数据的间隔，单位为秒。
      receiveTimeout: const Duration(seconds: 5),
      //Http请求头.
      headers: {
        // "Authorization": Api.TOKEN,
        "Authorization": SPUtil().get('token'),
        // "Authorization":
        //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJpc3MiOiJjb20ud29vZHkiLCJhdWQiOiJXRF9MSUZFX1ZFTkRPUiIsInN1YiI6ImFhYmJvY2QiLCJpYXQiOjE3MDQ0NDc4MTMsImV4cCI6MTcwNDQ0OTYxMywianRpIjoiMTgyMDUzNDktMjNhNi00ZmE0LTlmNmMtOTY4N2Q5OWU3YzkyIiwidWlkIjo1OSwic2lkIjoxMzEsIm1pZCI6MCwiYml6SWQxIjoiMTY2MDQ2NzA4MzYzODQ4OTA5MSJ9.uJKuoSUu1AoOQv90SapIwdnJZWSa-PCHpZdAAuPdF0gXmdOpbmFzodKZGsVzgl5mLS5xx90LSl_Ug2MNUC2b8g",
        "version": "1.0.0"
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.jsonContentType,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    //添加拦截器
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // LogUtils.i("请求\n"
      //     "${options.method}  url : ${options.baseUrl.toString() + options.path.toString()}\n"
      //     "header : ${options.headers.toString()}\n"
      //     "queryParameters : ${options.queryParameters}\n"
      //     "data : ${options.data}");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      // LogUtils.i("响应\n"
      //     "${response.requestOptions.method} ${response.statusCode}  url : ${response.requestOptions.baseUrl.toString() + response.requestOptions.path.toString()}\n"
      //     "header : ${response.headers.toString()}\n"
      //     "requestData : ${response.requestOptions.data}\n"
      //     "data : $response");

      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      LogUtils.d("错误之前");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      return handler.next(e);
    }));
  }

   _refreshToken(RequestOptions requestOptions) async {
    late Response response;
    try {
      var refreshToken = await SPUtil().get("refreshToken");
      var data = {'refreshToken': refreshToken};
      response = await dio.get(NetApi.TOKEN_REFRESH, queryParameters: data);
      Map<String, dynamic> resp = json.decode(response.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(resp);
      if (baseResponse.code == 0) {
        LoginData loginData = LoginData.fromJson(baseResponse.data!);
        SPUtil().setString("token", loginData.accessToken);
        SPUtil().setString("refreshToken", loginData.refreshToken);
        return true;
      } else if (baseResponse.code == 401) {
        _gotoLogin();
      }
      return false;
    } on DioError catch (e) {
      LogUtils.e('GET error---------$e');
      formatError(e);
    } finally {
      // LoadingUtils.dismiss();
    }
    return false;
  }

  /*
   * get请求
   */
  get(url, data, bool show) async {
    if (show) {
      LoadingUtils.show();
    }
    late Response response;
    try {
      response = await dio.get(url, queryParameters: data);
      return handleResponse(response,show);
    } on DioError catch (e) {
      LogUtils.e('GET error---------$e');
      formatError(e);
    } finally {
      LoadingUtils.dismiss();
    }
    return null;
  }

  Future<Map<String, dynamic>?> handleResponse(
      Response<dynamic> response, bool show) async {
    Map<String, dynamic> resp = json.decode(response.toString());
    BaseResponse baseResponse = BaseResponse.fromJson(resp);
    if (baseResponse.code == 0) {
      return baseResponse.data;
    } else if (baseResponse.code == 401) {
      _gotoLogin();
    } else if (baseResponse.code == 403) {
      //过期 移至response
      var bool = await _refreshToken(response.requestOptions);
      if (bool) {
        var method = response.requestOptions.method;
        var url = response.requestOptions.path;
        // var data = response.requestOptions.data;
        if (method == "GET") {
          var data = response.requestOptions.queryParameters;
          get(url, data, show);
        } else if((method == "POST")){
          var data = response.requestOptions.data;
          post(url, data, show);
        }
        return null;
      }
    } else {
      XToast.show(msg: "${baseResponse.message}");
    }
    return null;
  }

  /*
   * post请求
   */
  post(url, data, bool show) async {
    if (show) {
      LoadingUtils.show();
    }
    late Response response;
    try {
      response = await dio.post(url, data: data);
      return handleResponse(response,show);
    } on DioError catch (e) {
      formatError(e);
    } finally {
      LoadingUtils.dismiss();
    }
    return null;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    late Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      LogUtils.d('downloadFile success---------${response}');
    } on DioError catch (e) {
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
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

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  _gotoLogin() {
    MyApp.navigatorKey.currentState?.pushNamed("/login");
    // Navigator.push(
    //   MyApp.navigatorKey.currentContext!,
    //   CupertinoPageRoute(builder: (context) => const LoginPage()),
    // );
  }
}
