import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_weight_screen.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:totalfit/ui/screen/onboarding/model/onboarding_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

class UserDesiredWeightScreen extends StatefulWidget {
  final Function(int) onNext;

  const UserDesiredWeightScreen({@required this.onNext});

  @override
  _UserDesiredWeightScreeState createState() => _UserDesiredWeightScreeState();
}

class _UserDesiredWeightScreeState extends State<UserDesiredWeightScreen> {
  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow.withOpacity(0.5),
  );

  static ColorTween _itemTextColorTween = ColorTween(
    begin: AppColorScheme.colorYellow.withOpacity(0.5),
    end: AppColorScheme.colorPrimaryBlack,
  );

  String _typedText = '';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OnBoardingData>(context, listen: false);
    int preferredMetricIndex = weight_measures.indexOf(data.preferredWeightMetric);
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_desired_weight_screen_title,
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
                  child: AbsorbPointer(
                    child: AnimatedItemPicker(
                      key: ValueKey(preferredMetricIndex),
                      axis: Axis.horizontal,
                      itemCount: weight_measures.length,
                      expandedItems: true,
                      initialSelection: {preferredMetricIndex},
                      onItemPicked: (index, selected) {},
                      itemBuilder: (index, animatedValue) => _ItemWidget(
                        backgroundColor: _itemBackgroundColorTween.transform(animatedValue),
                        textColor: _itemTextColorTween.transform(animatedValue),
                        name: weight_measures[index],
                      ),
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
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
                    widget.onNext(int.tryParse(_typedText) ?? -1);
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
