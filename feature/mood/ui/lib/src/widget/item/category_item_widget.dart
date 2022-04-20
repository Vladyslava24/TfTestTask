import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CategoryItemWidget extends StatelessWidget {
  final Function onSelect;
  final String image;
  final String text;
  final Color color;

  const CategoryItemWidget({
    required this.onSelect,
    required this.image,
    required this.text,
    required this.color,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(),
      borderRadius: BorderRadius.circular(cardBorderRadius),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          color: AppColorScheme.colorBlack2,
          gradient: RadialGradient(
            radius: cardBorderRadius,
            center: const Alignment(0.0, -.9),
            colors: <Color>[
              color,
              color.withOpacity(0),
              AppColorScheme.colorBlack2.withOpacity(0.5),
            ],
            stops: const <double>[0.0, .125, 0.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TfImage(
              url: image,
              background: Colors.transparent,
              width: 124.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              text,
              style: title14.copyWith(color: AppColorScheme.colorPrimaryWhite)
            ),
          ],
        ),
      ),
    );
  }
}
