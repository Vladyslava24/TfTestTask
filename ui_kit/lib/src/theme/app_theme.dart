import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/sizes.dart';
import 'package:ui_kit/src/theme/styles.dart';

ThemeData createAppTheme() {
  return ThemeData(
    disabledColor: AppColorScheme.colorBlack4,
    unselectedWidgetColor: AppColorScheme.colorBlack4,
    fontFamily: 'Roboto',
    primaryColor: AppColorScheme.colorBlue3,
    popupMenuTheme: const PopupMenuThemeData(color: AppColorScheme.colorBlack3),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        textStyle: MaterialStateProperty.all<TextStyle>(textBold16.copyWith(color: AppColorScheme.colorPrimaryBlack)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColorScheme.colorYellow.withOpacity(0.85);
            } else if (states.contains(MaterialState.disabled)) {
              return AppColorScheme.colorYellow.withOpacity(0.5);
            }
            return AppColorScheme.colorYellow; // Use the list_item's default.
          },
        ),
        elevation: MaterialStateProperty.all<double>(noElevation),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(elButtonBorderRadius),
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorScheme.colorBlack,
      backwardsCompatibility: false,
      elevation: 0.0,
      titleTextStyle: title16.copyWith(
       color: AppColorScheme.colorPrimaryWhite,
       height: 1.5
      ),
    ),
    textSelectionTheme:
      const TextSelectionThemeData(selectionHandleColor: AppColorScheme.colorBlue3),
  );
}

const TEXT_THEME = TextTheme(
  headline1: TextStyle(
    fontSize: 36.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.42,
    color: AppColorScheme.colorPrimaryWhite,
    fontFamily: "Roboto",
  ),
  button: TextStyle(
    fontSize: 14.0,
    color: AppColorScheme.colorPrimaryBlack,
    fontStyle: FontStyle.normal,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w500,
  ),
);

MaterialStateProperty elevatedButtonColor(Color color) {
  return MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed))
        return color.withOpacity(0.85);
      else if (states.contains(MaterialState.disabled)) return color.withOpacity(0.5);
      return color; // Use the list_item's default.
    },
  );
}
