import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BaseCheckBoxRoundedWidget extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final double size;
  final double sizeBox;
  final EdgeInsets margin;

  const BaseCheckBoxRoundedWidget(
      {@required this.onChanged,
      this.value = false,
      this.size = 24.0,
      this.sizeBox = 24.0,
      this.margin = const EdgeInsets.all(0.0)});
  @override
  _BaseCheckBoxRoundedWidgetState createState() =>
      _BaseCheckBoxRoundedWidgetState();
}

class _BaseCheckBoxRoundedWidgetState extends State<BaseCheckBoxRoundedWidget> {
  bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseCheckBoxRoundedWidget oldWidget) {
    _value = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged(_value);
      },
      child: Container(
        width: widget.sizeBox,
        height: widget.sizeBox,
        margin: widget.margin,
        child: _value
            ? Icon(
                Icons.check_box,
                size: widget.size,
                color: AppColorScheme.colorYellow,
              )
            : Icon(
                Icons.check_box_outline_blank,
                size: widget.size,
                color: AppColorScheme.colorBlack9,
              ),
      ),
    );
  }
}
