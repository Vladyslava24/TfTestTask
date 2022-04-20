import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

class ExercisesItemWidget extends StatelessWidget {
  static const double itemPaddingTop = 20;
  static const double itemPaddingBottom = 10;
  static const double imageSize = 80;
  static const double itemHeight =
      imageSize + itemPaddingTop + itemPaddingBottom;

  const ExercisesItemWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.duration,
  }) : super(key: key);
  final String image;
  final String name;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20, top: itemPaddingTop, bottom: itemPaddingBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                child: TfImage(
                  url: image,
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: textRegular16,
                    ),
                    Text(
                      duration,
                      style: textRegular14.copyWith(
                          color: AppColorScheme.colorBlack8),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
