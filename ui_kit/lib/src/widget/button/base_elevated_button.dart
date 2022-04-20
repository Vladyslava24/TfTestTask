import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kit/src/theme/themes.dart';
import 'package:ui_kit/ui_kit.dart';

class BaseElevatedButton extends StatelessWidget {
  final String text;
  final bool textIsUppercase;
  final Color textColor;
  final EdgeInsets padding;
  final Function onPressed;
  final String? image;
  final IconData? icon;
  final double iconSize;
  final Color iconColor;
  final String fontFamily;
  final Color backgroundColor;
  final double iconSpace;
  final bool isEnabled;
  final double height;
  final double width;

  BaseElevatedButton({
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.all(0.0),
    this.icon,
    this.image,
    this.textColor = AppColorScheme.colorBlack,
    this.fontFamily = 'Gilroy',
    this.iconSize = 19.0,
    this.iconColor = AppColorScheme.colorPrimaryBlack,
    this.iconSpace = 4.0,
    this.isEnabled = true,
    this.height = 48,
    this.width = double.infinity,
    this.textIsUppercase = false,
    this.backgroundColor = AppColorScheme.colorYellow,
    Key? key,
  }) : super(key: key) {
    if (icon != null && image != null) {
      throw ('Icon and Image can\'t be provided simultaneously');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)))),
        onPressed: isEnabled ? () => onPressed() : null,
        child: SizedBox(
          width: width,
          height: height,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon != null ? Icon(icon, size: iconSize, color: iconColor) : const SizedBox.shrink(),
        image != null ? _imageWidget() : const SizedBox.shrink(),
        SizedBox(width: icon != null || image != null ? iconSpace : 0),
        Center(
          child: Text(
            textIsUppercase ? text.toUpperCase() : text,
            style: Theme.of(context)
              .elevatedButtonTheme
              .style!
              .textStyle!
              .resolve(_interactiveStates)!
              .copyWith(color: textColor, fontFamily: fontFamily),
          ),
        ),
      ],
    );
  }

  _imageWidget() {
    if (image!.endsWith('svg')) {
      return SvgPicture.asset(image!, height: 20);
    } else {
      return TfImage(url: image!, height: 20, fit: BoxFit.fitWidth, background: Colors.transparent);
    }
  }
}

const Set<MaterialState> _interactiveStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.hovered,
  MaterialState.focused,
};
