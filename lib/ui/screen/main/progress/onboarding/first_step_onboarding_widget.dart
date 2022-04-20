import 'package:flutter/material.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/mind_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/shade_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/spirit_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/title_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/body_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/hexagon_onboarding_widget.dart';

class FirstStepOnBoardingWidget extends StatelessWidget {
  final double body;
  final double mind;
  final double spirit;

  const FirstStepOnBoardingWidget({
    @required this.body,
    @required this.mind,
    @required this.spirit
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              left: 16.0,
              top: 40.0,
              child: TitleOnBoardingWidget()
            ),
            Positioned.fill(child: ShadeOnBoardingWidget()),
            HexagonOnBoardingWidget(
              body: body,
              mind: mind,
              spirit: spirit,
            ),
          ]
        ),
        Stack(
          children: [
            Column(
              children: [
                BodyOnBoardingWidget(),
                MindOnBoardingWidget(),
                SpiritOnBoardingWidget()
              ],
            ),
            Positioned.fill(child: ShadeOnBoardingWidget()),
          ],
        )
      ],
    );
  }
}
