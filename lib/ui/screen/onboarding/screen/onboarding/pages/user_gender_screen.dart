import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserGenderScreen extends StatefulWidget {
  final Function(Gender) onNext;

  UserGenderScreen({@required this.onNext});

  @override
  _UserGenderScreenState createState() => _UserGenderScreenState();
}

class _UserGenderScreenState extends State<UserGenderScreen> {
  Gender _gender;

  static ColorTween _itemTextColorTween =
      ColorTween(begin: AppColorScheme.colorPrimaryWhite, end: AppColorScheme.colorYellow);

  static ColorTween _itemBorderColorTween =
      ColorTween(begin: AppColorScheme.colorBlack2, end: AppColorScheme.colorYellow);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_gender_screen_title,
                  style: title30.copyWith(fontFamily: 'Gilroy'), textAlign: TextAlign.left),
            ),
          ),
          Expanded(child: SizedBox.shrink()),
          AnimatedItemPicker(
            axis: Axis.horizontal,
            expandedItems: true,
            itemCount: Gender.swatch.length,
            onItemPicked: (index, selected) {
              setState(() {
                _gender = Gender.swatch[index];
              });
            },
            itemBuilder: (index, animValue) => _GenderItemWidget(
              borderColor: _itemBorderColorTween.transform(animValue),
              textColor: _itemTextColorTween.transform(animValue),
              animValue: animValue,
              gender: Gender.swatch[index],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BaseElevatedButton(
              text: S.of(context).all__continue,
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(Duration(milliseconds: 100), () {
                  if (mounted) {
                    widget.onNext(_gender);
                  }
                });
              },
              isEnabled: _gender != null,
            ),
          )
        ]));
  }
}

class _GenderItemWidget extends StatelessWidget {
  final Gender gender;
  final Color borderColor;
  final Color textColor;
  final double animValue;

  _GenderItemWidget(
      {@required this.gender, @required this.borderColor, @required this.textColor, @required this.animValue});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 2.5,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: borderColor),
            color: AppColorScheme.colorBlack2,
            shape: BoxShape.rectangle),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gender == Gender.MALE ? '👨' : '👩',
                    style: title14.copyWith(fontSize: 44),
                  ),
                  SizedBox(height: 8),
                  Text(
                    gender.name,
                    style: title16.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Opacity(
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
            )
          ],
        ));
  }
}
