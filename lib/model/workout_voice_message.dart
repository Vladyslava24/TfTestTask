import 'package:flutter/foundation.dart';

class WorkoutVoiceMessage {
  final String fileName;

  const WorkoutVoiceMessage._({@required this.fileName});

  static const START_WORKOUT = WorkoutVoiceMessage._(fileName: "1_StartWorkout.wav");
  static const QUESTION_1 = WorkoutVoiceMessage._(fileName: "2_Question1.wav");
  static const QUESTION_2 = WorkoutVoiceMessage._(fileName: "3_Question2.wav");
  static const QUESTION_3 = WorkoutVoiceMessage._(fileName: "4_Question3.wav");
  static const WARM_UP_COMPLETE = WorkoutVoiceMessage._(fileName: "5_Warmupcomplete.wav");
  static const SKILL = WorkoutVoiceMessage._(fileName: "6_Skill.wav");
  static const SKILL_START = WorkoutVoiceMessage._(fileName: "Skill_Start.wav");
  static const SKILL_EXERCISES = WorkoutVoiceMessage._(fileName: "Skill_Exercises.wav");
  static const SKILL_ASSESS = WorkoutVoiceMessage._(fileName: "Skill_Access.wav");
  static const SKILL_COMPLETE = WorkoutVoiceMessage._(fileName: "7_Skillcomplete.wav");
  static const WOD = WorkoutVoiceMessage._(fileName: "8_WOD.wav");
  static const WOD_COMPLETE = WorkoutVoiceMessage._(fileName: "9_WODComplete.wav");
  static const COOLDOWN = WorkoutVoiceMessage._(fileName: "10_Cooldown.wav");
  static const COOLDOWN_COMPLETE = WorkoutVoiceMessage._(fileName: "11_Cooldowncomplete.wav");
  static const FINISH = WorkoutVoiceMessage._(fileName: "15_Finish.wav");
  static const FINISH_EXERCISE = WorkoutVoiceMessage._(fileName: "finish_exercise.mp3");
  static const START_EXERCISE_AFTER_DELAY = WorkoutVoiceMessage._(fileName: "start_exercise_after_delay.mp3");
  static const COUNTDOWN = WorkoutVoiceMessage._(fileName: "Countdown.mp3");
}
