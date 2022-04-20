import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String? title;

  const AppBarTitleWidget({ this.title, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title != null ? Text(
      title!,
      style: Theme.of(context).appBarTheme.titleTextStyle
    ) : const SizedBox();
  }
}