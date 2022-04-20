import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// Basic layout for indicating that an exception occurred.
class FirstPageExceptionIndicator extends StatelessWidget {
  const FirstPageExceptionIndicator({
    @required this.title,
    this.message,
    this.onTryAgain,
    Key key,
  })  : assert(title != null),
        super(key: key);
  final String title;
  final String message;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 16),
          child: Column(
            children: [
              Text(
                title,
                style:
                    title20.copyWith(color: AppColorScheme.colorPrimaryWhite),
              ),
              if (message != null) const SizedBox(height: 16),
              if (message != null)
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: textRegular16.copyWith(
                      color: AppColorScheme.colorPrimaryWhite),
                ),
              if (onTryAgain != null) const SizedBox(height: 48),
              if (onTryAgain != null)
                ActionButton(
                  text: S.of(context).all__retry,
                  padding: EdgeInsets.all(32),
                  onPressed: onTryAgain,
                ),
            ],
          ),
        ),
      );
}
