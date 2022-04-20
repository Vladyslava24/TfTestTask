import 'package:flutter/material.dart';
import 'package:mood_ui/src/utils/ui_utils.dart';
import 'package:ui_kit/ui_kit.dart';

class SelectionItemWidget extends StatelessWidget {
  final Function onSelect;
  final String emoji;
  final String text;

  const SelectionItemWidget({
    required this.emoji,
    required this.text,
    required this.onSelect,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(),
      borderRadius: BorderRadius.circular(cardBorderRadius),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          color: AppColorScheme.colorBlack2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getEmoji(emoji), style: const TextStyle(fontSize: 38.0)),
            const SizedBox(height: 4.0),
            Text(
              text,
              style: textRegular16
                .copyWith(color: AppColorScheme.colorPrimaryWhite)
            )
          ],
        ),
      ),
    );
  }
}
