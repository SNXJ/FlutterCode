import 'package:flutter/material.dart';
import 'package:wd_store/bus/event_bus.dart';
import 'package:wd_store/bus/eventy/tab_eventy.dart';
import 'package:wd_store/utils/log_util.dart';

import '../utils/sp_util.dart';
import '../widget/lazy_indexed_stack.dart';
import 'home_page.dart';
import 'mine_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  final LazyIndexedStackController stackController =
      LazyIndexedStackController();
  PageController? _pageController;
  var tabEvent;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    tabEvent=myEventBus.on<TabEvent>().listen((event) {
      LogUtils.i("=======main==tabEvent====$event");
        onTabTapped(0);
    });
  }
  @override
  void dispose() {
    super.dispose();
    tabEvent.cancel();
  }

  late Widget homepage;
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const MinePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      // stackController.jumpTo(_currentIndex);
      _pageController?.jumpToPage(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // body: _children[_currentIndex],
      // body: LazyIndexedStack(
      //   ////懒加载
      //   controller: stackController,
      //   itemSize: _children.length,
      //   itemBuilder: (context, index) {
      //     return _children![index];
      //   },
      // ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _children,
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrangeAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          )
        ],
      ),
    );
  }
}
