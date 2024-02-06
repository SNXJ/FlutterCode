import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// Toast 简单封装
///
class XToast {
  static show({
    required String msg,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        textColor: Colors.black26,
        fontSize: 16.0);
  }

  static showBottom({
    required String msg,
    required Toast toastLength,
    int timeInSecForIos = 1,
    double fontSize = 16.0,
    required ToastGravity gravity,
    required Color backgroundColor,
    required Color textColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black26,
        fontSize: 16.0);
  }
}
