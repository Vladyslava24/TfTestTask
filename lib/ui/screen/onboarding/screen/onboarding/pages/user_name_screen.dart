import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/ui/widgets/input_field_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class UserNameScreen extends StatefulWidget {
  final Function(String) onNext;

  UserNameScreen({@required this.onNext});

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  String _typedText = '';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(S.of(context).onboarding_user_name_screen_title,
              style: title30.copyWith(fontFamily: 'Gilroy'), textAlign: TextAlign.left),
        ),
      ),
      Expanded(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              inputFormatters: [AutoCapWordsInputFormatter()],
              textInputAction: TextInputAction.done,
              maxLength: 20,
              style: title30.copyWith(color: AppColorScheme.colorBlack8),
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
                widget.onNext(_typedText);
              }
            });
          },
          isEnabled: _typedText.isNotEmpty,
        ),
      )
    ]);
  }
}
