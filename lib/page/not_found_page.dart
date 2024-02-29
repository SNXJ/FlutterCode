import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wd_store/entity/shop_entity.dart';
import 'package:wd_store/page/switch_page.dart';
import 'package:wd_store/widget/custom_appbar.dart';

import '../entity/login_data_entity.dart';
import '../api/net_api.dart';
import '../net/http_util.dart';
import '../utils/sp_util.dart';
import '../utils/style_util.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  String mobile = "";
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: CustomAppBar(title: "页面未找到", showBack: false),
      body: Center(
        child: Text("404 not found"),
      ),
    );
  }
}
