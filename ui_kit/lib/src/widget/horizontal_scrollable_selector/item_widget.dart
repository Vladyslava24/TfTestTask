import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final double width;
  final double scale;
  final Widget child;

  const ItemWidget(
      {Key? key,
      required this.child,
      required this.onTap,
      required this.scale,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(4),
        child: Transform.scale(
          scale: scale,
          child: child,
        ),
      ),
    );
  }
}
