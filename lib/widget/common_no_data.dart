import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/style_util.dart';

class CommonNoData extends StatelessWidget {


  const CommonNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  Widget _buildAppBar(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Image.asset(
            "images/ic_no_data.webp",
            height: 100.w,
            width: 100.w,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "暂无数据",
            style: StyleUtils.mTextStyle(14, 0xff999999),
          )
        ],
      ),
    );
  }

}

