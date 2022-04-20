import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/generated/l10n.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class UserHeightScreen extends StatefulWidget {
  final Function(int, String) onNext;

  UserHeightScreen({@required this.onNext});

  @override
  _UserHeightScreenState createState() => _UserHeightScreenState();
}

class _UserHeightScreenState extends State<UserHeightScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  static ColorTween _itemTextColorTween = ColorTween(
    begin: AppColorScheme.colorPrimaryWhite,
    end: AppColorScheme.colorPrimaryBlack,
  );

  String _typedText = '';

  static const _measures = ['ft', 'cm'];
  static const _defaultMetricIndex = 1;
  String _preferredHeightMetric = _measures[_defaultMetricIndex];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_height_screen_title,
                  style: title30.copyWith(fontFamily: 'Gilroy'), textAlign: TextAlign.left),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 176,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColorScheme.colorBlack2,
                      shape: BoxShape.rectangle),
                  padding: EdgeInsets.all(6),
                  child: AnimatedItemPicker(
                    axis: Axis.horizontal,
                    itemCount: _measures.length,
                    expandedItems: true,
                    initialSelection: {_defaultMetricIndex},
                    onItemPicked: (index, selected) {
                      if (selected) {
                        _preferredHeightMetric = _measures[index];
                      }
                    },
                    itemBuilder: (index, animatedValue) => _ItemWidget(
                      backgroundColor: _itemBackgroundColorTween.transform(animatedValue),
                      textColor: _itemTextColorTween.transform(animatedValue),
                      name: _measures[index],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  width: 160,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    style: title30.copyWith(color: AppColorScheme.colorBlack8),
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorRed)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorBlack7)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorYellow)),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _typedText = text;
                      });
                    },
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: BaseElevatedButton(
              text: S.of(context).all__continue,
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(Duration(milliseconds: 100), () {
                  if (mounted) {
                    widget.onNext(int.tryParse(_typedText) ?? -1, _preferredHeightMetric);
                  }
                });
              },
              isEnabled: _typedText.isNotEmpty,
            ),
          )
        ]));
  }
}

class _ItemWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String name;

  _ItemWidget({@required this.name, @required this.textColor, @required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: backgroundColor),
            color: backgroundColor,
            shape: BoxShape.rectangle),
        child: Text(name, style: title16.copyWith(color: textColor), textAlign: TextAlign.center));
  }
}
