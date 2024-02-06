import 'package:wd_store/net/net_api.dart';

import '../entity/login_data_entity.dart';
import '../entity/order_entity.dart';
import '../entity/status_count_entity.dart';
import '../net/dio_util.dart';

class WdApi {
  static Future<LoginData?> getLogin(loginRequest) async {
    var response = await DioUtil()
        .request(NetApi.LOGIN, data: loginRequest.toMap(), method: "POST");
    if (response != null) {
      return LoginData.fromJson(response);
    }
    return null;
  }

  static Future<StatusCountEntity?> getStatusCount() async {
    var response = await DioUtil().request(NetApi.ORDER_STATUS_COUNT);
    if (response != null) {
      return StatusCountEntity.fromJson(response);
    }
    return null;
  }

  static Future<OrderEntity?> getOrderPage(orderRequest,show) async {
    var response = await DioUtil()
        .request(NetApi.ORDER_APGE, data: orderRequest.toMap(), method: "POST",show: show);
    if (response != null) {
      return OrderEntity.fromJson(response);
    }
    return null;
  }
}
