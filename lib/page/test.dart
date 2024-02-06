import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wd_store/entity/store_entity.dart';
import 'package:wd_store/utils/sp_util.dart';

import '../entity/login_data_entity.dart';
import '../net/net_api.dart';
import '../net/http_util.dart';
import '../utils/toast_util.dart';


class MyTestPage extends StatefulWidget {
  const MyTestPage({super.key, required this.title});

  final String title;

  @override
  State<MyTestPage> createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  static const platform = MethodChannel('msg_channel_name'); //
  String dataFromAndroid = "";

  @override
  void initState() {
    super.initState();
    // 在 initState 中调用初始化时的方法
    getDataFromPlatform();
  }

  Future<void> getDataFromPlatform() async {
    try {
      final String result = await platform.invokeMethod(
          'sendDataToAndroid', 'Hello from Flutter!');
      setState(() {
        dataFromAndroid = result;
        NetApi.TOKEN = dataFromAndroid;
      });

    } on PlatformException catch (e) {
      print("Failed to send data to Android: ${e.message}");
    }

    print('sendDataToAndroid result---------$dataFromAndroid');
  }

  Future doRequest() async {
    var data = {
      "password": "123456",
      "userName": "aabbocd",
    };

    var responseData = await HttpUtil().post(NetApi.LOGIN, data, false);
    // Map userMap = json.decode(response.toString());
    LoginData loginData = LoginData.fromJson(responseData);
    SPUtil().setString("token", loginData.accessToken);
    SPUtil().setString("refreshToken", loginData.refreshToken);

    // var userEntity = UserEntity.fromJson(userMap);
  }

  Future doRequestStore() async {
    var data = {'orderType': "", "queryType": 0, 'sysTime': "2024-01-05"};
    var response = await HttpUtil().get(NetApi.STORE, data, true);
   StoreEntity storeEntity= StoreEntity.fromJson(response);
    XToast.show(msg: "store$storeEntity");
    // var userEntity = UserEntity.fromJson(userMap);
  }

  Future getOrderPage() async {
    Map<String, String> data = {
      "dvyType": "",
      "endTime": "",
      "mergeQueryStr": "",
      "orderStatus": "PAY_SUCCESS",
      "startTime": "",
      "current": "1",
      "size": "20"
    };
    var response =
        await HttpUtil().post(NetApi.ORDER_PAGE, json.encode(data), true);
    // Map userMap = json.decode(response.toString());
    // XToast.show(msg: "order:$userMap");
    // var userEntity = UserEntity.fromJson(userMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              child: Text("${dataFromAndroid}"),
              onPressed: () {
                doRequest();
              },
            ),
            TextButton(
              child: const Text("登陆"),
              onPressed: () {
                doRequest();
              },
            ),
            TextButton(
              child: const Text("store"),
              onPressed: () {
                doRequestStore();
              },
            ),
            TextButton(
              child: const Text("订单"),
              onPressed: () {
                getOrderPage();
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          // 处理返回操作，可以使用 Navigator.pop 或其他导航操作
          // Navigator.pop(context);
          // SystemNavigator.pop();
          Navigator.pop(context, 'Hello from test Page!');
        },
      ),
      title: const Text(
        "标题标题",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
