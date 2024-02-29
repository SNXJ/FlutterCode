import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/page/order_page.dart';
import 'package:wd_store/widget/custom_order_type.dart';

import '../api/wd_net.dart';
import '../bus/eventy/tab_eventy.dart';
import '../entity/status_count_entity.dart';
import '../bus/event_bus.dart';
import '../utils/log_util.dart';
import '../widget/custom_indicator.dart';

class OrderAllPage extends StatefulWidget {
  const OrderAllPage({super.key});

  @override
  State<OrderAllPage> createState() => _OrderAllPageState();
}

class _OrderAllPageState extends State<OrderAllPage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomOrderType(),
      body:OrderPage(-1),
    );
  }

  @override
  void initState() {
    super.initState();
    LogUtils.d('选中的索引0:');
  }


}
