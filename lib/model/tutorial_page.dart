import 'package:workout_data_legacy/data.dart';
import 'package:flutter/foundation.dart';

class TutorialPage {
  final Exercise exercise;
  final TutorialPageParent parent;

  TutorialPage({@required this.exercise, @required this.parent});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TutorialPage && runtimeType == other.runtimeType && exercise == other.exercise && parent == other.parent;

  @override
  int get hashCode => exercise.hashCode ^ parent.hashCode;

  factory TutorialPage.closeTutorialStub() {
    return TutorialPage(exercise: Exercise.clearStateStub(), parent: null);
  }
}

enum TutorialPageParent { PausePage, ExercisePage, SkillPage }
