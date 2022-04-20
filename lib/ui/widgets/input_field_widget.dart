import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/ui_kit.dart';

class InputField extends StatelessWidget {
  final String errorMessage;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function onEditingCompleted;
  final Function onClearError;
  final String label;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final Widget suffixIcon;
  final EdgeInsets padding;
  final bool dynamicLabel;
  final TextStyle hintStyle;
  final TextStyle labelStyle;

  InputField(
      {this.errorMessage,
      this.focusNode,
      this.nextFocusNode,
      this.textEditingController,
      this.keyboardType,
      this.onChanged,
      this.onEditingCompleted,
      this.onClearError,
      this.label,
      this.obscureText = false,
      this.inputFormatters,
      this.suffixIcon,
      this.padding =
          const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
      this.dynamicLabel = false,
      this.hintStyle =
          const TextStyle(fontSize: 16.0, color: AppColorScheme.colorBlack7),
      this.labelStyle =
          const TextStyle(fontSize: 16.0, color: AppColorScheme.colorBlack7)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        alignment: Alignment.centerLeft,
        child: TextFormField(
          inputFormatters: inputFormatters,
          textInputAction: nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          focusNode: focusNode,
          style: textRegular16.copyWith(color: AppColorScheme.colorBlack9),
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: !dynamicLabel ? label : null,
            labelText: dynamicLabel ? label : null,
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            errorText: _setErrorText(),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColorScheme.colorRed)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorScheme.colorBlack7),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorScheme.colorYellow),
            ),
            suffixIcon: suffixIcon,
          ),
          onFieldSubmitted: (v) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          onChanged: (text) {
            if (errorMessage != null && errorMessage.isNotEmpty) {
              onClearError();
            }
            onChanged(text);
          },
          onEditingComplete: () => onEditingCompleted(),
        ),
      ),
    );
  }

  String _setErrorText() {
    return errorMessage != null && errorMessage.isNotEmpty
        ? errorMessage
        : null;
  }
}

class AutoCapWordsInputFormatter extends TextInputFormatter {
  final RegExp capWordsPattern = new RegExp(r'(\w)(\w*\s*)');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = capWordsPattern
        .allMatches(newValue.text)
        .map((match) => match.group(1).toUpperCase() + match.group(2))
        .join();
    return new TextEditingValue(
      text: newText,
      selection:
          newValue.selection ?? const TextSelection.collapsed(offset: -1),
      composing:
          newText == newValue.text ? newValue.composing : TextRange.empty,
    );
  }
}

enum InputFieldType {
  FIRST_NAME,
  LAST_NAME,
  BIRTH_DAY,
  COUNTRY,
  EMAIL,
  PASSWORD
}
