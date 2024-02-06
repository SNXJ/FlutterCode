import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/entity/order_entity.dart';
import 'package:wd_store/entity/request/order_request.dart';
import 'package:wd_store/utils/style_util.dart';
import 'package:wd_store/utils/toast_util.dart';
import 'package:wd_store/widget/common_no_data.dart';

import '../api/wd_api.dart';
import '../widget/custom_appbar.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
    this.index, {
    super.key,
  });

  final int? index;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin {
  List<Records> orderList = [];
  List<String> orderStatusStr = [
    "WAIT_PAY",
    "PAY_SUCCESS",
    "WAIT_DELIVER",
    "WAIT_RECEIVE",
    "COMPLETE",
    "CANCEL",
    ""
  ];

  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool _isLoading = false;
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();

    XToast.show(msg: "index:${widget.index}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 触发上拉加载更多
        _loadMoreItems();
      }
    });
    _getOrderData(page, true);
  }

  Future _getOrderData(int page, bool show) async {
    OrderRequest orderRequest = OrderRequest(
        orderStatus: orderStatusStr[widget.index! + 1], current: page);
    var orderResponse = await WdApi.getOrderPage(orderRequest, show);
    // if (orderResponse != null) {
    //   setState(() {
    //     orderList = orderResponse?.records;
    //     // statusCount=countData;
    //   });
    // }
    if (null != orderResponse) {
      setState(() {
        if (page == 1) {
          orderList?.clear();
          List<Records>? list = orderResponse?.records;
          if (null != list) {
            orderList.addAll(list);
          }
        } else {
          List<Records>? list = orderResponse?.records;
          if (null != list) {
            orderList.addAll(list);
          }
          if (list!.length < 10) {
            _loadComplete = true;
          }
          _isLoading = false;
        }
      });
    } else {
      _loadComplete = true;
      _isLoading = false;
    }
  }

  Future<void> _refresh() async {
    page = 1;
    _getOrderData(page, false);
  }

  Future<void> _loadMoreItems() async {
    if (_loadComplete) {
      return;
    }
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      page++;
      _getOrderData(page, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        // appBar: const CustomAppBar(title: "订单", showBack: false),
        body: _buildRefreshIndicator()
        // ListView.builder(
        //   itemCount: orderList?.length,
        //   itemBuilder: (context, index) {
        //     return _buildItem(orderList![index]);
        //   },
        // ),
        );
  }

  @override
  bool get wantKeepAlive => true;

  RefreshIndicator _buildRefreshIndicator() {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: const Color(0xFFED7B2F),
      onRefresh: _refresh,
      child:
          // (page == 1 && orderList.isEmpty)?_buildNoDataBox():
          ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: orderList.isEmpty ? 1 : orderList.length,
        itemBuilder: (context, index) {
          if (index == orderList.length + 1) {
            return (_isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFED7B2F)),
                      // 设置大小
                      strokeWidth: 2.0,
                    ),
                  )
                : const SizedBox());
          } else {
            // 其他位置是列表项
            final itemIndex = index;
            return (page == 1 && orderList.isEmpty)
                ? const CommonNoData()
                : ListTile(
                    title: _buildItem(orderList![itemIndex]),
                    onTap: () {
                      print('Item $itemIndex tapped');
                    },
                  );
          }
        },
      ),
    );
  }

  Widget _buildItem(Records item) {
    SupplierOrder supplierOrder = item.supplierOrder!;
    return Container(
      margin: const EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 0).w,
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15).w,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(2.0).r,
          color: Colors.white),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15).w,
            color: const Color(0xffFEF3E6),
            child: //#FEF3E6
                Row(
              children: [
                Text(
                  "${supplierOrder?.dvyType == "DELIVERY" ? "快递" : "同城"}${supplierOrder.sequenceOrderNumber}",
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xff333333)),
                ),
              ],
            ),
          ),

          ///其他
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15).w,
            margin: const EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 10).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "其他信息",
                  style: TextStyle(
                      fontSize: 16.sp, color: const Color(0xff666666)),
                ),
                SizedBox(height: 20.w,),
                Text(
                  "姓名：${supplierOrder.orderAddrVO?.receiveName}",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xff999999)),
                ),
                Text(
                  "地址：${supplierOrder.orderAddrVO?.addr}",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xff999999)),
                ),
                Text(
                  "电话：${supplierOrder.orderAddrVO?.receiveMobile}",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xff999999)),
                ),
                Text(
                  "支付：${supplierOrder.payTime}",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xff999999)),
                ),
                Text(
                  "单号：${supplierOrder.orderNumber}",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xff999999)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
