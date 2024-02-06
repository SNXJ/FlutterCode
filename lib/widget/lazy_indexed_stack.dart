import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index);
typedef TabBarBuilder = Widget Function(BuildContext context, int index);

/// 多页面/容器：懒加载 + 页面/容器缓存
class LazyIndexedStack extends StatefulWidget {
  final int itemSize;
  final int currentIndex;
  final ItemBuilder itemBuilder; // 页面/容器生成器，生成后由 LazyIndexedStack 维护，使用者不需要操心
  final LazyIndexedStackController controller;

  const LazyIndexedStack({
    Key? key,
    required this.itemSize,
    this.currentIndex = 0,
    required this.itemBuilder,
    required this.controller,
  })  : assert((itemSize > 0) && (currentIndex >= 0)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  int currentIndex = 0;
  Map<int, Widget> items = {};

  void resetConfig(int size, int index) {
    items.clear();
    for (int i = 0; i < size; i++) {
      items[i] = _ItemEmpty();
    }
    currentIndex = ((size > index) ? index : 0);
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    resetConfig(widget.itemSize, widget.currentIndex);

    widget.controller.setOnListener(
      getCurrentIndex: () => currentIndex,
      jumpTo: (int index) {
        if ((index == currentIndex) || (index >= items.length)) {
          return;
        }
        if (items[index] is _ItemEmpty) {
          items[index] = widget.itemBuilder(context, index);
        }
        setState(() {
          currentIndex = index;
        });
      },
      reset: (int itemSize, int currentIndex) {
        setState(() {
          resetConfig(itemSize, currentIndex);
          items[currentIndex] = widget.itemBuilder(context, currentIndex);
        });
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        items[currentIndex] = widget.itemBuilder(context, currentIndex);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: items.values.toList(),
    );
  }
}

/// 占位专用
class _ItemEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

typedef JumpTo = void Function(int index);
typedef ResetStack = void Function(int itemSize, int currentIndex);

class LazyIndexedStackController {
  void setOnListener({
    Function? getCurrentIndex,
    JumpTo? jumpTo,
    ResetStack? reset,
  }) {
    _jumpTo = jumpTo;
    _getCurrentIndex = getCurrentIndex;
    _reset = reset;
  }

  /// 获取当前index
  Function? _getCurrentIndex;

  int get currentIndex {
    if (_getCurrentIndex != null) {
      return _getCurrentIndex!();
    }
    return 0;
  }

  JumpTo? _jumpTo;

  /// 跳转指定页面/容器
  void jumpTo(int index) {
    if (_jumpTo != null) {
      _jumpTo!(index);
    }
  }

  ResetStack? _reset;

  /// 重置所有页面/容器
  /// [itemSize] 页面/容器数量
  /// [currentIndex] 展示指定页面/容器
  void reset(int itemSize, int currentIndex) {
    assert((itemSize >= 0) && (currentIndex >= 0));
    assert(currentIndex <= itemSize);
    if (_reset != null) {
      _reset!.call(itemSize, currentIndex);
    }
  }
}

