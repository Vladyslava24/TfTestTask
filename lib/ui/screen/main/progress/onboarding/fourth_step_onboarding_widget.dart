import 'package:flutter/material.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/body_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/hexagon_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/mind_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/shade_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/spirit_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/title_onboarding_widget.dart';

class FourthStepOnBoardingWidget extends StatelessWidget {

  final double body;
  final double mind;
  final double spirit;

  const FourthStepOnBoardingWidget({
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
            HexagonOnBoardingWidget(
              body: body,
              mind: mind,
              spirit: spirit,
            ),
          ]
        ),
        SpiritOnBoardingWidget(),
        Stack(
          children: [
            BodyOnBoardingWidget(),
            Positioned.fill(child: ShadeOnBoardingWidget()),
          ],
        ),
        Stack(
          children: [
            MindOnBoardingWidget(),
            Positioned.fill(child: ShadeOnBoardingWidget()),
          ],
        ),

      ],
    );
  }
}
