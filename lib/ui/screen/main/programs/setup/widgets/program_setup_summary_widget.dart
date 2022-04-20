import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramSetupSummaryWidget extends StatelessWidget {
  final bool isEditable;
  final String title;
  final String value;

  ProgramSetupSummaryWidget({
    this.isEditable = false,
    @required this.title,
    @required this.value,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: textRegular10.copyWith(
                    color: AppColorScheme.colorBlack7,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  style: textRegular16.copyWith(
                    color: isEditable
                        ? AppColorScheme.colorPrimaryWhite
                        : AppColorScheme.colorBlack7,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: isEditable
                  ? AppColorScheme.colorYellow
                  : AppColorScheme.colorBlack7,
              height: 1,
            ),
          ],
        ),
      );
}
