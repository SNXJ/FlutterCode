import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/page/order_page.dart';

import '../widget/custom_appbar.dart';
import '../widget/lazy_indexed_stack.dart';
import 'order_tab_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  final LazyIndexedStackController stackController =
      LazyIndexedStackController();

  @override
  bool get wantKeepAlive => true;

  final Map<int, Widget> _children = {
    0: const OrderTabPage(),
    1: const OrderPage(-1),
  };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "订单", showBack: false),
      body: Column(
        children: [
          _buildTopWidget(),
          Expanded(
            child: LazyIndexedStack(
              //懒加载
              controller: stackController,
              itemSize: _children.values.length,
              itemBuilder: (context, index) {
                return _children![index]!;
              },
            ),
            // child: IndexedStack(
            //   index: _currentIndex,
            //   children: _children.values.toList(),
            // ),
            // child: TabBarView(
            //   controller: TabController(length: 2, vsync: ScrollableState()),
            //   children: const <Widget>[
            //     OrderTabPage(),
            //     OrderPage(-1)
            //   ],
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 6, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 0,
          ),
          CupertinoSlidingSegmentedControl(
            //切换滑块
            backgroundColor: const Color(0xFFF5f5f5),
            // 选中颜色
            thumbColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8).w,
            children: {
              0: _buildSlidingItem("进行中", 0),
              1: _buildSlidingItem("全部订单", 1),
            },
            groupValue: _currentIndex,
            onValueChanged: _onValueChanged,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10).w,
            decoration: BoxDecoration(
              color: const Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(30).r,
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.search, color: Color(0xff666666)),
                SizedBox(
                  width: 14.w,
                ),
                Text(
                  '搜索',
                  style: TextStyle(fontSize: 14.sp, color: const Color(0xff666666)),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }

  void _onValueChanged(int? value) {
    if (value == null) return;
    setState(() {
      _currentIndex = value;
      stackController.jumpTo(_currentIndex);
    });
  }

  Padding _buildSlidingItem(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10).w,
      child: Text(
        text,
        style: TextStyle(
          color: _currentIndex == index ? Colors.black : Colors.grey,
          fontSize: 14.sp
        ),
      ),
    );
  }
}
