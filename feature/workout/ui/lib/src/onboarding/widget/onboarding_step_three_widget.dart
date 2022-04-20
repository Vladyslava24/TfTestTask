import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/indicator/exercise_progress_indicator.dart';
import 'package:workout_ui/src/onboarding/widget/fake_progress_indicator_widget.dart';

class OnBoardingStepThreeWidget extends StatelessWidget {
  final String textButton;
  final String time;
  final String advice1;
  final String advice2;

  const OnBoardingStepThreeWidget({
    required this.textButton,
    required this.time,
    required this.advice1,
    required this.advice2,
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
                  style: TextStyle(
                    color: AppColorScheme.colorPrimaryWhite,
                    fontSize: 16.0
                  ),
                ),
              ],
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
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: AppColorScheme.colorPrimaryBlack.withOpacity(.5)
            ),
          ),
        ),
        Positioned(
          top: 150.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Icon(
                        OnboardingIcons.onboarding_arrow_left,
                        color: AppColorScheme.colorPrimaryWhite
                      ),
                      Container(height: 24.0),
                      Text(
                        advice1,
                        textAlign: TextAlign.center,
                        style: textRegular16.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.65,
                  width: 2.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Icon(
                        OnboardingIcons.onboarding_arrow_right,
                        color: AppColorScheme.colorPrimaryWhite
                      ),
                      Container(height: 24.0),
                      Text(
                        advice2,
                        textAlign: TextAlign.center,
                        style: textRegular16.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
