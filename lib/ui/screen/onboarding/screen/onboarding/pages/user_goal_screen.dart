import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/ui/screen/onboarding/model/goal.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserGoalScreen extends StatefulWidget {
  final Function(List<Goal>) onNext;

  UserGoalScreen({@required this.onNext});

  @override
  _UserGoalScreenState createState() => _UserGoalScreenState();
}

class _UserGoalScreenState extends State<UserGoalScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  List<Goal> _selectedGoals = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_goal_screen_title, style: title30, textAlign: TextAlign.left),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedItemPicker(
                axis: Axis.vertical,
                itemCount: Goal.values.length,
                multipleSelection: true,
                maxItemSelectionCount: 2,
                onItemPicked: (index, selected) {
                  if (selected) {
                    _selectedGoals.add(Goal.values[index]);
                  } else {
                    _selectedGoals.remove(Goal.values[index]);
                  }
                  setState(() {});
                },
                itemBuilder: (index, animatedValue) {
                  return _buildReasonItem(Goal.values[index], animatedValue);
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
                      widget.onNext(_selectedGoals);
                    }
                  });
                },
                isEnabled: _selectedGoals.isNotEmpty),
          )
        ]));
  }

  Widget _buildReasonItem(Goal goal, double animValue) {
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
            SizedBox(width: 6),
            Container(
              width: 40,
              height: 40,
              child: Text(goal.getIcon(),
                  style: title14.copyWith(
                      color: AppColorScheme.colorBlack10, fontSize: 35, overflow: TextOverflow.visible),
                  textAlign: TextAlign.center),
            ),
            SizedBox(width: 16),
            Text(goal.getTitle(context),
                style: title14.copyWith(color: AppColorScheme.colorBlack10), textAlign: TextAlign.center),
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
