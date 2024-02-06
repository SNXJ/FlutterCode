import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///自定义下划线
class CustomIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter();
  }
}

class _CustomPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = Colors.deepOrangeAccent;
    paint.style = PaintingStyle.fill;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx + configuration.size!.width / 4 + 8.w,
        configuration.size!.height - 8.h,
        18.0.w,
        4.0.w,
      ),
      const Radius.circular(4.0).r,
    );
    canvas.drawRRect(rrect, paint);
  }
}
