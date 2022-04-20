import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:core/generated/l10n.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserLevelScreen extends StatefulWidget {
  final Function(LevelType) onNext;

  UserLevelScreen({@required this.onNext});

  @override
  _UserLevelScreenState createState() => _UserLevelScreenState();
}

class _UserLevelScreenState extends State<UserLevelScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  LevelType _selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_level_screen_title, style: title30, textAlign: TextAlign.left),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedItemPicker(
                axis: Axis.vertical,
                itemCount: levels.length,
                onItemPicked: (index, selected) {
                  setState(() {
                    _selectedLevel = LevelType.LIST[index];
                  });
                },
                itemBuilder: (index, animatedValue) {
                  return _buildLevelItem(levels[index](context), animatedValue);
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
                    widget.onNext(_selectedLevel);
                  }
                });
              },
              isEnabled: _selectedLevel != null,
            ),
          )
        ]));
  }

  Widget _buildLevelItem(String level, double animValue) {
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

final levels = [
  (BuildContext c) => S.of(c).user_level_1,
  (BuildContext c) => S.of(c).user_level_2,
  (BuildContext c) => S.of(c).user_level_3
];
