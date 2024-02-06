import 'package:flutter_easyloading/flutter_easyloading.dart';

bool loadingStatus = false;

class LoadingUtils {
  static show() {
    EasyLoading.show(status: "加载中...");
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
