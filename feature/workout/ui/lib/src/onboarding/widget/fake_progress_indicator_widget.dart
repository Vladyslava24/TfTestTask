import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/indicator/exercise_progress_indicator.dart';

class FakeProgressIndicatorWidget extends StatelessWidget {
  const FakeProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 30.0,
            child: ExerciseProgressIndicator(
              type: IndicatorType.linear,
              segmentCount: 20,
              selectedSegment: 4,
              rests: [5, 10, 15],
            ),
          ),
          Positioned(
            child: Container(
              height: 20.0,
              color: AppColorScheme.colorPrimaryBlack.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
