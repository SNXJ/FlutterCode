import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/utils/style_util.dart';
import 'package:wd_store/utils/toast_util.dart';

import 'custom_dropdown_menu.dart';
import 'dropdown_menu_rout.dart';

class CustomOrderType extends StatelessWidget implements PreferredSizeWidget {
  CustomOrderType({super.key});

  final GlobalKey _anchorKey = GlobalKey();

  // BuildContext mContext;
  @override
  Widget build(BuildContext context) {
    return _buildTabView(context);
  }

  Widget _buildTabView(BuildContext context) {
    return Container(
      key: _anchorKey,
      height: 44.w,
      child: Row(
        children: [
          buildTabTypeView(context, "日期范围", 0),
          // buildTabTypeView(context, "全部类型", 1),
          // buildTabTypeView(context, "全部状态", 2)
        ],
      ),
    );
  }

  Widget buildTabTypeView(BuildContext context, String typeStr, int type) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () => _typeClick(context, type),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                typeStr,
                style: StyleUtils.mTextStyle(16, 0xff333333),
              ),
              Icon(Icons.arrow_drop_down_rounded),
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  _typeClick(BuildContext context, int type) {
    // XToast.show(msg: "类型$type");
    // _showBottomDialog(context);
    showTopDialog(context);
  }

  void _showBottomDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.music_note),
                  title: const Text('类型一'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('类型二'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  void showTopDialog(BuildContext context) {
    // Overlay.of(context)!.insert(OverlayEntry(
    //     builder: (context) => CustomDropdownMenu(anchorKey: _anchorKey)));

    Navigator.of(context).push(
        DropDownMenuRoute(
          child: Container(
            width: 500,
            height: 200,
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text('Music'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.videocam),
                  title: Text('Video'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          position: _getMenuPosition(_anchorKey),
        ),
    );
  }
  Rect _getMenuPosition(GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(position.dx, position.dy + size.height, size.width, size.height);
  }
}
