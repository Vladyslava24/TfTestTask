import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/common/extension.dart';
import 'package:workout_use_case/use_case.dart';

class ExerciseItemWidget extends StatelessWidget {
  final ExerciseModel exercise;

  const ExerciseItemWidget({required this.exercise, Key? key}) :
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: TfImage(
              url: exercise.image,
              width: 80,
              height: 80
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        exercise.name,
                        style: title14.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    exercise.getMetricQuantity(),
                    style: textMedium12.copyWith(
                      color: AppColorScheme.colorBlack7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}