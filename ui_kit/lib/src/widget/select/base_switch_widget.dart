import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/styles.dart';

class BaseSwitchWidget extends StatefulWidget {
  final String label;
  final bool value;
  final Function(bool) onChange;
  final EdgeInsets margin;

  const BaseSwitchWidget({
    required this.label,
    required this.value,
    required this.onChange,
    this.margin = EdgeInsets.zero,
    Key? key
  }) : super(key: key);

  @override
  _BaseSwitchWidgetState createState() => _BaseSwitchWidgetState();
}

class _BaseSwitchWidgetState extends State<BaseSwitchWidget> {

  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
  }
  
  void _switch(value) {
    setState(() {
      _selected = !_selected;
    });
    widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _switch,
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
            FlutterSwitch(
              width: 40.0,
              height: 24.0,
              valueFontSize: 20.0,
              toggleSize: 20.0,
              padding: 2,
              inactiveColor: AppColorScheme.colorBlack6,
              activeColor: AppColorScheme.colorYellow,
              activeToggleColor: AppColorScheme.colorBlack,
              inactiveToggleColor: AppColorScheme.colorBlack,
              value: _selected,
              onToggle: (value) => _switch(value)
            ),
          ],
        ),
      ),
    );
  }
}
