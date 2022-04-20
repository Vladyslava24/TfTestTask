import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BaseTransparentButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final double size;

  const BaseTransparentButton({
    required this.iconData,
    required this.text,
    required this.onTap,
    this.size = 24,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColorScheme.colorBlack10.withOpacity(0.1),
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(
              top: 14.0, bottom: 14.0, right: 12.0, left: 12.0),
            color: AppColorScheme.colorBlack2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  size: size,
                  color: AppColorScheme.colorPrimaryWhite,
                ),
                const SizedBox(width: 8.0),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: title14.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
