import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

class SkipButtonWidget extends StatelessWidget {
  final VoidCallback startWorkout;
  final String skipButtonText;
  final double size;

  const SkipButtonWidget({
    required this.startWorkout,
    required this.skipButtonText,
    this.size = 60.0,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startWorkout,
      child: SafeArea(
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: AppColorScheme.colorYellow,
            shape: BoxShape.circle
          ),
          child: Center(
            child: Text(
              skipButtonText,
              style: title16.copyWith(
                color: AppColorScheme.colorBlack2),
            ),
          ),
        ),
      ),
    );
  }
}
