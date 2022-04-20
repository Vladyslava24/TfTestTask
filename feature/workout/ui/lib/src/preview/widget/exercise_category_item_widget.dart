import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/common/extension.dart';
import 'package:workout_ui/src/preview/widget/exercise_category_header_widget.dart';
import 'package:workout_ui/src/preview/widget/exercise_item_widget.dart';
import 'package:workout_use_case/use_case.dart';

class ExerciseCategoryItemWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<ExerciseModel> exercises;

  final Function(ExerciseModel) onExerciseSelected;

  const ExerciseCategoryItemWidget({
    required this.title,
    required this.subTitle,
    required this.exercises,
    required this.onExerciseSelected,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetList = <Widget>[
      ExerciseCategoryHeaderWidget(title: title, subTitle: subTitle),
      const SizedBox(height: 16.0),
      ...exercises.map((e) => ExerciseItemWidget(exercise: e)).toList()
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: AppColorScheme.colorPrimaryWhite,
        accentColor: AppColorScheme.colorPrimaryWhite
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            color: AppColorScheme.colorBlack,
            child: Column(children: widgetList),
          ),
        ),
      ),
    );
  }
}
