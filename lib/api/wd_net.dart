import 'package:wd_store/api/net_api.dart';

import '../entity/login_data_entity.dart';
import '../entity/order_entity.dart';
import '../entity/status_count_entity.dart';
import '../net/dio_util.dart';

class WdNet {
  static Future<LoginData?> getLogin(loginRequest) async {
    var response = await DioUtil()
        .request(NetApi.LOGIN, data: loginRequest.toMap(), method: "POST");
    (response != null) ? LoginData.fromJson(response) : null;
  }

  static Future<StatusCountEntity?> getStatusCount() async {
    var response = await DioUtil().request(NetApi.ORDER_STATUS_COUNT);
    return (response != null) ? StatusCountEntity.fromJson(response) : null;
  }

  static Future<OrderEntity?> getOrderPage(orderRequest, show) async {
    var response = await DioUtil().request(NetApi.ORDER_APGE,
        data: orderRequest.toMap(), method: "POST", show: show);
    return (response != null) ? OrderEntity.fromJson(response) : null;
  }
}
