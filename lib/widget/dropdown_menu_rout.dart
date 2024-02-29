import 'package:flutter/material.dart';

class DropDownMenuRoute extends PopupRoute {
  final Widget child;
  final Rect position;

  DropDownMenuRoute({required this.child, required this.position});

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => "";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: position.top,
              left: 0.0,
              width: constraints.maxWidth,
              child: child,
            ),
          ],
        );
      },
    );
  }
}
