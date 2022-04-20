import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/styles.dart';

class BaseCheckBoxWidget extends StatefulWidget {
  final String label;
  final bool value;
  final Function(bool) onChange;
  final EdgeInsets margin;

  const BaseCheckBoxWidget({
    required this.label,
    required this.value,
    required this.onChange,
    this.margin = EdgeInsets.zero,
    Key? key
  }) : super(key: key);

  @override
  _BaseCheckBoxWidgetState createState() => _BaseCheckBoxWidgetState();
}

class _BaseCheckBoxWidgetState extends State<BaseCheckBoxWidget> {

  static const size = 24.0;

  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          widget.onChange(selected);
        });
      },
      child: Container(
        margin: widget.margin,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite),
              ),
            ),
            AnimatedContainer(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: selected ?
                AppColorScheme.colorYellow : AppColorScheme.colorBlack4,
                shape: BoxShape.circle
              ),
              child: selected ? const Icon(
                Icons.done,
                color: AppColorScheme.colorBlack2,
              ) : null
            ),
          ],
        ),
      ),
    );
  }
}
