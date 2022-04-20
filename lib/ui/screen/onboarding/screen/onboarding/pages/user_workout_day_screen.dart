import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/program_days_of_week.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserWorkoutDayScreen extends StatefulWidget {
  final Function(List<DayOfWeek>) onNext;

  UserWorkoutDayScreen({@required this.onNext});

  @override
  _UserWorkoutDayScreenState createState() => _UserWorkoutDayScreenState();
}

class _UserWorkoutDayScreenState extends State<UserWorkoutDayScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  List<DayOfWeek> _selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorScheme.colorPrimaryBlack,
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(S.of(context).onboarding_user_workout_day_screen_title,
                        style: title30, textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedItemPicker(
                    axis: Axis.vertical,
                    itemCount: DayOfWeek.LIST.length,
                    multipleSelection: true,
                    maxItemSelectionCount: 6,
                    onItemPicked: (index, selected) {
                      if (selected) {
                        _selectedDays.add(DayOfWeek.LIST[index]);
                      } else {
                        _selectedDays.remove(DayOfWeek.LIST[index]);
                      }
                      setState(() {});
                    },
                    itemBuilder: (index, animatedValue) {
                      return _buildDayItem(DayOfWeek.LIST[index].stringValue(context), animatedValue);
                    },
                  ),
                ),
                SizedBox(height: 80),
              ]),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: BaseElevatedButton(
              text: S.of(context).all__continue,
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(Duration(milliseconds: 100), () {
                  if (mounted) {
                    widget.onNext(_selectedDays);
                  }
                });
              },
              isEnabled: _selectedDays.isNotEmpty,
            ))
        ],
      ),
    );
  }

  Widget _buildDayItem(String level, double animValue) {
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
