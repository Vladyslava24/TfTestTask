


import 'workout_localizations.dart';

/// The translations for English (`en`).
class WorkoutLocalizationsEn extends WorkoutLocalizations {
  WorkoutLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get exercise_category_title_warm_up => 'Warm-up';

  @override
  String get exercise_category_title_skill => 'Skill';

  @override
  String get exercise_category_title_wod => 'Workout';

  @override
  String get exercise_category_title_cooldown => 'Stretching Session';

  @override
  String get exercise_category_title_rest => 'Rest';

  @override
  String exercise_category_subtitle_warm_up_multiple_rounds(int roundCount, int exerciseCount) {
    return '$roundCount rounds • $exerciseCount exercises';
  }

  @override
  String exercise_category_subtitle_warm_up(int count) {
    return '$count exercises';
  }

  @override
  String exercise_category_subtitle_wod(String wodType, int quantity, String metrics, int wodCount) {
    return '$wodType • $quantity $metrics • $wodCount exercises';
  }

  @override
  String get all_exercise => 'exercise';

  @override
  String get all_exercises => 'exercises';

  @override
  String get all_round => 'round';

  @override
  String get all_rounds => 'rounds';

  @override
  String exercise_category_subtitle_cooldown(int count) {
    return '$count exercises';
  }

  @override
  String get preview_audio_settings_title => 'Audio';

  @override
  String get preview_audio_settings_button_title => 'Apply';

  @override
  String get preview_audio_settings_item_title1 => 'Voice and Sounds';

  @override
  String get preview_audio_settings_item_title2 => 'Voice and Music';

  @override
  String get preview_audio_settings_item_title3 => 'Sound Off (Only Music)';

  @override
  String get preview_workout_settings_title => 'Settings';

  @override
  String get preview_workout_settings_button_title => 'Apply';

  @override
  String get preview_workout_settings_item_title1 => 'Turn Off Warm-Up';

  @override
  String get preview_workout_settings_item_title2 => 'Turn Off Stretching Session';

  @override
  String get preview_workout_button_download => 'Download';

  @override
  String get preview_workout_button_loading => 'Downloading...';

  @override
  String get preview_workout_button_start => 'Start';

  @override
  String get preview_unlock_workout => 'Unlock Workout';

  @override
  String get preview_workout_details => 'Details';

  @override
  String get preview_workout_equipment => 'Equipment';

  @override
  String get exercise_button_result => 'Result';

  @override
  String get exercise_button_finish => 'Finish';

  @override
  String get workout_summary_time_score_title => 'Time';

  @override
  String get workout_summary_workout_result_title => 'Workout score';

  @override
  String get workout_summary_calories => 'Estimated\ncalories burned';

  @override
  String get workout_summary_duration => 'Duration';

  @override
  String get workout_summary_exercises => 'Exercises';

  @override
  String get workout_summary_rounds => 'Rounds';

  @override
  String get workout_summary_round => 'Round';

  @override
  String get workout_summary_share => 'Share';

  @override
  String get workout_summary_finish => 'Finish';

  @override
  String get exercise_button_skip_rest => 'Skip Rest';

  @override
  String get onboarding_button_text => 'Push ups';

  @override
  String get onboarding_step_one_advice => 'Tap here to pause\n workout and see the menu';

  @override
  String get onboarding_step_two_advice => 'Tap here to watch tutorial\n for the exercise';

  @override
  String get onboarding_step_three_advice1 => 'Tap here or swipe\n left to go to the previous\n exercise';

  @override
  String get onboarding_step_three_advice2 => 'Tap here or swipe\n right to go to the next\n exercise';

  @override
  String get onboarding_skip => 'Skip';

  @override
  String get workout_flow_exercise_overlay_title => 'Next exercise';

  @override
  String get workout_congratulation_title => 'Well Done!';

  @override
  String get workout_congratulation_subtitle => 'You\'re a great athlete!';

  @override
  String get workout_congratulation_action_btn_text => 'Watch result';
}
