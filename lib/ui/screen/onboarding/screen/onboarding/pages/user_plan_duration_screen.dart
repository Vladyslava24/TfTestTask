import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserPlanDurationScreen extends StatefulWidget {
  final Function(int) onNext;

  UserPlanDurationScreen({@required this.onNext});

  @override
  _UserPlanDurationScreenState createState() => _UserPlanDurationScreenState();
}

class _UserPlanDurationScreenState extends State<UserPlanDurationScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  ///values: 2, 4, 6
  int _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_plan_duration_screen_title,
                  style: title30, textAlign: TextAlign.left),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedItemPicker(
                axis: Axis.vertical,
                itemCount: durations.length,
                onItemPicked: (index, selected) {
                  setState(() {
                    ///values: 2, 4, 6
                    _selectedDuration = (index + 1) * 2;
                  });
                },
                itemBuilder: (index, animatedValue) {
                  return _buildDurationItem(durations[index](context), animatedValue);
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: BaseElevatedButton(
              text: S.of(context).all__continue,
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(Duration(milliseconds: 100), () {
                  if (mounted) {
                    widget.onNext(_selectedDuration);
                  }
                });
              },
              isEnabled: _selectedDuration != null,
            ),
          )
        ]));
  }

  Widget _buildDurationItem(String level, double animValue) {
    return Container(
        height: 64,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _itemBackgroundColorTween.transform(animValue)),
            color: AppColorScheme.colorBlack4,
            shape: BoxShape.rectangle),
        child: Row(
          children: [
            SizedBox(width: 16),
            Text(level, style: title14.copyWith(color: AppColorScheme.colorBlack10), textAlign: TextAlign.center),
            Expanded(child: Container()),
            Opacity(
              opacity: animValue,
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: new BoxDecoration(
                      color: AppColorScheme.colorYellow,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      shape: BoxShape.rectangle),
                  child: Icon(Icons.done, size: 20, color: AppColorScheme.colorBlack4)),
            ),
            SizedBox(width: 8)
          ],
        ));
  }
}

final durations = [
  (BuildContext c) => S.of(c).user_duration_1,
  (BuildContext c) => S.of(c).user_duration_2,
  (BuildContext c) => S.of(c).user_duration_3
];
