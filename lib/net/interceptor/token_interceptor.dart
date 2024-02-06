import 'package:dio/dio.dart';
import 'package:wd_store/utils/sp_util.dart';

class TokenInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {'Authorization': SPUtil().get("token")};
    handler.next(options);
  }
}
