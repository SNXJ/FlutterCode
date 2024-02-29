import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownMenu extends StatelessWidget {
  final GlobalKey anchorKey;

  CustomDropdownMenu({required this.anchorKey});

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBox =
        anchorKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    return Positioned(
      left: position.dx,
      right: 200.w,
      top: position.dy + size.height,
      child: Material(
        child: Column(
          children: [
            Text("1111"),
            Text("1111"),
            Text("1111"),
            Text("1111"),
          ],
        ),
        // child: ListView(
        //   padding: EdgeInsets.zero,
        //   shrinkWrap: true,
        //   children: <Widget>[
        //     // ListTile(
        //     //   leading: Icon(Icons.music_note),
        //     //   title: Text('Music'),
        //     //   onTap: () {},
        //     // ),
        //     // ListTile(
        //     //   leading: Icon(Icons.videocam),
        //     //   title: Text('Video'),
        //     //   onTap: () {},
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
