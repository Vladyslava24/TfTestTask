import 'package:flutter/material.dart';
import 'package:mood_ui/src/utils/ui_utils.dart';
import 'package:ui_kit/ui_kit.dart';

class MoodReasonSelectionItem extends StatefulWidget {
  final int id;
  final String emoji;
  final String text;
  final bool selected;
  final Function onChange;
  final EdgeInsets margin;
  
  const MoodReasonSelectionItem({
    required this.id,
    required this.emoji,
    required this.text,
    required this.onChange,
    this.selected = false,
    this.margin = const EdgeInsets.only(right: 8.0, bottom: 16.0),
    Key? key
  }) : super(key: key);

  @override
  State<MoodReasonSelectionItem> createState() => _MoodReasonSelectionItemState();
}

class _MoodReasonSelectionItemState extends State<MoodReasonSelectionItem> {

  double _padding = 12.0;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _padding = 10.0;

        });
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() {
          _padding = 12.0;
        });
        await widget.onChange(widget.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(_padding),
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: widget.selected ?
            AppColorScheme.colorBlack4 : AppColorScheme.colorBlack2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(getEmoji(widget.emoji)),
            const SizedBox(width: 4.0),
            Text(
              widget.text,
              style: textRegular16.copyWith(
                color: AppColorScheme.colorPrimaryWhite
              )
            ),
          ],
        ),
      ),
    );
  }
}
