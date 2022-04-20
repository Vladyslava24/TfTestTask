import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';

class AppBarDescriptionWidget extends StatelessWidget {
  final String? description;

  const AppBarDescriptionWidget({
    this.description,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return description != null ?
    Text(
      description!,
      style: textRegular12.copyWith(color: AppColorScheme.colorBlack7)
    ) : const SizedBox();
  }
}