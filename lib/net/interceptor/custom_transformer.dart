import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:wd_store/entity/respon_entity.dart';

import '../../utils/log_util.dart';

class CustomTransformer extends DefaultTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    return super.transformRequest(options);
  }

  @override
  Future transformResponse(
      RequestOptions options, ResponseBody responseBody) async {
    var response = await super.transformResponse(options, responseBody);
    if (response is Map<String, dynamic>) {
      // if (response.containsKey('data') && response['data'] is Map<String, dynamic>) {
      //   return response['data'];
      // }
      // // 将Map转换为你的模型类
      var model = BaseResponse.fromJson(response);
      return model.data;
    }
    return null;
  }
}
