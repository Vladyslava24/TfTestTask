import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BaseRadioWidget extends StatefulWidget {
  final String label;
  final int value;
  final int groupValue;
  final double size;
  final Function(int) onChange;
  final EdgeInsets margin;

  const BaseRadioWidget({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChange,
    this.size = 24.0,
    this.margin = EdgeInsets.zero,
    Key? key
  }) : super(key: key);

  @override
  _BaseRadioWidgetState createState() => _BaseRadioWidgetState();
}

class _BaseRadioWidgetState extends State<BaseRadioWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onChange(widget.value);
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
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: Radio(
                groupValue: widget.groupValue,
                value: widget.value,
                fillColor: MaterialStateProperty.all(
                  widget.groupValue == widget.value ?
                    AppColorScheme.colorYellow : AppColorScheme.colorBlack5
                ),
                activeColor: AppColorScheme.colorYellow,
                onChanged: (value) {
                  setState(() {
                    widget.onChange(value as int);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
