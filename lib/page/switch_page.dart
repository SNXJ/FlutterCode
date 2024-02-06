import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wd_store/entity/shop_entity.dart';
import 'package:wd_store/page/main_page.dart';

import '../entity/login_data_entity.dart';
import '../net/net_api.dart';
import '../net/http_util.dart';
import '../utils/sp_util.dart';
import '../utils/style_util.dart';
import '../widget/custom_appbar.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key, required this.data});

  final List<Shop> data;

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  List<Shop> shopList = [];

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      setState(() {
        shopList = widget.data;
      });
    }
  }

  Future _switchToken(String employeeId) async {
    var data = {
      'employeeId': employeeId,
      "token": SPUtil().get("token"),
    };
    var responseData = await HttpUtil().post(NetApi.TOKEN_SWITCH, data, false);
    if (responseData == null) {
      return;
    }
    LoginData loginData = LoginData.fromJson(responseData);
    if (loginData?.accessToken != null && loginData?.refreshToken != null) {
      SPUtil().setString("token", loginData.accessToken);
      SPUtil().setString("refreshToken", loginData.refreshToken);
      _gotoPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: const CustomAppBar(title: "选择店铺", showBack: true),
      body: ListView.builder(
        itemCount: shopList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: _buildItem(shopList[index]),
            onTap: () {
              _switchToken(shopList[index].employeeId!);
            },
          );
        },
      ),
    );
  }

  Widget _buildItem(Shop item) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        const SizedBox(height: 15,),
        Text(item.shopName!),
        _buildSubmitButton(item.employeeId)
      ],),
    );
  }

  Widget _buildSubmitButton(String? employeeId) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 20,bottom: 15,left: 30,right: 30),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            backgroundColor: Colors.deepOrangeAccent),
        child: Text(
          "进入店铺",
          style: StyleUtils.mTextStyle2(16, Colors.white),
        ),
        onPressed: () {
          _switchToken(employeeId!);
        },
      ),
    );
  }

  _gotoPage() {
    // Navigator.push(
    //   context,
    //   CupertinoPageRoute(builder: (context) => const MainPage()),
    // );
    ///打开并关闭
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false,//
    );

  }
}
