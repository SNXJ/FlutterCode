import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wd_store/entity/shop_entity.dart';
import 'package:wd_store/page/switch_page.dart';
import 'package:wd_store/utils/toast_util.dart';
import 'package:wd_store/widget/custom_appbar.dart';

import '../api/wd_api.dart';
import '../entity/login_data_entity.dart';
import '../entity/request/login_request.dart';
import '../net/net_api.dart';
import '../net/dio_util.dart';
import '../net/http_util.dart';
import '../utils/sp_util.dart';
import '../utils/style_util.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mobile = "";
  String pwd = "";
  DateTime? lastPressedAt; //上次点击时间

  // Scaffold(
  // backgroundColor: const Color(0xfff5f5f5),
  // appBar: const CustomAppBar(title: "登陆", showBack: false),
  // body: Column(
  // children: [
  // buildInputContainer("请输入手机号", 0),
  // buildInputContainer("请输入密码", 1),
  // buildSubmitButton()
  // ],
  // ),
  // )

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (lastPressedAt == null ||
            DateTime.now().difference(lastPressedAt!) >
                const Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          lastPressedAt = DateTime.now();
          XToast.show(msg: '再次点击退出应用');
          return Future.value();
        }
        SystemNavigator.pop();
        return Future.value();
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: const CustomAppBar(title: "登陆", showBack: false),
        body: Column(
          children: [
            buildInputContainer("请输入手机号", 0),
            buildInputContainer("请输入密码", 1),
            buildSubmitButton()
          ],
        ),
      ), // 当为 false 时，阻止当前路由被弹出
    );
  }

  Widget buildSubmitButton() {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(30),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            backgroundColor: Colors.deepOrangeAccent),
        child: Text(
          "登陆",
          style: StyleUtils.mTextStyle2(16, Colors.white),
        ),
        onPressed: () {
          _onSubmit();
        },
      ),
    );
  }

  void _onSubmit() {
    // if (mobile.isEmpty) {
    //   XToast.show(context: context, msg: "请输入手机号");
    //   return;
    // }
    // if (pwd.isEmpty) {
    //   XToast.show(context: context, msg: "请输入密码");
    //   return;
    // }
    // getLoginInfo(mobile, pwd);
    getLoginInfo0(mobile, pwd);
  }

  Future getLoginInfo(String mobile, String pwd) async {
    var data = {
      'userName': "sxj123",
      "password": "123456",
    };
    var response = await DioUtil().request(NetApi.LOGIN_MULTI, data: data);
    // var response = await HttpUtil().post(Api.LOGIN_MULTI, data, false);
    if (response == null) {
      return;
    }
    LoginData loginData = LoginData.fromJson(response);
    if (loginData?.accessToken != null && loginData?.shopList != null) {
      SPUtil().setString("token", loginData.accessToken);
      _gotoPage(loginData?.shopList);
    }
  }

  Future getLoginInfo0(String mobile, String pwd) async {
    var loginRequest = LoginRequest(userName: "aabbocd", password: "123456");
    var loginData=await WdApi.getLogin(loginRequest);
    if (loginData?.accessToken != null) {
      SPUtil().setString("token", loginData?.accessToken);
      SPUtil().setString("refreshToken", loginData?.refreshToken);
      _gotoPageO();
    }
  }

  _gotoPage(List<Shop>? shopList) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => SwitchPage(
                data: shopList!,
              )),
    );
  }

  Container buildInputContainer(
    String placeholder,
    int type,
  ) {
    return Container(
      height: 44,
      margin: EdgeInsets.only(
          left: 35, right: 35, top: type == 0 ? 40 : 15, bottom: 10),
      child: CupertinoTextField(
        obscureText: isMobile(type) ? false : true,
        decoration: BoxDecoration(
          color: Colors.white, // 设置背景颜色
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: const Color(0xff999999), width: 1),
        ),
        maxLength: isMobile(type) ? 11 : 18,
        keyboardType: isMobile(type) ? TextInputType.number : null,
        maxLines: 1,
        placeholder: placeholder,
        cursorColor: const Color(0xff666666),
        onChanged: (text) {
          _onChanged(text, type);
        },
      ),
    );
  }

  bool isMobile(int type) => type == 0;

  _onChanged(String str, int type) {
    setState(() {
      if (isMobile(type)) {
        mobile = str;
      } else {
        pwd = str;
      }
    });
  }

  _gotoPageO() {
    // Navigator.push(
    //   context,
    //   CupertinoPageRoute(builder: (context) => const MainPage()),
    // );
    ///打开并关闭
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
      (route) => false, //
    );
  }
}
