import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:wd_store/page/login_page.dart';
import 'package:wd_store/page/main_page.dart';
import 'package:wd_store/page/test.dart';
import 'package:wd_store/utils/sp_util.dart';

import '../page/not_found_page.dart';

class WdRouter {
  Map<String, WidgetBuilder> routeList = {
    "/": (context) => const MainPage(),
    // "/": (context) => const MyTestPage(title: ""),
    "/login": (context) => const LoginPage(),
    "/notFound": (context) => const NotFoundPage()
  };

  /// 实现路由守卫
  Route routeGenerator(RouteSettings settings) {
    final name = settings.name;
    var builder = routeList[name];
    builder ??= (content) => const NotFoundPage();
    // 用户权限认证的逻辑处理
    var isLogin = _getLoginState();
    if (!isLogin) {
      builder = (context) => const LoginPage();
    }
    //构建动态的route
    final route = MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
    return route;

    // return MaterialPageRoute(////异步
    //   builder: (context) => FutureBuilder(
    //     future: _getLoginState(),
    //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //       if (snapshot.hasData) {
    //         if (snapshot.data as bool) {
    //           return const MainPage();
    //         } else {
    //           return const LoginPage();
    //         }
    //       }
    //       return CircularProgressIndicator();
    //     },
    //   ),
    // );
  }

  // Future<bool> _getLoginState() async {//异步
  //   String? token =  SPUtil().get('token');
  //   return token != null && token.isNotEmpty;
  // }

  bool _getLoginState() {
    String? token = SPUtil().get('token');
    LogUtil.d("========token====$token");
    return token != null && token.isNotEmpty;
  }
}
