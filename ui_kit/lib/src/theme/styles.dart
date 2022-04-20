import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';

TextStyle _text = const TextStyle(
  fontStyle: FontStyle.normal,
  color: AppColorScheme.colorPrimaryWhite,
  fontFamily: 'Roboto'
);

TextStyle _title = const TextStyle(
  fontStyle: FontStyle.normal,
  color: AppColorScheme.colorPrimaryWhite,
  fontWeight: FontWeight.w700,
  fontFamily: 'Gilroy'
);

// Regular text
final textRegular = _text.copyWith(fontWeight: FontWeight.w400);
//используется для полиси
final textRegular9 = textRegular.copyWith(fontSize: 9.0);
final textRegular10 = textRegular.copyWith(fontSize: 10.0);
final textRegular12 = textRegular.copyWith(fontSize: 12.0);
final textRegular14 = textRegular.copyWith(fontSize: 14.0);
final textRegular16 = textRegular.copyWith(fontSize: 16.0);
final textRegular20 = textRegular.copyWith(fontSize: 20.0);

final textMedium = _text.copyWith(fontWeight: FontWeight.w500);
final textMedium12 = textRegular.copyWith(fontSize: 12.0);

final _textBold = _text.copyWith(fontWeight: FontWeight.w700);
final textBold16 = _textBold.copyWith(fontSize: 16.0);

// ExtraBoldItalic text
//цифра обратного отсчета
final textExtraBoldItalic = _text.copyWith(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic);
final textExtraBoldItalic288 = textExtraBoldItalic.copyWith(fontSize: 288.0);

// Gilroy Bold text
final title14 = _title.copyWith(fontSize: 14.0);
final title16 = _title.copyWith(fontSize: 16.0);
final title20 = _title.copyWith(fontSize: 20.0);
final title30 = _title.copyWith(fontSize: 30.0);
final title40 = _title.copyWith(fontSize: 40.0);
final title42 = _title.copyWith(fontSize: 42.0);
final title64 = _title.copyWith(fontSize: 64.0);

