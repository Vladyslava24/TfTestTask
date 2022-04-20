import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ui_kit/ui_kit.dart';

class NotificationsPermissionWidget extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const NotificationsPermissionWidget({
    @required this.title,
    @required this.value,
    @required this.onChanged,
    Key key
  }) : super(key: key);

  @override
  _NotificationsPermissionWidgetState createState() =>
      _NotificationsPermissionWidgetState();
}

class _NotificationsPermissionWidgetState extends
State<NotificationsPermissionWidget> {
  bool _permission;

  @override
  void initState() {
    _permission = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NotificationsPermissionWidget oldWidget) {
    _permission = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _permission = !_permission;
        });
        widget.onChanged(_permission);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        color: AppColorScheme.colorBlack2,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
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
              value: _permission,
              onToggle: (value) {
                setState(() {
                  _permission = value;
                });
                widget.onChanged(value);
              }
            )
          ],
        ),
      ),
    );
  }
}