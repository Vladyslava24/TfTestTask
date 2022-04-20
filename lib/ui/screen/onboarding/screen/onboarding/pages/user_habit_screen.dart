import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserHabitScreen extends StatefulWidget {
  final Function(List<String>) onNext;

  UserHabitScreen({@required this.onNext});

  @override
  _UserHabitScreenState createState() => _UserHabitScreenState();
}

class _UserHabitScreenState extends State<UserHabitScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  static ColorTween _itemBorderColorTween = ColorTween(
    begin: AppColorScheme.colorBlack8,
    end: AppColorScheme.colorYellow,
  );

  Set<String> _selectedHabits = {};

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
                      child: Text(S.of(context).onboarding_user_habit_screen_subtitle,
                          style: title30, textAlign: TextAlign.left),
                    ),
                  ),
                  SizedBox(height: 24),
                  AnimatedItemPicker(
                    axis: Axis.vertical,
                    itemCount: habits.length,
                    maxItemSelectionCount: 3,
                    multipleSelection: true,
                    onItemPicked: (index, selected) {
                      if (selected) {
                        _selectedHabits.add(habits[index].serverId);
                      } else {
                        _selectedHabits.remove(habits[index].serverId);
                      }
                      setState(() {});
                    },
                    itemBuilder: (index, animatedValue) {
                      return _buildHabitItem(habits[index].habit(context), index, animatedValue);
                    },
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
                        widget.onNext(_selectedHabits.toList());
                      }
                    });
                  },
                  isEnabled: _selectedHabits.isNotEmpty,
                ))
          ],
        ));
  }

  Widget _buildHabitItem(String habit, int index, double animValue) {
    return Container(
        height: 64,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _itemBackgroundColorTween.transform(animValue)),
            color: AppColorScheme.colorBlack4,
            shape: BoxShape.rectangle),
        child: Row(
          children: [
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: _itemBackgroundColorTween.transform(animValue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: _itemBorderColorTween.transform(animValue)),
                    shape: BoxShape.rectangle),
                child: Icon(Icons.done, size: 19, color: AppColorScheme.colorBlack2)),
            SizedBox(width: 12),
            Expanded(
                child: Text(habit,
                    style: title14.copyWith(color: AppColorScheme.colorBlack10), textAlign: TextAlign.left)),
          ],
        ));
  }
}

final habits = [
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_1, '13'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_2, '12'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_3, '14'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_4, '30'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_5, '6'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_6, '18'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_7, '16'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_8, '32'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_9, '15'),
  _Habit((BuildContext c) => S.of(c).onboarding_user_habit_screen_habit_10, '10'),
];

class _Habit {
  final String Function(BuildContext) habit;
  final String serverId;

  _Habit(this.habit, this.serverId);
}
