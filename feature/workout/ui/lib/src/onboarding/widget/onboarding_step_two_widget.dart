import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/indicator/exercise_progress_indicator.dart';
import 'package:workout_ui/src/onboarding/widget/fake_progress_indicator_widget.dart';

class OnBoardingStepTwoWidget extends StatelessWidget {
  final String textButton;
  final String time;
  final String advice;

  const OnBoardingStepTwoWidget({
    required this.textButton,
    required this.time,
    required this.advice,
    Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 24.0,
          right: 0.0,
          child: SafeArea(
            child: BaseTextButton(
              text: textButton,
              textColor: AppColorScheme.colorPrimaryWhite,
              arrowColor: AppColorScheme.colorPrimaryWhite,
              withArrow: true
            ),
          ),
        ),
        Positioned(
          top: 36.0,
          left: 16.0,
          child: SafeArea(
            child: Row(
              children: [
                const Icon(
                  Icons.pause,
                  color: AppColorScheme.colorPrimaryWhite,
                  size: 24,
                ),
                const SizedBox(width: 8.0),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColorScheme.colorPrimaryWhite,
                    fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: AppColorScheme.colorPrimaryBlack.withOpacity(.5)
            ),
          ),
        ),
        const Positioned(
          bottom: 16.0,
          left: 16.0,
          child: SafeArea(
            child: Icon(
              PlaybackIcons.tutorial,
              color: AppColorScheme.colorPrimaryWhite, size: 18.0
            ),
          ),
        ),
        Positioned(
          bottom: 70.0,
          left: 16.0,
          child: SafeArea(
            child: Text(
              advice,
              style: textRegular16.copyWith(
                color: AppColorScheme.colorPrimaryWhite),
            ),
          ),
        ),
      ],
    );
  }
}
