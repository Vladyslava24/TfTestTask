import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

class EmptyWidget extends StatelessWidget {
  final String text;

  const EmptyWidget({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite)
      )
    );
  }
}
