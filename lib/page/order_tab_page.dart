import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/page/order_page.dart';

import '../api/wd_net.dart';
import '../bus/eventy/tab_eventy.dart';
import '../entity/status_count_entity.dart';
import '../bus/event_bus.dart';
import '../utils/log_util.dart';
import '../widget/custom_indicator.dart';

class OrderTabPage extends StatefulWidget {
  const OrderTabPage({super.key});

  @override
  State<OrderTabPage> createState() => _OrderTabPageState();
}

class _OrderTabPageState extends State<OrderTabPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  var tabEvent;

  @override
  Widget build(BuildContext context) {
    return
        // DefaultTabController(
        // length: 4,
        // child:
        Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildTabBar(),
      body: _buildTabBarView(),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    LogUtils.d('选中的索引0:');
    _tabController = TabController(length: 4, vsync: this);
    _tabController?.addListener(() {
      if (_tabController?.index == _tabController?.animation?.value) {
        LogUtils.i('选中的索引: ${_tabController?.index}');
      }
    });
    tabEvent = myEventBus.on<TabEvent>().listen((event) {
      LogUtils.i("=======orderTab==tabEvent====$event");
      _tabController?.index = event.index;
    });
    _getStatusCount();
  }

  @override
  void dispose() {
    super.dispose();
    tabEvent.cancel();
  }

  StatusCountEntity? statusCount;

  Future _getStatusCount() async {
    var countData = await WdNet.getStatusCount();
    if (countData != null) {
      setState(() {
        statusCount = countData;
      });
    }
    // _tabController.animateTo(value)
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: const [
        OrderPage(0),
        OrderPage(1),
        OrderPage(2),
        OrderPage(3),
      ],
    );
  }

  Offstage getOrderPage(int page) {
    return Offstage(
      offstage: _tabController?.index != page,
      child: TickerMode(
        enabled: _tabController?.index == page,
        child: OrderPage(page),
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return
        // PreferredSize(//无效
        //   preferredSize: Size.fromHeight(50.w), // 设置高度为50像素
        //   child:
        TabBar(
      controller: _tabController,

      ///or指示器
      // indicator: const UnderlineTabIndicator(
      //   borderSide: BorderSide(
      //     color: Colors.deepOrangeAccent, // 指示线颜色
      //     width: 4.0, // 指示线高度
      //   ),
      // insets: EdgeInsets.symmetric(horizontal:16.0)
      // ),

      ///or指示器
      // indicatorColor: Colors.deepOrangeAccent,
      // indicatorSize: TabBarIndicatorSize.label,
      ///or自定义
      indicator: CustomIndicator(),
      labelColor: Colors.deepOrangeAccent,
      unselectedLabelColor: const Color(0xff999999),
      indicatorWeight: 0,
      tabs: [
        _buildTab('待拣货', statusCount?.pAYSUCCESS ?? 0),
        _buildTab('待发货', statusCount?.wAITDELIVER ?? 0),
        _buildTab('配送中', statusCount?.wAITRECEIVE ?? 0),
        _buildTab('售后', 0),
      ],
    );
  }

  Widget _buildTab(String text, int count) {
    return Tab(
      height: 40.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 16.sp),
          )),
          count > 0
              ? Positioned(
                  right: -4.w,
                  top: 2.w,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2)
                            .w,
                    decoration: BoxDecoration(
                      color: Colors.red, // 角标背景红色圆形
                      borderRadius: BorderRadius.circular(16).r,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.w,
                    ),
                    child: Text(
                      '${count > 99 ? "99+" : count}',
                      style: TextStyle(
                        color: Colors.white, // 数字为白色
                        fontSize: 10.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
