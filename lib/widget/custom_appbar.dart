import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const CustomAppBar({super.key, this.title = '', this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context, title, showBack);
  }

  AppBar _buildAppBar(BuildContext context, String mTitle, bool showBack) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                // SystemNavigator.pop();
              },
            )
          : null,
      title: Text(
        mTitle,
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
