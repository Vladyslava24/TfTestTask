import 'package:flutter/cupertino.dart';

extension TextControllerExtension on TextEditingController {
  updateText(String text) {
    value = value.copyWith(text: text, selection: TextSelection.fromPosition(TextPosition(offset: text.length)));
  }
}