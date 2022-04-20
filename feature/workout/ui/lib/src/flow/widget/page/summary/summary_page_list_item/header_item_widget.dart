import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:core/core.dart' show StringX;

class HeaderItemWidget extends StatelessWidget {
  final String image;
  final String workoutName;
  final VoidCallback? onBackArrowPressed;

  const HeaderItemWidget({
    Key? key,
    required this.image,
    required this.workoutName,
    required this.onBackArrowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TfImage(
          url: image,
          width: double.infinity,
          fit: BoxFit.fitHeight,
        ),
        Positioned(
          left: 20,
          bottom: 34,
          right: 0,
          child: Text(
            workoutName.capitalize(),
            style: title42,
          ),
        ),
        onBackArrowPressed != null
            ? Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconBackWidget(
                    iconColor: AppColorScheme.colorYellow,
                    action: () => onBackArrowPressed?.call(),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 16.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColorScheme.colorBlack,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              border: Border.all(
                color: AppColorScheme.colorBlack,
                width: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
