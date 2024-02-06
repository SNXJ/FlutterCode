import 'dart:convert';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/bus/eventy/tab_eventy.dart';
import 'package:wd_store/entity/login_entity.dart';
import 'package:wd_store/entity/respon_entity.dart';
import 'package:wd_store/entity/store_entity.dart';
import 'package:wd_store/net/dio_util.dart';
import 'package:wd_store/utils/log_util.dart';
import 'package:wd_store/utils/sp_util.dart';
import 'package:wd_store/utils/toast_util.dart';

import '../entity/login_data_entity.dart';
import '../net/net_api.dart';
import '../net/http_util.dart';
import '../bus/event_bus.dart';
import '../utils/date_util.dart';
import '../utils/style_util.dart';
import '../widget/common_dialog.dart';
import '../widget/custom_appbar.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  StoreEntity? storeInfo;

  @override
  bool get wantKeepAlive => false; //配合PageView 每次刷新

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    doRequestStore();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      XToast.show(msg: "resume");
    }
  }

  Future doRequestStore() async {
    var data = {
      'orderType': "",
      "queryType": 0,
      'sysTime': WdDateUtil.getCurrentDate()
    };
    // var response =DioUtil().request(Api.STORE,queryParameters: data);
    //TODO
    var response = await DioUtil().request(NetApi.STORE, queryParameters: data);
    if (ObjectUtil.isEmpty(response)) {
      return;
    }
    setState(() {
      storeInfo = StoreEntity.fromJson(response!);
    });
  }

  Future doRequestStore2() async {
    var data = {
      'orderType': "",
      "queryType": 0,
      'sysTime': WdDateUtil.getCurrentDate()
    };
    var response = await HttpUtil().get(NetApi.STORE, data, true);
    if (ObjectUtil.isEmpty(response)) {
      return;
    }
    setState(() {
      storeInfo = StoreEntity.fromJson(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: const CustomAppBar(title: "我的", showBack: false),
      // body: Column(
      //   children: [
      //     _buildTopWidget(),
      //     _buildTodayWidget(),
      //     _buildToDoWidget(),
      //     _buildBottomWidget(),
      //   ],
      // ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildTopWidget();
          } else if (index == 1) {
            return _buildTodayWidget();
          } else if (index == 2) {
            return _buildToDoWidget();
          } else if (index == 3) {
            return _buildBottomWidget();
          }
        },
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w, bottom: 20.w),
      padding: EdgeInsets.only(left: 15.w, top: 8.w, right: 15.w, bottom: 10.w),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8).r,
          color: Colors.white),
      child: Row(
        children: [
          _buildBottomItemWidget("images/ic_address.webp", "收货地址"),
          _buildBottomItemWidget("images/ic_bill.webp", "发票管理"),
          _buildBottomItemWidget("images/ic_account.webp", "财务对账"),
          _buildBottomItemWidget("images/ic_cash.webp", "资金账户"),
          _buildBottomItemWidget("images/ic_printer.png", "打印机"),
        ],
      ),
    );
  }

  Widget _buildBottomItemWidget(String icon, String name) {
    return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            print('Clicked!');
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                icon,
                height: 30.w,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: StyleUtils.mTextStyle(12.sp, 0xff333333),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }

  Widget _buildTopWidget() {
    return Container(
      height: 48.w,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
      margin: EdgeInsets.only(bottom: 0.w),
      child: GestureDetector(
        onTap: () {
          // XToast.show(msg: "退出登陆");
          showLogOut();
        },
        child: Row(
          children: [
            Image.asset(
              "images/ic_store_logo.webp",
              height: 22.h,
              width: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              " ${storeInfo?.supplierName ?? "我店生活"}",
              style: StyleUtils.mTextStyle(16.sp, 0xff333333),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: 4.w,
            ),
            Image.asset(
              "images/ic_narrow_down.webp",
              height: 18.h,
              width: 18.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToDoWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
      padding: EdgeInsets.only(left: 15.w, top: 5.w, right: 15.w, bottom: 15.w),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8).r,
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildToDoTitleRow(),
          Row(
            children: [
              _buildToDoDataWidget(0, "待拣货", "¥ ${storeInfo?.toBeFound ?? 0}"),
              _buildToDoDataWidget(1, "待发货", "¥ ${storeInfo?.toBeDeliver ?? 0}")
            ],
          ),
          Row(
            children: [
              _buildToDoDataWidget(2, "待开票", "${storeInfo?.toBeBilled ?? 0}"),
              // _buildToDoDataWidget("xx", "${storeInfo?.completeOrder}"),
              const Expanded(flex: 1, child: Text("")) //占位
            ],
          )
        ],
      ),
    );
  }

  Widget _buildToDoDataWidget(int index, String str, String num) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              if (index < 2) {
                myEventBus.fire(TabEvent(index));
              }
            },
            child: Container(
                margin: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  top: 10.w,
                  bottom: 0.w,
                ),
                padding: EdgeInsets.only(
                  left: 6.w,
                  right: 5.w,
                  top: 10.w,
                  bottom: 10.w,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8).r,
                    color: const Color(0xfff5f5f5)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        str,
                        style: StyleUtils.mTextStyle(14.sp, 0xff999999),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Row(
                        children: [
                          Text(
                            " $num",
                            style: StyleUtils.mTextStyle(18.sp, 0xff333333),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Expanded(child: Text("")),
                          Image.asset(
                            "images/ic_narrow_next.webp",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }

  Widget buildToDoTitleRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "待办",
          style: StyleUtils.mTextStyle(16.sp, 0xff333333),
        ),
        SizedBox(
          height: 4.w,
          width: 20.w,
          child: TextButton(
            onPressed: null,
            style: StyleUtils.mButtonStyle(
                2, 0.8, Colors.deepOrangeAccent, Colors.deepOrangeAccent),
            child: const Text(""),
          ),
        )
      ],
    );
  }

  Widget _buildTodayWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
      padding: EdgeInsets.only(left: 15.w, top: 5.w, right: 15.w, bottom: 8.w),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8).r,
          color: Colors.white),
      child: Column(
        children: [
          buildTodayTitleRow(),
          Row(
            children: [
              _buildTodayDataWidget(
                  "收款金额", "¥ ${storeInfo?.collectAmount ?? 0}"),
              _buildTodayDataWidget("退款金额", "¥ ${storeInfo?.refundAmount ?? 0}")
            ],
          ),
          Row(
            children: [
              _buildTodayDataWidget(
                  "订单进行中", "${storeInfo?.orderProgress ?? 0}"),
              _buildTodayDataWidget(
                  "确认收获订单", "${storeInfo?.completeOrder ?? 0}")
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTodayDataWidget(String str, String num) {
    return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.only(
              left: 6.w,
              right: 5.w,
              top: 10.w,
              bottom: 10.w,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    str,
                    style: StyleUtils.mTextStyle(14.sp, 0xff999999),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Text(
                    " $num",
                    style: StyleUtils.mTextStyle(16.sp, 0xff333333),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )));
  }

  Row buildTodayTitleRow() {
    return Row(
      children: [
        Text(
          "今日数据",
          style: StyleUtils.mTextStyle(16.sp, 0xff333333),
        ),
        const Expanded(child: Text("")),
        SizedBox(
          height: 28.w,
          child: TextButton(
              style: StyleUtils.mButtonStyle(
                  6.sp, 0.8, const Color(0xff999999), Colors.white),
              onPressed: () {
                XToast.show(msg: "全部");
              },
              child: Text(
                "查看全部",
                style: StyleUtils.mTextStyle(10.sp, 0xff666666),
              )),
        )
      ],
    );
  }

  void showLogOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          title: '提示',
          content: "确认要退出登陆吗",
          leftText: "确认",
          rightText: "取消",
          // onLeftClick: null,
          onLeftClick: () {
            SPUtil().remove("token");
            Navigator.of(context).pop();
            // SystemNavigator.pop();
            // exit(0);
            doRequestStore();
          },
          onRightClick: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
