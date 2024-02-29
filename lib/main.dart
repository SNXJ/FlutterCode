import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/api/net_api.dart';
import 'package:wd_store/router/wd_router.dart';
import 'package:wd_store/utils/env_config.dart';
import 'package:wd_store/utils/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NetApi.BASE_URL = EnvConfig.getBaseUrl("test");
  await SPUtil.perInit();
  // await ScreenUtil.ensureScreenSize();
  // EasyLoading.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // textScaleFactor: 1.0,
              textScaler: const TextScaler.linear(1),
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              builder: EasyLoading.init(),
              // You can use the library anywhere in the app even in theme
              theme: ThemeData(
                primarySwatch: Colors.orange,
                textTheme:
                    Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              ),
              // home: child,
              onGenerateRoute: WdRouter().routeGenerator,
              navigatorKey: navigatorKey,
            ));
      },
      // child: const HomePage(title: 'First Method'),
    );
  }

// return MaterialApp(
//   title: 'Flutter Demo',
//   builder: EasyLoading.init(),
//   debugShowCheckedModeBanner: false,
//   theme: ThemeData(
//     // visualDensity: VisualDensity.adaptivePlatformDensity,
//     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
//     useMaterial3: true,
//   ),
//   // home: const MyTestPage(title: ""),
//   // initialRoute: "main",
//   // routes: WdRouter().routeList,
//   onGenerateRoute: WdRouter().routeGenerator,
//   navigatorKey: navigatorKey,
// );
// }

// @override
// Widget build(BuildContext context) {
//   //预先加载SPUtil
//   return FutureBuilder<SPUtil?>(
//     future: SPUtil.perInit(),
//     builder: (BuildContext context, AsyncSnapshot<SPUtil?> snapshot) {
//       Widget widget = snapshot.connectionState == ConnectionState.done
//           ? const LoginPage() //
//           : const Scaffold(
//         backgroundColor: Colors.deepOrange,
//               body: Center(
//                 child: Text("欢迎"),
//               ),
//             );
//       return MaterialApp(
//         home: widget,
//         title: 'Flutter demo',
//       );
//     },
//   );
// }
}
