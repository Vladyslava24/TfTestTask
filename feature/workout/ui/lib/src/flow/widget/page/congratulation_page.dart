import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CongratulationPage extends StatefulWidget {
  final VoidCallback watchResult;
  final String title;
  final String subTitle;
  final String actionBtnText;

  const CongratulationPage({
    required this.watchResult,
    this.title = '',
    this.subTitle = '',
    this.actionBtnText = '',
    Key? key,
    model
  }) : super(key: key);

  @override
  State<CongratulationPage> createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage> {
  ConfettiController _controller = ConfettiController();
  final Vibrator _vibrator = DependencyProvider.get<Vibrator>();

  @override
  void initState() {
    super.initState();
    _controller =
        ConfettiController(duration: const Duration(seconds: 10));
    _controller.addListener(() {
      setState(() {});
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        _controller.play();
        _vibrator.vibrate();
      }
    });
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorScheme.colorBlack,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                blastDirection: pi / 2,
                minBlastForce: 2,
                gravity: 0.1,
                // set a lower min blast force
                emissionFrequency: 0.05,
                numberOfParticles: 10,
                shouldLoop: true,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/trophy.svg',

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.title,
                      style: title30,
                    ),
                    Text(
                      widget.subTitle,
                      textAlign: TextAlign.center,
                      style: textRegular16.copyWith(
                        color: AppColorScheme.colorBlack7),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BaseElevatedButton(
                padding: const EdgeInsets.all(16),
                text: widget.actionBtnText,
                onPressed: widget.watchResult,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
