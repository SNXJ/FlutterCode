import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wd_store/utils/style_util.dart';

///公共确认弹窗
class CommonDialog extends StatelessWidget {
  final String title;
  final String content;
  final String leftText;
  final String rightText;
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;

  const CommonDialog({
    super.key,
    required this.title,
    required this.content,
    this.leftText = "取消",
    this.rightText = "确认",
    this.onLeftClick,
    this.onRightClick,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: const Color(0xff333333)),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: StyleUtils.mTextStyle(16.sp, 0xff666666),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            null != onLeftClick
                ? Expanded(
                    child: TextButton(
                      onPressed: onLeftClick,
                      style: StyleUtils.mButtonStyle(
                          18.sp, 0.8, Colors.deepOrangeAccent, Colors.white),
                      child: Text(leftText,
                          style: const TextStyle(color: Color(0xff666666))),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              width: (null != onLeftClick && null != onRightClick) ? 15.w : 0,
            ),
            null != onRightClick
                ? Expanded(
                    child: TextButton(
                      onPressed: onRightClick,
                      style: StyleUtils.mButtonStyle(18.sp, 0.8,
                          Colors.deepOrangeAccent, Colors.deepOrangeAccent),
                      child: Text(rightText,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
      shape:  RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)).w,
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    );
  }
}
