import 'package:flutter/material.dart';

import 'logo.dart';

class LogoPositioner extends StatelessWidget {
  final Widget child;

  LogoPositioner({this.child});

  @override
  Widget build(BuildContext context) {
    final paddingLeft = (MediaQuery.of(context).size.width - LOGO_WIDTH) / 2;
    final paddingTop = (MediaQuery.of(context).size.height - LOGO_HEIGHT) / 2;
    return Container(
      padding: EdgeInsets.only(left: paddingLeft, top: paddingTop),
      color: Colors.transparent,
      child: child,
    );
  }
}
