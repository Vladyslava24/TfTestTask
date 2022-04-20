import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'footer_tile.dart';

class NewPageErrorIndicator extends StatelessWidget {
  final VoidCallback onTap;
  final String errorTitle;
  final String errorMessage;

  const NewPageErrorIndicator({
    Key key,
    this.onTap,
    this.errorTitle,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: FooterTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorTitle,
                textAlign: TextAlign.center,
                style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
              ),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
              ),
              const SizedBox(
                height: 4,
              ),
              const Icon(
                Icons.refresh,
                size: 16,
              ),
            ],
          ),
        ),
      );
}
