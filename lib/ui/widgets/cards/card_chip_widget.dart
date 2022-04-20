
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';


class CardChipWidget extends StatelessWidget {
  static const String separator = '•';

  final String label;
  final EdgeInsets margin;
  final bool withSeparator;

  const CardChipWidget({
    this.label,
    this.margin = const EdgeInsets.only(right: 2.0),
    this.withSeparator = true,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2.0),
      child: Text(
        '${label.toUpperCase()} ${withSeparator ? separator : ''}',
        style: textRegular12,
      ),
    );
  }
}
