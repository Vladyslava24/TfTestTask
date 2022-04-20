// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `START YOUR JOURNEY TO`
  String get splash_title {
    return Intl.message(
      'START YOUR JOURNEY TO',
      name: 'splash_title',
      desc: '',
      args: [],
    );
  }

  /// `  OPTIMAL HEALTH  `
  String get splash_title2 {
    return Intl.message(
      '  OPTIMAL HEALTH  ',
      name: 'splash_title2',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get splash_screen_sign_up_button_title {
    return Intl.message(
      'Sign Up',
      name: 'splash_screen_sign_up_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get splash_screen_account_title {
    return Intl.message(
      'Already have an account?',
      name: 'splash_screen_account_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get splash_screen_login {
    return Intl.message(
      'Login',
      name: 'splash_screen_login',
      desc: '',
      args: [],
    );
  }

  /// `Ready to rock?`
  String get ready_to_rock_title {
    return Intl.message(
      'Ready to rock?',
      name: 'ready_to_rock_title',
      desc: '',
      args: [],
    );
  }

  /// `Start your journey with a single workout`
  String get ready_to_rock_subtitle {
    return Intl.message(
      'Start your journey with a single workout',
      name: 'ready_to_rock_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `BODYWEIGHT`
  String get bodyWeight {
    return Intl.message(
      'BODYWEIGHT',
      name: 'bodyWeight',
      desc: '',
      args: [],
    );
  }

  /// `Equipment`
  String get equipment {
    return Intl.message(
      'Equipment',
      name: 'equipment',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get all__OK {
    return Intl.message(
      'OK',
      name: 'all__OK',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get all__cancel {
    return Intl.message(
      'Cancel',
      name: 'all__cancel',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get all__retry {
    return Intl.message(
      'Retry',
      name: 'all__retry',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get all__continue {
    return Intl.message(
      'Continue',
      name: 'all__continue',
      desc: '',
      args: [],
    );
  }

  /// `No internet`
  String get all__error_network_title {
    return Intl.message(
      'No internet',
      name: 'all__error_network_title',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again.`
  String get all__error_network_description {
    return Intl.message(
      'Please check your internet connection and try again.',
      name: 'all__error_network_description',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get all__error_unexpected_title {
    return Intl.message(
      'Server error',
      name: 'all__error_unexpected_title',
      desc: '',
      args: [],
    );
  }

  /// `Ooops... Something went wrong. Try again later.`
  String get all__error_unexpected_description {
    return Intl.message(
      'Ooops... Something went wrong. Try again later.',
      name: 'all__error_unexpected_description',
      desc: '',
      args: [],
    );
  }

  /// `today`
  String get all__today {
    return Intl.message(
      'today',
      name: 'all__today',
      desc: '',
      args: [],
    );
  }

  /// `skill`
  String get all__skill {
    return Intl.message(
      'skill',
      name: 'all__skill',
      desc: '',
      args: [],
    );
  }

  /// `quit`
  String get all__quit {
    return Intl.message(
      'quit',
      name: 'all__quit',
      desc: '',
      args: [],
    );
  }

  /// `don’t`
  String get all__dont {
    return Intl.message(
      'don’t',
      name: 'all__dont',
      desc: '',
      args: [],
    );
  }

  /// `ALRIGHT`
  String get all__alright {
    return Intl.message(
      'ALRIGHT',
      name: 'all__alright',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get all__save {
    return Intl.message(
      'Save',
      name: 'all__save',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get all__finish {
    return Intl.message(
      'Finish',
      name: 'all__finish',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get all__skip {
    return Intl.message(
      'Skip',
      name: 'all__skip',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get all__error {
    return Intl.message(
      'Error',
      name: 'all__error',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get all__privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'all__privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms Of Use`
  String get all__terms_of_use {
    return Intl.message(
      'Terms Of Use',
      name: 'all__terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get all__next {
    return Intl.message(
      'Next',
      name: 'all__next',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications_settings {
    return Intl.message(
      'Notifications',
      name: 'notifications_settings',
      desc: '',
      args: [],
    );
  }

  /// `Completed workouts`
  String get completed_workouts {
    return Intl.message(
      'Completed workouts',
      name: 'completed_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Warm-up`
  String get exercise_category_title_warm_up {
    return Intl.message(
      'Warm-up',
      name: 'exercise_category_title_warm_up',
      desc: '',
      args: [],
    );
  }

  /// `Skill`
  String get exercise_category_title_skill {
    return Intl.message(
      'Skill',
      name: 'exercise_category_title_skill',
      desc: '',
      args: [],
    );
  }

  /// `WOD`
  String get exercise_category_title_wod {
    return Intl.message(
      'WOD',
      name: 'exercise_category_title_wod',
      desc: '',
      args: [],
    );
  }

  /// `wod completed`
  String get wod_complited {
    return Intl.message(
      'wod completed',
      name: 'wod_complited',
      desc: '',
      args: [],
    );
  }

  /// `You're almost finished this workout`
  String get youre_almost_finished_workout {
    return Intl.message(
      'You\'re almost finished this workout',
      name: 'youre_almost_finished_workout',
      desc: '',
      args: [],
    );
  }

  /// `Cooldown`
  String get exercise_category_title_cooldown {
    return Intl.message(
      'Cooldown',
      name: 'exercise_category_title_cooldown',
      desc: '',
      args: [],
    );
  }

  /// `{count} exercises`
  String exercise_category_subtitle_warm_up(Object count) {
    return Intl.message(
      '$count exercises',
      name: 'exercise_category_subtitle_warm_up',
      desc: '',
      args: [count],
    );
  }

  /// `{roundCount} rounds • {exerciseCount} exercises`
  String exercise_category_subtitle_warm_up_multiple_rounds(
      Object roundCount, Object exerciseCount) {
    return Intl.message(
      '$roundCount rounds • $exerciseCount exercises',
      name: 'exercise_category_subtitle_warm_up_multiple_rounds',
      desc: '',
      args: [roundCount, exerciseCount],
    );
  }

  /// `1 round • {exerciseCount} exercises`
  String exercise_category_subtitle_warm_up_single_rounds(
      Object exerciseCount) {
    return Intl.message(
      '1 round • $exerciseCount exercises',
      name: 'exercise_category_subtitle_warm_up_single_rounds',
      desc: '',
      args: [exerciseCount],
    );
  }

  /// `{wodType} • {quantity} {metrics} • {wodCount} exercises`
  String exercise_category_subtitle_wod(
      Object wodType, Object quantity, Object metrics, Object wodCount) {
    return Intl.message(
      '$wodType • $quantity $metrics • $wodCount exercises',
      name: 'exercise_category_subtitle_wod',
      desc: '',
      args: [wodType, quantity, metrics, wodCount],
    );
  }

  /// `{count} exercises`
  String exercise_category_subtitle_cooldown(Object count) {
    return Intl.message(
      '$count exercises',
      name: 'exercise_category_subtitle_cooldown',
      desc: '',
      args: [count],
    );
  }

  /// `{duration} minutes`
  String workout_preview_duration(Object duration) {
    return Intl.message(
      '$duration minutes',
      name: 'workout_preview_duration',
      desc: '',
      args: [duration],
    );
  }

  /// `START WORKOUT`
  String get workout_preview_idle_button_text {
    return Intl.message(
      'START WORKOUT',
      name: 'workout_preview_idle_button_text',
      desc: '',
      args: [],
    );
  }

  /// `GO TO SKILL`
  String get workout_preview_warm_up_button_text {
    return Intl.message(
      'GO TO SKILL',
      name: 'workout_preview_warm_up_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Go to workout of the day`
  String get workout_preview_wod_button_text {
    return Intl.message(
      'Go to workout of the day',
      name: 'workout_preview_wod_button_text',
      desc: '',
      args: [],
    );
  }

  /// `GO TO COOLDOWN`
  String get workout_preview_cooldown_button_text {
    return Intl.message(
      'GO TO COOLDOWN',
      name: 'workout_preview_cooldown_button_text',
      desc: '',
      args: [],
    );
  }

  /// `GO TO SUMMARY`
  String get workout_preview_completed_button_text {
    return Intl.message(
      'GO TO SUMMARY',
      name: 'workout_preview_completed_button_text',
      desc: '',
      args: [],
    );
  }

  /// `It’s not the end`
  String get dialog_quit_workout_title {
    return Intl.message(
      'It’s not the end',
      name: 'dialog_quit_workout_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to quit your workout?`
  String get dialog_quit_workout_description {
    return Intl.message(
      'Are you sure you want to quit your workout?',
      name: 'dialog_quit_workout_description',
      desc: '',
      args: [],
    );
  }

  /// `quit`
  String get dialog_quit_workout_negative_text {
    return Intl.message(
      'quit',
      name: 'dialog_quit_workout_negative_text',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get dialog_error_recoverable_negative_text {
    return Intl.message(
      'cancel',
      name: 'dialog_error_recoverable_negative_text',
      desc: '',
      args: [],
    );
  }

  /// `Quit your current program to start a new one`
  String get dialog__quit_your_current_program {
    return Intl.message(
      'Quit your current program to start a new one',
      name: 'dialog__quit_your_current_program',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get dialog_error_login_title {
    return Intl.message(
      'Login failed',
      name: 'dialog_error_login_title',
      desc: '',
      args: [],
    );
  }

  /// `Error!`
  String get dialog_error_title {
    return Intl.message(
      'Error!',
      name: 'dialog_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Programs`
  String get bottom_menu__programs {
    return Intl.message(
      'Programs',
      name: 'bottom_menu__programs',
      desc: '',
      args: [],
    );
  }

  /// `Workouts`
  String get bottom_menu__workouts {
    return Intl.message(
      'Workouts',
      name: 'bottom_menu__workouts',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get bottom_menu__progress {
    return Intl.message(
      'Progress',
      name: 'bottom_menu__progress',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get bottom_menu__profile {
    return Intl.message(
      'Profile',
      name: 'bottom_menu__profile',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get bottom_menu__explore {
    return Intl.message(
      'Explore',
      name: 'bottom_menu__explore',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get choose_program_days__monday {
    return Intl.message(
      'Monday',
      name: 'choose_program_days__monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get choose_program_days__tuesday {
    return Intl.message(
      'Tuesday',
      name: 'choose_program_days__tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get choose_program_days__wednesday {
    return Intl.message(
      'Wednesday',
      name: 'choose_program_days__wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get choose_program_days__thursday {
    return Intl.message(
      'Thursday',
      name: 'choose_program_days__thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get choose_program_days__friday {
    return Intl.message(
      'Friday',
      name: 'choose_program_days__friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get choose_program_days__saturday {
    return Intl.message(
      'Saturday',
      name: 'choose_program_days__saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get choose_program_days__sunday {
    return Intl.message(
      'Sunday',
      name: 'choose_program_days__sunday',
      desc: '',
      args: [],
    );
  }

  /// `Choose days`
  String get choose_program_days__app_bar_title {
    return Intl.message(
      'Choose days',
      name: 'choose_program_days__app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose your fitness level`
  String get choose_program_level__app_bar_title {
    return Intl.message(
      'Choose your fitness level',
      name: 'choose_program_level__app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose number of weeks`
  String get choose_program_number_of_weeks_screen__app_bar_title {
    return Intl.message(
      'Choose number of weeks',
      name: 'choose_program_number_of_weeks_screen__app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `weeks`
  String get choose_program_number_of_weeks_screen__weeks {
    return Intl.message(
      'weeks',
      name: 'choose_program_number_of_weeks_screen__weeks',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get choose_program_level__beginner {
    return Intl.message(
      'Beginner',
      name: 'choose_program_level__beginner',
      desc: '',
      args: [],
    );
  }

  /// `I am new to training`
  String get choose_program_level__beginner_description {
    return Intl.message(
      'I am new to training',
      name: 'choose_program_level__beginner_description',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate`
  String get choose_program_level__intermediate {
    return Intl.message(
      'Intermediate',
      name: 'choose_program_level__intermediate',
      desc: '',
      args: [],
    );
  }

  /// `I train 1–2 times a week`
  String get choose_program_level__intermediate_description {
    return Intl.message(
      'I train 1–2 times a week',
      name: 'choose_program_level__intermediate_description',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get choose_program_level__advanced {
    return Intl.message(
      'Advanced',
      name: 'choose_program_level__advanced',
      desc: '',
      args: [],
    );
  }

  /// `I train over 3 times a week`
  String get choose_program_level__advanced_description {
    return Intl.message(
      'I train over 3 times a week',
      name: 'choose_program_level__advanced_description',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Choises`
  String get program_setup_summary__app_bar_title {
    return Intl.message(
      'Confirm Choises',
      name: 'program_setup_summary__app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get program_setup_summary__start_date {
    return Intl.message(
      'Start Date',
      name: 'program_setup_summary__start_date',
      desc: '',
      args: [],
    );
  }

  /// `Start program`
  String get program_setup_summary__start_program {
    return Intl.message(
      'Start program',
      name: 'program_setup_summary__start_program',
      desc: '',
      args: [],
    );
  }

  /// `Reassemble program`
  String get program_setup_summary__update_program {
    return Intl.message(
      'Reassemble program',
      name: 'program_setup_summary__update_program',
      desc: '',
      args: [],
    );
  }

  /// `Days of the week`
  String get program_setup_summary__days_of_the_week {
    return Intl.message(
      'Days of the week',
      name: 'program_setup_summary__days_of_the_week',
      desc: '',
      args: [],
    );
  }

  /// `Number of weeks`
  String get program_setup_summary__number_of_weeks {
    return Intl.message(
      'Number of weeks',
      name: 'program_setup_summary__number_of_weeks',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get program_setup_summary__level {
    return Intl.message(
      'Level',
      name: 'program_setup_summary__level',
      desc: '',
      args: [],
    );
  }

  /// `Setup`
  String get program_description__setup {
    return Intl.message(
      'Setup',
      name: 'program_description__setup',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get program_description__goal {
    return Intl.message(
      'Goal',
      name: 'program_description__goal',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get program_description__info {
    return Intl.message(
      'Info',
      name: 'program_description__info',
      desc: '',
      args: [],
    );
  }

  /// `40-50 %s and %s`
  String get test {
    return Intl.message(
      '40-50 %s and %s',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Optimal Health for `
  String get progress_header_item_title {
    return Intl.message(
      'Optimal Health for ',
      name: 'progress_header_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Body, Mind and Spirit training in one app`
  String get intro_first_screen_title {
    return Intl.message(
      'Body, Mind and Spirit training in one app',
      name: 'intro_first_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Totalfit App! Do workouts, read useful stories and wisdoms and develop healthy habits every day.`
  String get intro_first_screen_subtitle {
    return Intl.message(
      'Welcome to Totalfit App! Do workouts, read useful stories and wisdoms and develop healthy habits every day.',
      name: 'intro_first_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `What is your\n goal?`
  String get intro_second_screen_title {
    return Intl.message(
      'What is your\n goal?',
      name: 'intro_second_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Fitness`
  String get intro_second_screen_fitness_title {
    return Intl.message(
      'Fitness',
      name: 'intro_second_screen_fitness_title',
      desc: '',
      args: [],
    );
  }

  /// `I want to get fit, strong and healthy`
  String get intro_second_screen_fitness_subtitle {
    return Intl.message(
      'I want to get fit, strong and healthy',
      name: 'intro_second_screen_fitness_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Mindfulness`
  String get intro_second_screen_mindfulness_title {
    return Intl.message(
      'Mindfulness',
      name: 'intro_second_screen_mindfulness_title',
      desc: '',
      args: [],
    );
  }

  /// `I want to stay focused and mindful`
  String get intro_second_screen_mindfulness_subtitle {
    return Intl.message(
      'I want to stay focused and mindful',
      name: 'intro_second_screen_mindfulness_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Knowledge`
  String get intro_second_screen_knowledge_title {
    return Intl.message(
      'Knowledge',
      name: 'intro_second_screen_knowledge_title',
      desc: '',
      args: [],
    );
  }

  /// `I want to know more about my body`
  String get intro_second_screen_knowledge_subtitle {
    return Intl.message(
      'I want to know more about my body',
      name: 'intro_second_screen_knowledge_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `What is your\n fitness level?`
  String get intro_third_screen_title {
    return Intl.message(
      'What is your\n fitness level?',
      name: 'intro_third_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `I just start my journey`
  String get intro_third_screen_beginner_subtitle {
    return Intl.message(
      'I just start my journey',
      name: 'intro_third_screen_beginner_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `I train 1-2 times a week`
  String get intro_third_screen_medium_subtitle {
    return Intl.message(
      'I train 1-2 times a week',
      name: 'intro_third_screen_medium_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `I train over 3 times a week`
  String get intro_third_screen_pro_subtitle {
    return Intl.message(
      'I train over 3 times a week',
      name: 'intro_third_screen_pro_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Stay tuned`
  String get intro_fourth_screen_title {
    return Intl.message(
      'Stay tuned',
      name: 'intro_fourth_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `We can send you notifications about workouts, healthy habits and new features`
  String get intro_fourth_screen_subtitle {
    return Intl.message(
      'We can send you notifications about workouts, healthy habits and new features',
      name: 'intro_fourth_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Cool, do it!`
  String get intro_fourth_screen_btn_confirm {
    return Intl.message(
      'Cool, do it!',
      name: 'intro_fourth_screen_btn_confirm',
      desc: '',
      args: [],
    );
  }

  /// `No, thanks`
  String get intro_fourth_screen_btn_cancel {
    return Intl.message(
      'No, thanks',
      name: 'intro_fourth_screen_btn_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Hexagon`
  String get intro_fifth_screen_title {
    return Intl.message(
      'Hexagon',
      name: 'intro_fifth_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `We use a hexagon to show you daily and lifelong progress in 6 spheres:\nphisical, environmental, intellectual, social, spiritual and emotional`
  String get intro_fifth_screen_subtitle {
    return Intl.message(
      'We use a hexagon to show you daily and lifelong progress in 6 spheres:\nphisical, environmental, intellectual, social, spiritual and emotional',
      name: 'intro_fifth_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Let, start!`
  String get intro_fifth_screen_btn {
    return Intl.message(
      'Let, start!',
      name: 'intro_fifth_screen_btn',
      desc: '',
      args: [],
    );
  }

  /// `Choose the program`
  String get programs__choose_the_program_title {
    return Intl.message(
      'Choose the program',
      name: 'programs__choose_the_program_title',
      desc: '',
      args: [],
    );
  }

  /// `Get daily workouts and see your progress and goals`
  String get programs__choose_the_program_subtitle {
    return Intl.message(
      'Get daily workouts and see your progress and goals',
      name: 'programs__choose_the_program_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `All levels`
  String get programs__all_levels {
    return Intl.message(
      'All levels',
      name: 'programs__all_levels',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get programs__and {
    return Intl.message(
      'and',
      name: 'programs__and',
      desc: '',
      args: [],
    );
  }

  /// `Program schedule`
  String get program_full_schedule__program_schedule {
    return Intl.message(
      'Program schedule',
      name: 'program_full_schedule__program_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get programs_progress__reschedule {
    return Intl.message(
      'Reschedule',
      name: 'programs_progress__reschedule',
      desc: '',
      args: [],
    );
  }

  /// `Skills learned`
  String get programs_progress__skills_learned {
    return Intl.message(
      'Skills learned',
      name: 'programs_progress__skills_learned',
      desc: '',
      args: [],
    );
  }

  /// `You reached`
  String get programs_progress__you_reached {
    return Intl.message(
      'You reached',
      name: 'programs_progress__you_reached',
      desc: '',
      args: [],
    );
  }

  /// `Fantastic! You’ve finished program!`
  String get programs_progress__fantastic_youve_finished_program {
    return Intl.message(
      'Fantastic! You’ve finished program!',
      name: 'programs_progress__fantastic_youve_finished_program',
      desc: '',
      args: [],
    );
  }

  /// `Wow! You nailed it!`
  String get programs_progress__wow_you_nailed_it {
    return Intl.message(
      'Wow! You nailed it!',
      name: 'programs_progress__wow_you_nailed_it',
      desc: '',
      args: [],
    );
  }

  /// `You’ve completed all scheduled workouts!`
  String get programs_progress__youve_completed_all_scheduled_workouts {
    return Intl.message(
      'You’ve completed all scheduled workouts!',
      name: 'programs_progress__youve_completed_all_scheduled_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Days a week`
  String get programs_progress__days_a_week {
    return Intl.message(
      'Days a week',
      name: 'programs_progress__days_a_week',
      desc: '',
      args: [],
    );
  }

  /// `Full schedule`
  String get programs_progress__full_schedule {
    return Intl.message(
      'Full schedule',
      name: 'programs_progress__full_schedule',
      desc: '',
      args: [],
    );
  }

  /// `This week`
  String get programs_progress__this_week {
    return Intl.message(
      'This week',
      name: 'programs_progress__this_week',
      desc: '',
      args: [],
    );
  }

  /// `All programs`
  String get programs_progress__all_programs {
    return Intl.message(
      'All programs',
      name: 'programs_progress__all_programs',
      desc: '',
      args: [],
    );
  }

  /// `Finish program`
  String get programs_progress__finish_program {
    return Intl.message(
      'Finish program',
      name: 'programs_progress__finish_program',
      desc: '',
      args: [],
    );
  }

  /// `Workout of the day`
  String get programs_progress__workout_of_the_day {
    return Intl.message(
      'Workout of the day',
      name: 'programs_progress__workout_of_the_day',
      desc: '',
      args: [],
    );
  }

  /// `Workout of The Day`
  String get workout_of_the_day {
    return Intl.message(
      'Workout of The Day',
      name: 'workout_of_the_day',
      desc: '',
      args: [],
    );
  }

  /// `workouts`
  String get programs_progress__workouts {
    return Intl.message(
      'workouts',
      name: 'programs_progress__workouts',
      desc: '',
      args: [],
    );
  }

  /// `There is no workout for today.\nUse this day to rest and recover.`
  String get programs_progress__empty_workout {
    return Intl.message(
      'There is no workout for today.\nUse this day to rest and recover.',
      name: 'programs_progress__empty_workout',
      desc: '',
      args: [],
    );
  }

  /// `Breathing`
  String get programs_progress__breathing_card_title {
    return Intl.message(
      'Breathing',
      name: 'programs_progress__breathing_card_title',
      desc: '',
      args: [],
    );
  }

  /// `Daily practice`
  String get programs_progress__breathing_card_sub {
    return Intl.message(
      'Daily practice',
      name: 'programs_progress__breathing_card_sub',
      desc: '',
      args: [],
    );
  }

  /// `1 min`
  String get programs_progress__breathing_card_time {
    return Intl.message(
      '1 min',
      name: 'programs_progress__breathing_card_time',
      desc: '',
      args: [],
    );
  }

  /// `Program schedule`
  String get program_schedule_title {
    return Intl.message(
      'Program schedule',
      name: 'program_schedule_title',
      desc: '',
      args: [],
    );
  }

  /// `Week {number}`
  String program_schedule_item_title(Object number) {
    return Intl.message(
      'Week $number',
      name: 'program_schedule_item_title',
      desc: '',
      args: [number],
    );
  }

  /// `Starts on {date}`
  String program_start_button_text(Object date) {
    return Intl.message(
      'Starts on $date',
      name: 'program_start_button_text',
      desc: '',
      args: [date],
    );
  }

  /// `Edit program`
  String get program_edit_title {
    return Intl.message(
      'Edit program',
      name: 'program_edit_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose your fitness Level`
  String get program_edit_level {
    return Intl.message(
      'Choose your fitness Level',
      name: 'program_edit_level',
      desc: '',
      args: [],
    );
  }

  /// `Choose number of weeks`
  String get program_edit_number_of_weeks {
    return Intl.message(
      'Choose number of weeks',
      name: 'program_edit_number_of_weeks',
      desc: '',
      args: [],
    );
  }

  /// `Choose days`
  String get program_edit_days {
    return Intl.message(
      'Choose days',
      name: 'program_edit_days',
      desc: '',
      args: [],
    );
  }

  /// `Wow! You nailed it!`
  String get program_completed_item_title {
    return Intl.message(
      'Wow! You nailed it!',
      name: 'program_completed_item_title',
      desc: '',
      args: [],
    );
  }

  /// `You’ve completed all scheduled workouts!`
  String get program_completed_item_sub_title {
    return Intl.message(
      'You’ve completed all scheduled workouts!',
      name: 'program_completed_item_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `FINISH PROGRAM`
  String get program_completed_item_button_text {
    return Intl.message(
      'FINISH PROGRAM',
      name: 'program_completed_item_button_text',
      desc: '',
      args: [],
    );
  }

  /// `SEE ALL COMPLETED WORKOUTS`
  String get progress_workout_item_button_text {
    return Intl.message(
      'SEE ALL COMPLETED WORKOUTS',
      name: 'progress_workout_item_button_text',
      desc: '',
      args: [],
    );
  }

  /// `MISSED WORKOUT`
  String get program_workout_preview_missed_workout {
    return Intl.message(
      'MISSED WORKOUT',
      name: 'program_workout_preview_missed_workout',
      desc: '',
      args: [],
    );
  }

  /// `Finish AMRAP workout before countdown if you’ve already done.`
  String get amrap_tooltip_text {
    return Intl.message(
      'Finish AMRAP workout before countdown if you’ve already done.',
      name: 'amrap_tooltip_text',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get workout_schedule_pop_confirm_text {
    return Intl.message(
      'Schedule',
      name: 'workout_schedule_pop_confirm_text',
      desc: '',
      args: [],
    );
  }

  /// `When do you want to be notified about your next workout?`
  String get workout_schedule_pop_title {
    return Intl.message(
      'When do you want to be notified about your next workout?',
      name: 'workout_schedule_pop_title',
      desc: '',
      args: [],
    );
  }

  /// `Workout will take 10-25 min`
  String get workout_schedule_pop_sub_title {
    return Intl.message(
      'Workout will take 10-25 min',
      name: 'workout_schedule_pop_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `unlock programs\nand all workouts`
  String get paywall_title {
    return Intl.message(
      'unlock programs\nand all workouts',
      name: 'paywall_title',
      desc: '',
      args: [],
    );
  }

  /// `Start 7 day `
  String get paywall_subtitle_1 {
    return Intl.message(
      'Start 7 day ',
      name: 'paywall_subtitle_1',
      desc: '',
      args: [],
    );
  }

  /// `Free Trial`
  String get paywall_subtitle_2 {
    return Intl.message(
      'Free Trial',
      name: 'paywall_subtitle_2',
      desc: '',
      args: [],
    );
  }

  /// `World-class programs!`
  String get paywall_benefit_1 {
    return Intl.message(
      'World-class programs!',
      name: 'paywall_benefit_1',
      desc: '',
      args: [],
    );
  }

  /// `250+ various workouts`
  String get paywall_benefit_2 {
    return Intl.message(
      '250+ various workouts',
      name: 'paywall_benefit_2',
      desc: '',
      args: [],
    );
  }

  /// `New releases weekly`
  String get paywall_benefit_3 {
    return Intl.message(
      'New releases weekly',
      name: 'paywall_benefit_3',
      desc: '',
      args: [],
    );
  }

  /// `Restore purchase`
  String get paywall_restore_purchase {
    return Intl.message(
      'Restore purchase',
      name: 'paywall_restore_purchase',
      desc: '',
      args: [],
    );
  }

  /// `You already subscribed to Totalfit App.`
  String get paywall_subscription_done {
    return Intl.message(
      'You already subscribed to Totalfit App.',
      name: 'paywall_subscription_done',
      desc: '',
      args: [],
    );
  }

  /// `No Products found`
  String get paywall_no_products {
    return Intl.message(
      'No Products found',
      name: 'paywall_no_products',
      desc: '',
      args: [],
    );
  }

  /// `Save {discount} %`
  String paywall_discount_amount(Object discount) {
    return Intl.message(
      'Save $discount %',
      name: 'paywall_discount_amount',
      desc: '',
      args: [discount],
    );
  }

  /// `Unknown`
  String get paywall_purchase_item_unknown {
    return Intl.message(
      'Unknown',
      name: 'paywall_purchase_item_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get paywall_purchase_item_custom {
    return Intl.message(
      'Custom',
      name: 'paywall_purchase_item_custom',
      desc: '',
      args: [],
    );
  }

  /// `Lifetime`
  String get paywall_purchase_item_lifetime {
    return Intl.message(
      'Lifetime',
      name: 'paywall_purchase_item_lifetime',
      desc: '',
      args: [],
    );
  }

  /// `Annual`
  String get paywall_purchase_item_annual {
    return Intl.message(
      'Annual',
      name: 'paywall_purchase_item_annual',
      desc: '',
      args: [],
    );
  }

  /// `6 months`
  String get paywall_purchase_item_6_month {
    return Intl.message(
      '6 months',
      name: 'paywall_purchase_item_6_month',
      desc: '',
      args: [],
    );
  }

  /// `3 months`
  String get paywall_purchase_item_3_month {
    return Intl.message(
      '3 months',
      name: 'paywall_purchase_item_3_month',
      desc: '',
      args: [],
    );
  }

  /// `2 months`
  String get paywall_purchase_item_2_month {
    return Intl.message(
      '2 months',
      name: 'paywall_purchase_item_2_month',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get paywall_purchase_item_monthly {
    return Intl.message(
      'Monthly',
      name: 'paywall_purchase_item_monthly',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get paywall_purchase_item_weekly {
    return Intl.message(
      'Weekly',
      name: 'paywall_purchase_item_weekly',
      desc: '',
      args: [],
    );
  }

  /// `{price} / weekly`
  String paywall_weekly_price(Object price) {
    return Intl.message(
      '$price / weekly',
      name: 'paywall_weekly_price',
      desc: '',
      args: [price],
    );
  }

  /// `Start a 7-Day Trial`
  String get paywall_button_text {
    return Intl.message(
      'Start a 7-Day Trial',
      name: 'paywall_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Terms`
  String get paywall_ios_policy_title {
    return Intl.message(
      'Subscription Terms',
      name: 'paywall_ios_policy_title',
      desc: '',
      args: [],
    );
  }

  /// `Your Apple ID payment method will be automatically charged. The subscription renews automatically at the end of each period, until you cancel. To avoid being charged, cancel the subscription in your iTunes & App Store/Apple ID account settings at least 24 hours before the current subscription period. If you are unsure how to cancel a subscription, please visit the Apple Support website. Note that deleting the app does not cancel your subscriptions. You may wish to make a printscreen of this information for your reference.`
  String get paywall_ios_policy_description {
    return Intl.message(
      'Your Apple ID payment method will be automatically charged. The subscription renews automatically at the end of each period, until you cancel. To avoid being charged, cancel the subscription in your iTunes & App Store/Apple ID account settings at least 24 hours before the current subscription period. If you are unsure how to cancel a subscription, please visit the Apple Support website. Note that deleting the app does not cancel your subscriptions. You may wish to make a printscreen of this information for your reference.',
      name: 'paywall_ios_policy_description',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Email`
  String get entry_screen_btn_to_sign_up {
    return Intl.message(
      'Continue with Email',
      name: 'entry_screen_btn_to_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Train your Body,\nMind and Spirit\nin one app`
  String get entry_screen_title {
    return Intl.message(
      'Train your Body,\nMind and Spirit\nin one app',
      name: 'entry_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Train your Body`
  String get train_your_body {
    return Intl.message(
      'Train your Body',
      name: 'train_your_body',
      desc: '',
      args: [],
    );
  }

  /// `Grow your Mind`
  String get grow_your_mind {
    return Intl.message(
      'Grow your Mind',
      name: 'grow_your_mind',
      desc: '',
      args: [],
    );
  }

  /// `Develop your Spirit`
  String get develop_your_spirit {
    return Intl.message(
      'Develop your Spirit',
      name: 'develop_your_spirit',
      desc: '',
      args: [],
    );
  }

  /// `Or Sign up with`
  String get entry_screen_sign_with {
    return Intl.message(
      'Or Sign up with',
      name: 'entry_screen_sign_with',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get entry_screen_already_have {
    return Intl.message(
      'Already have an account?',
      name: 'entry_screen_already_have',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get entry_screen_btn_sign_in {
    return Intl.message(
      'Sign In',
      name: 'entry_screen_btn_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get entry_screen_terms_title {
    return Intl.message(
      'Terms & Conditions',
      name: 'entry_screen_terms_title',
      desc: '',
      args: [],
    );
  }

  /// `What’s covered in these terms. We know it’s tempting to skip these Terms of Service, but it’s important to establish what you can expect from us as you use Totalfit, and what we expect from you.`
  String get entry_screen_terms_text {
    return Intl.message(
      'What’s covered in these terms. We know it’s tempting to skip these Terms of Service, but it’s important to establish what you can expect from us as you use Totalfit, and what we expect from you.',
      name: 'entry_screen_terms_text',
      desc: '',
      args: [],
    );
  }

  /// `Agree to Terms & Conditions and Privacy\nPolicy to continue`
  String get entry_screen_terms_agree {
    return Intl.message(
      'Agree to Terms & Conditions and Privacy\nPolicy to continue',
      name: 'entry_screen_terms_agree',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get entry_screen_terms_button {
    return Intl.message(
      'Continue',
      name: 'entry_screen_terms_button',
      desc: '',
      args: [],
    );
  }

  /// `I agree to`
  String get entry_screen_i_agree_to {
    return Intl.message(
      'I agree to',
      name: 'entry_screen_i_agree_to',
      desc: '',
      args: [],
    );
  }

  /// `\nand`
  String get entry_screen_i_agree_and {
    return Intl.message(
      '\nand',
      name: 'entry_screen_i_agree_and',
      desc: '',
      args: [],
    );
  }

  /// ` Privacy Policy`
  String get entry_screen_i_agree_privacy {
    return Intl.message(
      ' Privacy Policy',
      name: 'entry_screen_i_agree_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Let’s sign you in`
  String get sign_in_screen_title {
    return Intl.message(
      'Let’s sign you in',
      name: 'sign_in_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back, you’ve been missed!\nyou’ve been missed!`
  String get sign_in_screen_description {
    return Intl.message(
      'Welcome back, you’ve been missed!\nyou’ve been missed!',
      name: 'sign_in_screen_description',
      desc: '',
      args: [],
    );
  }

  /// `Or Log In with`
  String get sign_in_screen_login_with {
    return Intl.message(
      'Or Log In with',
      name: 'sign_in_screen_login_with',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have account?`
  String get sign_in_screen_alt_auth_title {
    return Intl.message(
      'Don’t have account?',
      name: 'sign_in_screen_alt_auth_title',
      desc: '',
      args: [],
    );
  }

  /// `Create new account.`
  String get sign_in_screen_alt_auth_action {
    return Intl.message(
      'Create new account.',
      name: 'sign_in_screen_alt_auth_action',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_in_screen_input_email {
    return Intl.message(
      'Email',
      name: 'sign_in_screen_input_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_in_screen_input_password {
    return Intl.message(
      'Password',
      name: 'sign_in_screen_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in_screen_button {
    return Intl.message(
      'Sign in',
      name: 'sign_in_screen_button',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get sign_in_screen_forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'sign_in_screen_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Let’s get started`
  String get sign_up_screen_title {
    return Intl.message(
      'Let’s get started',
      name: 'sign_up_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Create an account now to start your\njourney to optimal health.`
  String get sign_up_screen_description {
    return Intl.message(
      'Create an account now to start your\njourney to optimal health.',
      name: 'sign_up_screen_description',
      desc: '',
      args: [],
    );
  }

  /// `Or Sign up with`
  String get sign_up_screen_sign_up_with {
    return Intl.message(
      'Or Sign up with',
      name: 'sign_up_screen_sign_up_with',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get sign_up_screen_already_have {
    return Intl.message(
      'Already have an account?',
      name: 'sign_up_screen_already_have',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_up_screen_btn_sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_up_screen_btn_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get sign_up_screen_input_name {
    return Intl.message(
      'Name',
      name: 'sign_up_screen_input_name',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up_screen_button {
    return Intl.message(
      'Sign Up',
      name: 'sign_up_screen_button',
      desc: '',
      args: [],
    );
  }

  /// `Agree to Terms & Conditions and Privacy\nPolicy to continue`
  String get sign_up_terms_agree {
    return Intl.message(
      'Agree to Terms & Conditions and Privacy\nPolicy to continue',
      name: 'sign_up_terms_agree',
      desc: '',
      args: [],
    );
  }

  /// `I agree to`
  String get sign_up_i_agree_to {
    return Intl.message(
      'I agree to',
      name: 'sign_up_i_agree_to',
      desc: '',
      args: [],
    );
  }

  /// ` Terms & Conditions`
  String get sign_up_i_agree_terms {
    return Intl.message(
      ' Terms & Conditions',
      name: 'sign_up_i_agree_terms',
      desc: '',
      args: [],
    );
  }

  /// `\nand`
  String get sign_up_i_agree_and {
    return Intl.message(
      '\nand',
      name: 'sign_up_i_agree_and',
      desc: '',
      args: [],
    );
  }

  /// ` Privacy Policy`
  String get sign_up_i_agree_privacy {
    return Intl.message(
      ' Privacy Policy',
      name: 'sign_up_i_agree_privacy',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get reset_password_screen_app_bar {
    return Intl.message(
      'New Password',
      name: 'reset_password_screen_app_bar',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password_screen_app_bar_alt {
    return Intl.message(
      'Reset Password',
      name: 'reset_password_screen_app_bar_alt',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get reset_password_screen_title {
    return Intl.message(
      'Forgot your password?',
      name: 'reset_password_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you instructions on how to reset your password.`
  String get reset_password_screen_description {
    return Intl.message(
      'Enter your email address and we will send you instructions on how to reset your password.',
      name: 'reset_password_screen_description',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get reset_password_screen_input_email {
    return Intl.message(
      'Email',
      name: 'reset_password_screen_input_email',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get reset_password_screen_new_password {
    return Intl.message(
      'New Password',
      name: 'reset_password_screen_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get reset_password_screen_confirm_password {
    return Intl.message(
      'Confirm New Password',
      name: 'reset_password_screen_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get reset_password_screen_button {
    return Intl.message(
      'Recover password',
      name: 'reset_password_screen_button',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get reset_password_screen_back {
    return Intl.message(
      'Back to Login',
      name: 'reset_password_screen_back',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get reset_password_screen_create_new_password {
    return Intl.message(
      'Create New Password',
      name: 'reset_password_screen_create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent you an email with a link to reset you password.`
  String get reset_password_screen_back_to_login_info {
    return Intl.message(
      'We’ve sent you an email with a link to reset you password.',
      name: 'reset_password_screen_back_to_login_info',
      desc: '',
      args: [],
    );
  }

  /// `Authorization canceled.`
  String get errors_auth_canceled {
    return Intl.message(
      'Authorization canceled.',
      name: 'errors_auth_canceled',
      desc: '',
      args: [],
    );
  }

  /// `The field must be not empty`
  String get errors_field_empty {
    return Intl.message(
      'The field must be not empty',
      name: 'errors_field_empty',
      desc: '',
      args: [],
    );
  }

  /// `Email address invalid`
  String get errors_field_invalid_email {
    return Intl.message(
      'Email address invalid',
      name: 'errors_field_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 6 characters long`
  String get errors_field_invalid_password {
    return Intl.message(
      'Password should be at least 6 characters long',
      name: 'errors_field_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save profile image`
  String get code_error_save_profile_image {
    return Intl.message(
      'Failed to save profile image',
      name: 'code_error_save_profile_image',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save profile`
  String get code_error_save_profile {
    return Intl.message(
      'Failed to save profile',
      name: 'code_error_save_profile',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch active program`
  String get code_error_fetch_active_program {
    return Intl.message(
      'Failed to fetch active program',
      name: 'code_error_fetch_active_program',
      desc: '',
      args: [],
    );
  }

  /// `Failed to parse response`
  String get code_error_parse_response {
    return Intl.message(
      'Failed to parse response',
      name: 'code_error_parse_response',
      desc: '',
      args: [],
    );
  }

  /// `User already exists`
  String get code_error_auth_conflict {
    return Intl.message(
      'User already exists',
      name: 'code_error_auth_conflict',
      desc: '',
      args: [],
    );
  }

  /// `Token expired`
  String get code_error_auth_token_expired {
    return Intl.message(
      'Token expired',
      name: 'code_error_auth_token_expired',
      desc: '',
      args: [],
    );
  }

  /// `Failed to authorize. Check your credentials`
  String get code_error_auth_failed {
    return Intl.message(
      'Failed to authorize. Check your credentials',
      name: 'code_error_auth_failed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to sign up. Probably you've already registered`
  String get code_error_auth_social_failed {
    return Intl.message(
      'Failed to sign up. Probably you\'ve already registered',
      name: 'code_error_auth_social_failed',
      desc: '',
      args: [],
    );
  }

  /// `Authorization canceled`
  String get code_error_auth_canceled {
    return Intl.message(
      'Authorization canceled',
      name: 'code_error_auth_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get code_error_network {
    return Intl.message(
      'Network error',
      name: 'code_error_network',
      desc: '',
      args: [],
    );
  }

  /// `Failed to access local database`
  String get code_error_db {
    return Intl.message(
      'Failed to access local database',
      name: 'code_error_db',
      desc: '',
      args: [],
    );
  }

  /// `No authorized user`
  String get code_error_no_authorized_user {
    return Intl.message(
      'No authorized user',
      name: 'code_error_no_authorized_user',
      desc: '',
      args: [],
    );
  }

  /// `Illegal authorized user number`
  String get code_error_illegal_authorized_user_number {
    return Intl.message(
      'Illegal authorized user number',
      name: 'code_error_illegal_authorized_user_number',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Workout Progress`
  String get code_error_load_workout_progress {
    return Intl.message(
      'Failed to load Workout Progress',
      name: 'code_error_load_workout_progress',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete Workout Progress`
  String get code_error_delete_workout_progress {
    return Intl.message(
      'Failed to delete Workout Progress',
      name: 'code_error_delete_workout_progress',
      desc: '',
      args: [],
    );
  }

  /// `Failed to build Program UI items`
  String get code_error_build_program_ui_items {
    return Intl.message(
      'Failed to build Program UI items',
      name: 'code_error_build_program_ui_items',
      desc: '',
      args: [],
    );
  }

  /// `Failed to finish Program`
  String get code_error_finish_program {
    return Intl.message(
      'Failed to finish Program',
      name: 'code_error_finish_program',
      desc: '',
      args: [],
    );
  }

  /// `Failed to interrupt Program`
  String get code_error_interrupt_program {
    return Intl.message(
      'Failed to interrupt Program',
      name: 'code_error_interrupt_program',
      desc: '',
      args: [],
    );
  }

  /// `Program not running`
  String get code_error_program_not_running {
    return Intl.message(
      'Program not running',
      name: 'code_error_program_not_running',
      desc: '',
      args: [],
    );
  }

  /// `Failed to start Program`
  String get code_error_start_program {
    return Intl.message(
      'Failed to start Program',
      name: 'code_error_start_program',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update Program`
  String get code_error_update_program {
    return Intl.message(
      'Failed to update Program',
      name: 'code_error_update_program',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Program`
  String get code_error_load_program {
    return Intl.message(
      'Failed to load Program',
      name: 'code_error_load_program',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Workout Summary`
  String get code_error_load_workout_summary {
    return Intl.message(
      'Failed to load Workout Summary',
      name: 'code_error_load_workout_summary',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load make a Purchase`
  String get code_error_purchase {
    return Intl.message(
      'Failed to load make a Purchase',
      name: 'code_error_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Failed to use a video player`
  String get code_error_video_player {
    return Intl.message(
      'Failed to use a video player',
      name: 'code_error_video_player',
      desc: '',
      args: [],
    );
  }

  /// `Failed set push notifications config`
  String get code_error_push_notifications_config {
    return Intl.message(
      'Failed set push notifications config',
      name: 'code_error_push_notifications_config',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load workout`
  String get code_error_load_explore {
    return Intl.message(
      'Failed to load workout',
      name: 'code_error_load_explore',
      desc: '',
      args: [],
    );
  }

  /// `Operation timed out`
  String get code_error_timeout {
    return Intl.message(
      'Operation timed out',
      name: 'code_error_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Error message not defined`
  String get code_error_unknown {
    return Intl.message(
      'Error message not defined',
      name: 'code_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Notification Permission`
  String get dialog_ios_permission_title {
    return Intl.message(
      'Notification Permission',
      name: 'dialog_ios_permission_title',
      desc: '',
      args: [],
    );
  }

  /// `To receive Reminders grant Notification permission in Settings`
  String get dialog_ios_permission_description {
    return Intl.message(
      'To receive Reminders grant Notification permission in Settings',
      name: 'dialog_ios_permission_description',
      desc: '',
      args: [],
    );
  }

  /// `To Settings`
  String get dialog_ios_permission_positive_text {
    return Intl.message(
      'To Settings',
      name: 'dialog_ios_permission_positive_text',
      desc: '',
      args: [],
    );
  }

  /// `Reset all filters`
  String get reset_all_filters {
    return Intl.message(
      'Reset all filters',
      name: 'reset_all_filters',
      desc: '',
      args: [],
    );
  }

  /// `WOD Type`
  String get wod_type {
    return Intl.message(
      'WOD Type',
      name: 'wod_type',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Time`
  String get estimated_type {
    return Intl.message(
      'Estimated Time',
      name: 'estimated_type',
      desc: '',
      args: [],
    );
  }

  /// `Difficulty`
  String get difficulty {
    return Intl.message(
      'Difficulty',
      name: 'difficulty',
      desc: '',
      args: [],
    );
  }

  /// `No workouts found`
  String get no_workouts_found {
    return Intl.message(
      'No workouts found',
      name: 'no_workouts_found',
      desc: '',
      args: [],
    );
  }

  /// `Single Workouts`
  String get single_workouts {
    return Intl.message(
      'Single Workouts',
      name: 'single_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Clear filters`
  String get clear_filters {
    return Intl.message(
      'Clear filters',
      name: 'clear_filters',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Share result Error`
  String get share_result_error {
    return Intl.message(
      'Share result Error',
      name: 'share_result_error',
      desc: '',
      args: [],
    );
  }

  /// `Music and voice`
  String get music_and_voice {
    return Intl.message(
      'Music and voice',
      name: 'music_and_voice',
      desc: '',
      args: [],
    );
  }

  /// `Only music`
  String get only_music {
    return Intl.message(
      'Only music',
      name: 'only_music',
      desc: '',
      args: [],
    );
  }

  /// `Only voice`
  String get only_voice {
    return Intl.message(
      'Only voice',
      name: 'only_voice',
      desc: '',
      args: [],
    );
  }

  /// `Sound off`
  String get sound_off {
    return Intl.message(
      'Sound off',
      name: 'sound_off',
      desc: '',
      args: [],
    );
  }

  /// `Not defined`
  String get not_defined {
    return Intl.message(
      'Not defined',
      name: 'not_defined',
      desc: '',
      args: [],
    );
  }

  /// `play`
  String get play {
    return Intl.message(
      'play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `pause`
  String get pause {
    return Intl.message(
      'pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Mute all sounds`
  String get mute_all_sounds {
    return Intl.message(
      'Mute all sounds',
      name: 'mute_all_sounds',
      desc: '',
      args: [],
    );
  }

  /// `Not now`
  String get not_now {
    return Intl.message(
      'Not now',
      name: 'not_now',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get exercises {
    return Intl.message(
      'Exercises',
      name: 'exercises',
      desc: '',
      args: [],
    );
  }

  /// `exercises`
  String get sm_exercise {
    return Intl.message(
      'exercises',
      name: 'sm_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Sharing`
  String get sharing {
    return Intl.message(
      'Sharing',
      name: 'sharing',
      desc: '',
      args: [],
    );
  }

  /// `Storage`
  String get storage {
    return Intl.message(
      'Storage',
      name: 'storage',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get sound {
    return Intl.message(
      'Sound',
      name: 'sound',
      desc: '',
      args: [],
    );
  }

  /// `Sounds`
  String get sounds {
    return Intl.message(
      'Sounds',
      name: 'sounds',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `points`
  String get points {
    return Intl.message(
      'points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points_upper {
    return Intl.message(
      'Points',
      name: 'points_upper',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get completed {
    return Intl.message(
      'completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Skill learned`
  String get skill_learned {
    return Intl.message(
      'Skill learned',
      name: 'skill_learned',
      desc: '',
      args: [],
    );
  }

  /// `Share Results`
  String get share_results {
    return Intl.message(
      'Share Results',
      name: 'share_results',
      desc: '',
      args: [],
    );
  }

  /// `Total time`
  String get total_time {
    return Intl.message(
      'Total time',
      name: 'total_time',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Step`
  String get step {
    return Intl.message(
      'Step',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `change`
  String get change {
    return Intl.message(
      'change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change_capitalize {
    return Intl.message(
      'Change',
      name: 'change_capitalize',
      desc: '',
      args: [],
    );
  }

  /// `Your Environmental Life`
  String get your_environmental_life {
    return Intl.message(
      'Your Environmental Life',
      name: 'your_environmental_life',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get see_more {
    return Intl.message(
      'See more',
      name: 'see_more',
      desc: '',
      args: [],
    );
  }

  /// `story`
  String get story {
    return Intl.message(
      'story',
      name: 'story',
      desc: '',
      args: [],
    );
  }

  /// `min read`
  String get min_read {
    return Intl.message(
      'min read',
      name: 'min_read',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Wisdom`
  String get wisdom {
    return Intl.message(
      'Wisdom',
      name: 'wisdom',
      desc: '',
      args: [],
    );
  }

  /// `Workout`
  String get workout {
    return Intl.message(
      'Workout',
      name: 'workout',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get show {
    return Intl.message(
      'Show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Round`
  String get round {
    return Intl.message(
      'Round',
      name: 'round',
      desc: '',
      args: [],
    );
  }

  /// `Rounds`
  String get rounds {
    return Intl.message(
      'Rounds',
      name: 'rounds',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Rest`
  String get rest {
    return Intl.message(
      'Rest',
      name: 'rest',
      desc: '',
      args: [],
    );
  }

  /// `Well done`
  String get well_done {
    return Intl.message(
      'Well done',
      name: 'well_done',
      desc: '',
      args: [],
    );
  }

  /// `Emotional`
  String get emotional {
    return Intl.message(
      'Emotional',
      name: 'emotional',
      desc: '',
      args: [],
    );
  }

  /// `Physical`
  String get physical {
    return Intl.message(
      'Physical',
      name: 'physical',
      desc: '',
      args: [],
    );
  }

  /// `Environmental`
  String get environmental {
    return Intl.message(
      'Environmental',
      name: 'environmental',
      desc: '',
      args: [],
    );
  }

  /// `Intellectual`
  String get intellectual {
    return Intl.message(
      'Intellectual',
      name: 'intellectual',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `Spiritual`
  String get spiritual {
    return Intl.message(
      'Spiritual',
      name: 'spiritual',
      desc: '',
      args: [],
    );
  }

  /// `Body`
  String get body {
    return Intl.message(
      'Body',
      name: 'body',
      desc: '',
      args: [],
    );
  }

  /// `Mind`
  String get mind {
    return Intl.message(
      'Mind',
      name: 'mind',
      desc: '',
      args: [],
    );
  }

  /// `Spirit`
  String get spirit {
    return Intl.message(
      'Spirit',
      name: 'spirit',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get premium {
    return Intl.message(
      'Premium',
      name: 'premium',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get school {
    return Intl.message(
      'School',
      name: 'school',
      desc: '',
      args: [],
    );
  }

  /// `Totalfit`
  String get totalfit {
    return Intl.message(
      'Totalfit',
      name: 'totalfit',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Healthy Habits`
  String get healthy_habits {
    return Intl.message(
      'Healthy Habits',
      name: 'healthy_habits',
      desc: '',
      args: [],
    );
  }

  /// `Choose Habits`
  String get choose_habits {
    return Intl.message(
      'Choose Habits',
      name: 'choose_habits',
      desc: '',
      args: [],
    );
  }

  /// `Choose and track habits that you want to develop`
  String get choose_track_habits {
    return Intl.message(
      'Choose and track habits that you want to develop',
      name: 'choose_track_habits',
      desc: '',
      args: [],
    );
  }

  /// `Estimate your technique`
  String get estimate_your_technique {
    return Intl.message(
      'Estimate your technique',
      name: 'estimate_your_technique',
      desc: '',
      args: [],
    );
  }

  /// `Poor. I can do it better! I should rewatch the tutorial and try again.`
  String get skill_tate_text_1 {
    return Intl.message(
      'Poor. I can do it better! I should rewatch the tutorial and try again.',
      name: 'skill_tate_text_1',
      desc: '',
      args: [],
    );
  }

  /// `Fair. Well, I am thinking maybe I should try the exercise one more time.`
  String get skill_tate_text_2 {
    return Intl.message(
      'Fair. Well, I am thinking maybe I should try the exercise one more time.',
      name: 'skill_tate_text_2',
      desc: '',
      args: [],
    );
  }

  /// `Good. Ok, I got it, but i need to work more on my technique.`
  String get skill_tate_text_3 {
    return Intl.message(
      'Good. Ok, I got it, but i need to work more on my technique.',
      name: 'skill_tate_text_3',
      desc: '',
      args: [],
    );
  }

  /// `Very good. It was awesome! I am full of energy and ready to reach new heights.`
  String get skill_tate_text_4 {
    return Intl.message(
      'Very good. It was awesome! I am full of energy and ready to reach new heights.',
      name: 'skill_tate_text_4',
      desc: '',
      args: [],
    );
  }

  /// `Excellent. I pulled off a miracle! I nailed it on the very first take.`
  String get skill_tate_text_5 {
    return Intl.message(
      'Excellent. I pulled off a miracle! I nailed it on the very first take.',
      name: 'skill_tate_text_5',
      desc: '',
      args: [],
    );
  }

  /// `Tap here to watch tutorial for the exercise`
  String get tap_here_to_watch_workout {
    return Intl.message(
      'Tap here to watch tutorial for the exercise',
      name: 'tap_here_to_watch_workout',
      desc: '',
      args: [],
    );
  }

  /// `Tap here to pause workout and see the menu`
  String get tap_here_to_pause_workout {
    return Intl.message(
      'Tap here to pause workout and see the menu',
      name: 'tap_here_to_pause_workout',
      desc: '',
      args: [],
    );
  }

  /// `Tap here or swipe left to go to the previous exercise`
  String get tap_here_or_swipe_prev_exercise {
    return Intl.message(
      'Tap here or swipe left to go to the previous exercise',
      name: 'tap_here_or_swipe_prev_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Tap here or swipe left to go to the next exercise`
  String get tap_here_or_swipe_next_exercise {
    return Intl.message(
      'Tap here or swipe left to go to the next exercise',
      name: 'tap_here_or_swipe_next_exercise',
      desc: '',
      args: [],
    );
  }

  /// `No items found`
  String get no_item_found {
    return Intl.message(
      'No items found',
      name: 'no_item_found',
      desc: '',
      args: [],
    );
  }

  /// `The list is currently empty.`
  String get list_empty {
    return Intl.message(
      'The list is currently empty.',
      name: 'list_empty',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get select_country {
    return Intl.message(
      'Select country',
      name: 'select_country',
      desc: '',
      args: [],
    );
  }

  /// `No country selected`
  String get no_country_selected {
    return Intl.message(
      'No country selected',
      name: 'no_country_selected',
      desc: '',
      args: [],
    );
  }

  /// `Choose or take photo`
  String get choose_or_take_photo {
    return Intl.message(
      'Choose or take photo',
      name: 'choose_or_take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Only Latin input is supported`
  String get only_latin_supported {
    return Intl.message(
      'Only Latin input is supported',
      name: 'only_latin_supported',
      desc: '',
      args: [],
    );
  }

  /// `Warm-up completed`
  String get warm_up_completed {
    return Intl.message(
      'Warm-up completed',
      name: 'warm_up_completed',
      desc: '',
      args: [],
    );
  }

  /// `Go on and learn a new skill!`
  String get go_and_learn_new_skill {
    return Intl.message(
      'Go on and learn a new skill!',
      name: 'go_and_learn_new_skill',
      desc: '',
      args: [],
    );
  }

  /// `Go on and start this workout!`
  String get go_and_learn_new_workout {
    return Intl.message(
      'Go on and start this workout!',
      name: 'go_and_learn_new_workout',
      desc: '',
      args: [],
    );
  }

  /// `You’re a great athlete. On the next screen you can share your results with your community to train your social sphere`
  String get youre_greate_athlete {
    return Intl.message(
      'You’re a great athlete. On the next screen you can share your results with your community to train your social sphere',
      name: 'youre_greate_athlete',
      desc: '',
      args: [],
    );
  }

  /// `I'm thankful for`
  String get im_thankful_for {
    return Intl.message(
      'I\'m thankful for',
      name: 'im_thankful_for',
      desc: '',
      args: [],
    );
  }

  /// `I'm stressed about`
  String get im_stressed_about {
    return Intl.message(
      'I\'m stressed about',
      name: 'im_stressed_about',
      desc: '',
      args: [],
    );
  }

  /// `Don’t worry! We won’t share your thoughts with anyone`
  String get dont_worry_share_thoughts_anyone {
    return Intl.message(
      'Don’t worry! We won’t share your thoughts with anyone',
      name: 'dont_worry_share_thoughts_anyone',
      desc: '',
      args: [],
    );
  }

  /// `Quit workout`
  String get quit_workout {
    return Intl.message(
      'Quit workout',
      name: 'quit_workout',
      desc: '',
      args: [],
    );
  }

  /// `WOD Result`
  String get wod_result {
    return Intl.message(
      'WOD Result',
      name: 'wod_result',
      desc: '',
      args: [],
    );
  }

  /// `Final Time`
  String get final_time {
    return Intl.message(
      'Final Time',
      name: 'final_time',
      desc: '',
      args: [],
    );
  }

  /// `No equipment`
  String get no_equipment {
    return Intl.message(
      'No equipment',
      name: 'no_equipment',
      desc: '',
      args: [],
    );
  }

  /// `Watch tutorial`
  String get watch_tutorial {
    return Intl.message(
      'Watch tutorial',
      name: 'watch_tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Your progress`
  String get your_progress {
    return Intl.message(
      'Your progress',
      name: 'your_progress',
      desc: '',
      args: [],
    );
  }

  /// `Your result is`
  String get your_result_is {
    return Intl.message(
      'Your result is',
      name: 'your_result_is',
      desc: '',
      args: [],
    );
  }

  /// `Your result`
  String get your_result {
    return Intl.message(
      'Your result',
      name: 'your_result',
      desc: '',
      args: [],
    );
  }

  /// `No, change`
  String get no_change {
    return Intl.message(
      'No, change',
      name: 'no_change',
      desc: '',
      args: [],
    );
  }

  /// `Make a deep inhales and`
  String get make_deep_inhales_and {
    return Intl.message(
      'Make a deep inhales and',
      name: 'make_deep_inhales_and',
      desc: '',
      args: [],
    );
  }

  /// `a deep exhales.`
  String get deep_exhales {
    return Intl.message(
      'a deep exhales.',
      name: 'deep_exhales',
      desc: '',
      args: [],
    );
  }

  /// `Use this panel to quickly add words to your text`
  String get use_panel_quickly_words_text {
    return Intl.message(
      'Use this panel to quickly add words to your text',
      name: 'use_panel_quickly_words_text',
      desc: '',
      args: [],
    );
  }

  /// `Use the words above to write faster`
  String get use_words_above_write_faster {
    return Intl.message(
      'Use the words above to write faster',
      name: 'use_words_above_write_faster',
      desc: '',
      args: [],
    );
  }

  /// `Please, answer the question..`
  String get please_answer_question {
    return Intl.message(
      'Please, answer the question..',
      name: 'please_answer_question',
      desc: '',
      args: [],
    );
  }

  /// `How are you feeling today?`
  String get how_are_you_feeling_today {
    return Intl.message(
      'How are you feeling today?',
      name: 'how_are_you_feeling_today',
      desc: '',
      args: [],
    );
  }

  /// `Assess your technique`
  String get assess_your_technique {
    return Intl.message(
      'Assess your technique',
      name: 'assess_your_technique',
      desc: '',
      args: [],
    );
  }

  /// `Watch tutorial and do the exercise`
  String get watch_tutorial_exercise {
    return Intl.message(
      'Watch tutorial and do the exercise',
      name: 'watch_tutorial_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update state!`
  String get filed_update_state {
    return Intl.message(
      'Failed to update state!',
      name: 'filed_update_state',
      desc: '',
      args: [],
    );
  }

  /// `To start the workout, please first download the exercises`
  String get to_start_workout_download_exercises {
    return Intl.message(
      'To start the workout, please first download the exercises',
      name: 'to_start_workout_download_exercises',
      desc: '',
      args: [],
    );
  }

  /// `I will statement will help you to train your spirit.`
  String get i_will_statement_will_help_you {
    return Intl.message(
      'I will statement will help you to train your spirit.',
      name: 'i_will_statement_will_help_you',
      desc: '',
      args: [],
    );
  }

  /// `What does this story motivate you to do?`
  String get what_does_story_motivate {
    return Intl.message(
      'What does this story motivate you to do?',
      name: 'what_does_story_motivate',
      desc: '',
      args: [],
    );
  }

  /// `Write a simple action that you can complete in the next 24 hours`
  String get write_simple_action {
    return Intl.message(
      'Write a simple action that you can complete in the next 24 hours',
      name: 'write_simple_action',
      desc: '',
      args: [],
    );
  }

  /// `Story and Statements`
  String get story_and_statements {
    return Intl.message(
      'Story and Statements',
      name: 'story_and_statements',
      desc: '',
      args: [],
    );
  }

  /// `Statements`
  String get statements {
    return Intl.message(
      'Statements',
      name: 'statements',
      desc: '',
      args: [],
    );
  }

  /// `How long have you been outside today?`
  String get how_long_outside {
    return Intl.message(
      'How long have you been outside today?',
      name: 'how_long_outside',
      desc: '',
      args: [],
    );
  }

  /// `Tap to change`
  String get tap_to_change {
    return Intl.message(
      'Tap to change',
      name: 'tap_to_change',
      desc: '',
      args: [],
    );
  }

  /// `Environmental Sphere`
  String get environment_share {
    return Intl.message(
      'Environmental Sphere',
      name: 'environment_share',
      desc: '',
      args: [],
    );
  }

  /// `Healthy Lifestyle Habit`
  String get healthy_lifestyle_habit {
    return Intl.message(
      'Healthy Lifestyle Habit',
      name: 'healthy_lifestyle_habit',
      desc: '',
      args: [],
    );
  }

  /// `Program finished`
  String get program_finished {
    return Intl.message(
      'Program finished',
      name: 'program_finished',
      desc: '',
      args: [],
    );
  }

  /// `Monthly community habit`
  String get monthly_community_habit {
    return Intl.message(
      'Monthly community habit',
      name: 'monthly_community_habit',
      desc: '',
      args: [],
    );
  }

  /// `You can choose two more habits that you want to practice in next month`
  String get you_can_choose_two_more_habits {
    return Intl.message(
      'You can choose two more habits that you want to practice in next month',
      name: 'you_can_choose_two_more_habits',
      desc: '',
      args: [],
    );
  }

  /// `Become stronger\nwith more weight`
  String get become_stronger_with_more_weight {
    return Intl.message(
      'Become stronger\nwith more weight',
      name: 'become_stronger_with_more_weight',
      desc: '',
      args: [],
    );
  }

  /// `Quit Program`
  String get quit_program {
    return Intl.message(
      'Quit Program',
      name: 'quit_program',
      desc: '',
      args: [],
    );
  }

  /// `help and support`
  String get help_and_support {
    return Intl.message(
      'help and support',
      name: 'help_and_support',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update Profile`
  String get filed_to_update_profile {
    return Intl.message(
      'Failed to update Profile',
      name: 'filed_to_update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Support & Feedback`
  String get support_and_feedback {
    return Intl.message(
      'Support & Feedback',
      name: 'support_and_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Sound settings`
  String get sounds_settings {
    return Intl.message(
      'Sound settings',
      name: 'sounds_settings',
      desc: '',
      args: [],
    );
  }

  /// `Tap «Clear Storage» to delete all downloaded workouts and free up `
  String get tap_clear_storage {
    return Intl.message(
      'Tap «Clear Storage» to delete all downloaded workouts and free up ',
      name: 'tap_clear_storage',
      desc: '',
      args: [],
    );
  }

  /// ` on your device.`
  String get clear_storage_device {
    return Intl.message(
      ' on your device.',
      name: 'clear_storage_device',
      desc: '',
      args: [],
    );
  }

  /// `Clear Storage`
  String get clear_storage {
    return Intl.message(
      'Clear Storage',
      name: 'clear_storage',
      desc: '',
      args: [],
    );
  }

  /// `Body Training`
  String get reason_body_title_ios {
    return Intl.message(
      'Body Training',
      name: 'reason_body_title_ios',
      desc: '',
      args: [],
    );
  }

  /// `Workouts and Programs`
  String get reason_body_subtitle_ios {
    return Intl.message(
      'Workouts and Programs',
      name: 'reason_body_subtitle_ios',
      desc: '',
      args: [],
    );
  }

  /// `Mind Development`
  String get reason_mind_title_ios {
    return Intl.message(
      'Mind Development',
      name: 'reason_mind_title_ios',
      desc: '',
      args: [],
    );
  }

  /// `Quizzes, Healthy Habits, and Breathing`
  String get reason_mind_subtitle_ios {
    return Intl.message(
      'Quizzes, Healthy Habits, and Breathing',
      name: 'reason_mind_subtitle_ios',
      desc: '',
      args: [],
    );
  }

  /// `Spirit Growing`
  String get reason_spirit_title_ios {
    return Intl.message(
      'Spirit Growing',
      name: 'reason_spirit_title_ios',
      desc: '',
      args: [],
    );
  }

  /// `Stories and Daily Reflection`
  String get reason_spirit_subtitle_ios {
    return Intl.message(
      'Stories and Daily Reflection',
      name: 'reason_spirit_subtitle_ios',
      desc: '',
      args: [],
    );
  }

  /// `Workouts`
  String get reason_body_title_android {
    return Intl.message(
      'Workouts',
      name: 'reason_body_title_android',
      desc: '',
      args: [],
    );
  }

  /// `Workouts and Plans`
  String get reason_body_subtitle_android {
    return Intl.message(
      'Workouts and Plans',
      name: 'reason_body_subtitle_android',
      desc: '',
      args: [],
    );
  }

  /// `Mind Development`
  String get reason_mind_title_android {
    return Intl.message(
      'Mind Development',
      name: 'reason_mind_title_android',
      desc: '',
      args: [],
    );
  }

  /// `Mind Development`
  String get reason_mind_subtitle_android {
    return Intl.message(
      'Mind Development',
      name: 'reason_mind_subtitle_android',
      desc: '',
      args: [],
    );
  }

  /// `Getting Calm`
  String get reason_spirit_title_android {
    return Intl.message(
      'Getting Calm',
      name: 'reason_spirit_title_android',
      desc: '',
      args: [],
    );
  }

  /// `Getting Calm`
  String get reason_spirit_subtitle_android {
    return Intl.message(
      'Getting Calm',
      name: 'reason_spirit_subtitle_android',
      desc: '',
      args: [],
    );
  }

  /// `Workouts of the Day`
  String get push_notifications_title_wod {
    return Intl.message(
      'Workouts of the Day',
      name: 'push_notifications_title_wod',
      desc: '',
      args: [],
    );
  }

  /// `Daily Readings`
  String get push_notifications_title_daily_reading {
    return Intl.message(
      'Daily Readings',
      name: 'push_notifications_title_daily_reading',
      desc: '',
      args: [],
    );
  }

  /// `Updates and New Features`
  String get push_notifications_title_updates_and_news {
    return Intl.message(
      'Updates and New Features',
      name: 'push_notifications_title_updates_and_news',
      desc: '',
      args: [],
    );
  }

  /// `Allow all notifications`
  String get push_notifications_title_all {
    return Intl.message(
      'Allow all notifications',
      name: 'push_notifications_title_all',
      desc: '',
      args: [],
    );
  }

  /// `Totalfit Hexagon`
  String get hexagon_onboarding_hint_title_one {
    return Intl.message(
      'Totalfit Hexagon',
      name: 'hexagon_onboarding_hint_title_one',
      desc: '',
      args: [],
    );
  }

  /// `Track your progress in 3 main areas: Body, Mind and Spirit.`
  String get hexagon_onboarding_hint_description_one {
    return Intl.message(
      'Track your progress in 3 main areas: Body, Mind and Spirit.',
      name: 'hexagon_onboarding_hint_description_one',
      desc: '',
      args: [],
    );
  }

  /// `Train your Body`
  String get hexagon_onboarding_hint_title_two {
    return Intl.message(
      'Train your Body',
      name: 'hexagon_onboarding_hint_title_two',
      desc: '',
      args: [],
    );
  }

  /// `Complete workouts, start burning calories and keep track of how much time you spend outside.`
  String get hexagon_onboarding_hint_description_two {
    return Intl.message(
      'Complete workouts, start burning calories and keep track of how much time you spend outside.',
      name: 'hexagon_onboarding_hint_description_two',
      desc: '',
      args: [],
    );
  }

  /// `Grow Mind`
  String get hexagon_onboarding_hint_title_three {
    return Intl.message(
      'Grow Mind',
      name: 'hexagon_onboarding_hint_title_three',
      desc: '',
      args: [],
    );
  }

  /// `Gain wisdom, relax and focus through breathing practices and develop sustainable healthy habits.`
  String get hexagon_onboarding_hint_description_three {
    return Intl.message(
      'Gain wisdom, relax and focus through breathing practices and develop sustainable healthy habits.',
      name: 'hexagon_onboarding_hint_description_three',
      desc: '',
      args: [],
    );
  }

  /// `Develop Spirit`
  String get hexagon_onboarding_hint_title_four {
    return Intl.message(
      'Develop Spirit',
      name: 'hexagon_onboarding_hint_title_four',
      desc: '',
      args: [],
    );
  }

  /// `Read motivational stories and create actionable items for accountably.`
  String get hexagon_onboarding_hint_description_four {
    return Intl.message(
      'Read motivational stories and create actionable items for accountably.',
      name: 'hexagon_onboarding_hint_description_four',
      desc: '',
      args: [],
    );
  }

  /// `Grow Everyday`
  String get hexagon_onboarding_hint_title_five {
    return Intl.message(
      'Grow Everyday',
      name: 'hexagon_onboarding_hint_title_five',
      desc: '',
      args: [],
    );
  }

  /// `Fill your Totalfit Hexagon everyday for Optimal Health.`
  String get hexagon_onboarding_hint_description_five {
    return Intl.message(
      'Fill your Totalfit Hexagon everyday for Optimal Health.',
      name: 'hexagon_onboarding_hint_description_five',
      desc: '',
      args: [],
    );
  }

  /// `Your First Step`
  String get hexagon_onboarding_hint_title_six {
    return Intl.message(
      'Your First Step',
      name: 'hexagon_onboarding_hint_title_six',
      desc: '',
      args: [],
    );
  }

  /// `Your customized training begins now! Practicing Breathing will help to reduce stress and increase concentration.`
  String get hexagon_onboarding_hint_description_six {
    return Intl.message(
      'Your customized training begins now! Practicing Breathing will help to reduce stress and increase concentration.',
      name: 'hexagon_onboarding_hint_description_six',
      desc: '',
      args: [],
    );
  }

  /// `What's new`
  String get new_feature_screen_title {
    return Intl.message(
      'What\'s new',
      name: 'new_feature_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Workout of the Month`
  String get explore_wod_of_month {
    return Intl.message(
      'Workout of the Month',
      name: 'explore_wod_of_month',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get explore_see_all {
    return Intl.message(
      'See all',
      name: 'explore_see_all',
      desc: '',
      args: [],
    );
  }

  /// `Explore more`
  String get explore_more {
    return Intl.message(
      'Explore more',
      name: 'explore_more',
      desc: '',
      args: [],
    );
  }

  /// `Excercise Library`
  String get explore_btn_exercise_title {
    return Intl.message(
      'Excercise Library',
      name: 'explore_btn_exercise_title',
      desc: '',
      args: [],
    );
  }

  /// `250+ excercises`
  String get explore_btn_exercise_description {
    return Intl.message(
      '250+ excercises',
      name: 'explore_btn_exercise_description',
      desc: '',
      args: [],
    );
  }

  /// `All Workouts`
  String get explore_btn_wod_title {
    return Intl.message(
      'All Workouts',
      name: 'explore_btn_wod_title',
      desc: '',
      args: [],
    );
  }

  /// `100+ workouts`
  String get explore_btn_wod_description {
    return Intl.message(
      '100+ workouts',
      name: 'explore_btn_wod_description',
      desc: '',
      args: [],
    );
  }

  /// `Get weekly workout plan`
  String get explore_btn_plan_title {
    return Intl.message(
      'Get weekly workout plan',
      name: 'explore_btn_plan_title',
      desc: '',
      args: [],
    );
  }

  /// `START 6 week program`
  String get explore_btn_plan_description {
    return Intl.message(
      'START 6 week program',
      name: 'explore_btn_plan_description',
      desc: '',
      args: [],
    );
  }

  /// `Workout Collections`
  String get explore_error_title {
    return Intl.message(
      'Workout Collections',
      name: 'explore_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load workout. Tap to try again.`
  String get explore_error_btn_text {
    return Intl.message(
      'Failed to load workout. Tap to try again.',
      name: 'explore_error_btn_text',
      desc: '',
      args: [],
    );
  }

  /// `Lose weight`
  String get goal_weight_title {
    return Intl.message(
      'Lose weight',
      name: 'goal_weight_title',
      desc: '',
      args: [],
    );
  }

  /// `Build muscle`
  String get goal_muscle_title {
    return Intl.message(
      'Build muscle',
      name: 'goal_muscle_title',
      desc: '',
      args: [],
    );
  }

  /// `Stay in shape`
  String get goal_shape_title {
    return Intl.message(
      'Stay in shape',
      name: 'goal_shape_title',
      desc: '',
      args: [],
    );
  }

  /// `Gym training`
  String get goal_training_title {
    return Intl.message(
      'Gym training',
      name: 'goal_training_title',
      desc: '',
      args: [],
    );
  }

  /// `I am strong and fit`
  String get user_level_1 {
    return Intl.message(
      'I am strong and fit',
      name: 'user_level_1',
      desc: '',
      args: [],
    );
  }

  /// `I workout sometimes`
  String get user_level_2 {
    return Intl.message(
      'I workout sometimes',
      name: 'user_level_2',
      desc: '',
      args: [],
    );
  }

  /// `I’ve just started`
  String get user_level_3 {
    return Intl.message(
      'I’ve just started',
      name: 'user_level_3',
      desc: '',
      args: [],
    );
  }

  /// `2 weeks`
  String get user_duration_1 {
    return Intl.message(
      '2 weeks',
      name: 'user_duration_1',
      desc: '',
      args: [],
    );
  }

  /// `4 weeks`
  String get user_duration_2 {
    return Intl.message(
      '4 weeks',
      name: 'user_duration_2',
      desc: '',
      args: [],
    );
  }

  /// `6 weeks`
  String get user_duration_3 {
    return Intl.message(
      '6 weeks',
      name: 'user_duration_3',
      desc: '',
      args: [],
    );
  }

  /// `No Equipment`
  String get equipment_item_no_equipment {
    return Intl.message(
      'No Equipment',
      name: 'equipment_item_no_equipment',
      desc: '',
      args: [],
    );
  }

  /// `Kettlebell`
  String get equipment_item_kettlebell {
    return Intl.message(
      'Kettlebell',
      name: 'equipment_item_kettlebell',
      desc: '',
      args: [],
    );
  }

  /// `Barbell`
  String get equipment_item_barbell {
    return Intl.message(
      'Barbell',
      name: 'equipment_item_barbell',
      desc: '',
      args: [],
    );
  }

  /// `Air Bike`
  String get equipment_item_air_bike {
    return Intl.message(
      'Air Bike',
      name: 'equipment_item_air_bike',
      desc: '',
      args: [],
    );
  }

  /// `Rowing Machine`
  String get equipment_item_rowing_machine {
    return Intl.message(
      'Rowing Machine',
      name: 'equipment_item_rowing_machine',
      desc: '',
      args: [],
    );
  }

  /// `Bench`
  String get equipment_item_bench {
    return Intl.message(
      'Bench',
      name: 'equipment_item_bench',
      desc: '',
      args: [],
    );
  }

  /// `Box`
  String get equipment_item_box {
    return Intl.message(
      'Box',
      name: 'equipment_item_box',
      desc: '',
      args: [],
    );
  }

  /// `Pull-up Bar`
  String get equipment_item_pull_up_bar {
    return Intl.message(
      'Pull-up Bar',
      name: 'equipment_item_pull_up_bar',
      desc: '',
      args: [],
    );
  }

  /// `Dumbbells`
  String get equipment_item_dumbbells {
    return Intl.message(
      'Dumbbells',
      name: 'equipment_item_dumbbells',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing your profile`
  String get create_plan_stage_1 {
    return Intl.message(
      'Analyzing your profile',
      name: 'create_plan_stage_1',
      desc: '',
      args: [],
    );
  }

  /// `Estimating your metabolic age`
  String get create_plan_stage_2 {
    return Intl.message(
      'Estimating your metabolic age',
      name: 'create_plan_stage_2',
      desc: '',
      args: [],
    );
  }

  /// `Adapting the plan to your busy schedule`
  String get create_plan_stage_3 {
    return Intl.message(
      'Adapting the plan to your busy schedule',
      name: 'create_plan_stage_3',
      desc: '',
      args: [],
    );
  }

  /// `Selecting suitable workouts`
  String get create_plan_stage_4 {
    return Intl.message(
      'Selecting suitable workouts',
      name: 'create_plan_stage_4',
      desc: '',
      args: [],
    );
  }

  /// `About You`
  String get onboarding_title_1 {
    return Intl.message(
      'About You',
      name: 'onboarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Main Goal`
  String get onboarding_title_2 {
    return Intl.message(
      'Main Goal',
      name: 'onboarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Your plan to optimal health is ready`
  String get onboarding_summary_title {
    return Intl.message(
      'Your plan to optimal health is ready',
      name: 'onboarding_summary_title',
      desc: '',
      args: [],
    );
  }

  /// `Workouts, readings and self-development practices are ready to change your life`
  String get onboarding_summary_subtitle {
    return Intl.message(
      'Workouts, readings and self-development practices are ready to change your life',
      name: 'onboarding_summary_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your everyday plan`
  String get onboarding_summary_plan_category_title {
    return Intl.message(
      'Your everyday plan',
      name: 'onboarding_summary_plan_category_title',
      desc: '',
      args: [],
    );
  }

  /// `Let's start`
  String get onboarding_summary_button_text {
    return Intl.message(
      'Let\'s start',
      name: 'onboarding_summary_button_text',
      desc: '',
      args: [],
    );
  }

  /// `{duration} week`
  String onboarding_summary_program_duration(Object duration) {
    return Intl.message(
      '$duration week',
      name: 'onboarding_summary_program_duration',
      desc: '',
      args: [duration],
    );
  }

  /// `Train your Body`
  String get onboarding_summary_body_title {
    return Intl.message(
      'Train your Body',
      name: 'onboarding_summary_body_title',
      desc: '',
      args: [],
    );
  }

  /// `Weekly workout plan`
  String get onboarding_summary_body_subtitle {
    return Intl.message(
      'Weekly workout plan',
      name: 'onboarding_summary_body_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `30 min a day`
  String get onboarding_summary_body_duration {
    return Intl.message(
      '30 min a day',
      name: 'onboarding_summary_body_duration',
      desc: '',
      args: [],
    );
  }

  /// `Develop your Spirit`
  String get onboarding_summary_spirit_title {
    return Intl.message(
      'Develop your Spirit',
      name: 'onboarding_summary_spirit_title',
      desc: '',
      args: [],
    );
  }

  /// `Daily Stories & Healthy Habits`
  String get onboarding_summary_spirit_subtitle {
    return Intl.message(
      'Daily Stories & Healthy Habits',
      name: 'onboarding_summary_spirit_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `2 min a day`
  String get onboarding_summary_spirit_duration {
    return Intl.message(
      '2 min a day',
      name: 'onboarding_summary_spirit_duration',
      desc: '',
      args: [],
    );
  }

  /// `Grow your Mind`
  String get onboarding_summary_mind_title {
    return Intl.message(
      'Grow your Mind',
      name: 'onboarding_summary_mind_title',
      desc: '',
      args: [],
    );
  }

  /// `Breathing & Daily Wisdom`
  String get onboarding_summary_mind_subtitle {
    return Intl.message(
      'Breathing & Daily Wisdom',
      name: 'onboarding_summary_mind_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `1 min a day`
  String get onboarding_summary_mind_duration {
    return Intl.message(
      '1 min a day',
      name: 'onboarding_summary_mind_duration',
      desc: '',
      args: [],
    );
  }

  /// `Get My Plan`
  String get onboarding_summary_cta {
    return Intl.message(
      'Get My Plan',
      name: 'onboarding_summary_cta',
      desc: '',
      args: [],
    );
  }

  /// `Hey there!\nWhat’s your name?`
  String get onboarding_user_name_screen_title {
    return Intl.message(
      'Hey there!\nWhat’s your name?',
      name: 'onboarding_user_name_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Whats your gender?`
  String get onboarding_user_gender_screen_title {
    return Intl.message(
      'Whats your gender?',
      name: 'onboarding_user_gender_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What’s your birthday?`
  String get onboarding_user_birthday_screen_title {
    return Intl.message(
      'What’s your birthday?',
      name: 'onboarding_user_birthday_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What’s your height?`
  String get onboarding_user_height_screen_title {
    return Intl.message(
      'What’s your height?',
      name: 'onboarding_user_height_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What’s your weight?`
  String get onboarding_user_weight_screen_title {
    return Intl.message(
      'What’s your weight?',
      name: 'onboarding_user_weight_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What’s your desired weight?`
  String get onboarding_user_desired_weight_screen_title {
    return Intl.message(
      'What’s your desired weight?',
      name: 'onboarding_user_desired_weight_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Which is the most important to you?`
  String get onboarding_user_reason_ios_screen_title {
    return Intl.message(
      'Which is the most important to you?',
      name: 'onboarding_user_reason_ios_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What should we focus on together?`
  String get onboarding_user_reason_android_screen_title {
    return Intl.message(
      'What should we focus on together?',
      name: 'onboarding_user_reason_android_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose answers you want your fasting plan to focus on:`
  String get onboarding_user_reason_screen_subtitle {
    return Intl.message(
      'Choose answers you want your fasting plan to focus on:',
      name: 'onboarding_user_reason_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose 1 — 3 healthy habits you’d like to develop`
  String get onboarding_user_habit_screen_subtitle {
    return Intl.message(
      'Choose 1 — 3 healthy habits you’d like to develop',
      name: 'onboarding_user_habit_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Avoid using gadgets 30 minutes before bedtime`
  String get onboarding_user_habit_screen_habit_1 {
    return Intl.message(
      'Avoid using gadgets 30 minutes before bedtime',
      name: 'onboarding_user_habit_screen_habit_1',
      desc: '',
      args: [],
    );
  }

  /// `Keep track of hours you slept tonight`
  String get onboarding_user_habit_screen_habit_2 {
    return Intl.message(
      'Keep track of hours you slept tonight',
      name: 'onboarding_user_habit_screen_habit_2',
      desc: '',
      args: [],
    );
  }

  /// `Don't drink coffee 4-6 hours before sleep`
  String get onboarding_user_habit_screen_habit_3 {
    return Intl.message(
      'Don`t drink coffee 4-6 hours before sleep',
      name: 'onboarding_user_habit_screen_habit_3',
      desc: '',
      args: [],
    );
  }

  /// `Don't drink alcohol 2-3 hours before sleep`
  String get onboarding_user_habit_screen_habit_4 {
    return Intl.message(
      'Don`t drink alcohol 2-3 hours before sleep',
      name: 'onboarding_user_habit_screen_habit_4',
      desc: '',
      args: [],
    );
  }

  /// `Drink 2l water every day`
  String get onboarding_user_habit_screen_habit_5 {
    return Intl.message(
      'Drink 2l water every day',
      name: 'onboarding_user_habit_screen_habit_5',
      desc: '',
      args: [],
    );
  }

  /// `Practice deep breathing breaks during the day`
  String get onboarding_user_habit_screen_habit_6 {
    return Intl.message(
      'Practice deep breathing breaks during the day',
      name: 'onboarding_user_habit_screen_habit_6',
      desc: '',
      args: [],
    );
  }

  /// `Warm up your neck muscles while brushing your teeth`
  String get onboarding_user_habit_screen_habit_7 {
    return Intl.message(
      'Warm up your neck muscles while brushing your teeth',
      name: 'onboarding_user_habit_screen_habit_7',
      desc: '',
      args: [],
    );
  }

  /// `Before going to sleep, take five minutes to stretch and work on mobility`
  String get onboarding_user_habit_screen_habit_8 {
    return Intl.message(
      'Before going to sleep, take five minutes to stretch and work on mobility',
      name: 'onboarding_user_habit_screen_habit_8',
      desc: '',
      args: [],
    );
  }

  /// `Stretch while watching TV`
  String get onboarding_user_habit_screen_habit_9 {
    return Intl.message(
      'Stretch while watching TV',
      name: 'onboarding_user_habit_screen_habit_9',
      desc: '',
      args: [],
    );
  }

  /// `Exclude sugar from all of your meals today`
  String get onboarding_user_habit_screen_habit_10 {
    return Intl.message(
      'Exclude sugar from all of your meals today',
      name: 'onboarding_user_habit_screen_habit_10',
      desc: '',
      args: [],
    );
  }

  /// `What’s your fitness goals?`
  String get onboarding_user_goal_screen_title {
    return Intl.message(
      'What’s your fitness goals?',
      name: 'onboarding_user_goal_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What’s your current activity level?`
  String get onboarding_user_level_screen_title {
    return Intl.message(
      'What’s your current activity level?',
      name: 'onboarding_user_level_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose the duration of your fitness plan?`
  String get onboarding_user_plan_duration_screen_title {
    return Intl.message(
      'Choose the duration of your fitness plan?',
      name: 'onboarding_user_plan_duration_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Which days are you going to workout?`
  String get onboarding_user_workout_day_screen_title {
    return Intl.message(
      'Which days are you going to workout?',
      name: 'onboarding_user_workout_day_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `What equipment do you have?`
  String get onboarding_user_equipment_screen_title {
    return Intl.message(
      'What equipment do you have?',
      name: 'onboarding_user_equipment_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `mood tracking`
  String get progress_screen_mood_card_title {
    return Intl.message(
      'mood tracking',
      name: 'progress_screen_mood_card_title',
      desc: '',
      args: [],
    );
  }

  /// `How do you feel?`
  String get progress_screen_mood_card_description {
    return Intl.message(
      'How do you feel?',
      name: 'progress_screen_mood_card_description',
      desc: '',
      args: [],
    );
  }

  /// `I want to receive Totalfit news and special offers`
  String get sign_up_email_allowance {
    return Intl.message(
      'I want to receive Totalfit news and special offers',
      name: 'sign_up_email_allowance',
      desc: '',
      args: [],
    );
  }

  /// `Let us be your New Year’s resolution!`
  String get discount_card_title_new_year {
    return Intl.message(
      'Let us be your New Year’s resolution!',
      name: 'discount_card_title_new_year',
      desc: '',
      args: [],
    );
  }

  /// `Hop over to our Easter Sale!`
  String get discount_card_title_easter {
    return Intl.message(
      'Hop over to our Easter Sale!',
      name: 'discount_card_title_easter',
      desc: '',
      args: [],
    );
  }

  /// `It’s your lucky\nday today!`
  String get discount_card_title_st_patrick {
    return Intl.message(
      'It’s your lucky\nday today!',
      name: 'discount_card_title_st_patrick',
      desc: '',
      args: [],
    );
  }

  /// `Get {price} Discount`
  String discount_card_btn_text(Object price) {
    return Intl.message(
      'Get $price Discount',
      name: 'discount_card_btn_text',
      desc: '',
      args: [price],
    );
  }

  /// `New Year Discount!\n {price} for Annual Subscription`
  String discount_screen_title_new_year(Object price) {
    return Intl.message(
      'New Year Discount!\n $price for Annual Subscription',
      name: 'discount_screen_title_new_year',
      desc: '',
      args: [price],
    );
  }

  /// `Hop over to our Easter Sale!\n {price} for Annual Subscription`
  String discount_screen_title_easter(Object price) {
    return Intl.message(
      'Hop over to our Easter Sale!\n $price for Annual Subscription',
      name: 'discount_screen_title_easter',
      desc: '',
      args: [price],
    );
  }

  /// `Lucky Day Discount!\n {price} for Annual Subscription`
  String discount_screen_title_st_patrick(Object price) {
    return Intl.message(
      'Lucky Day Discount!\n $price for Annual Subscription',
      name: 'discount_screen_title_st_patrick',
      desc: '',
      args: [price],
    );
  }

  /// `{price}/Year`
  String discount_screen_price(Object price) {
    return Intl.message(
      '$price/Year',
      name: 'discount_screen_price',
      desc: '',
      args: [price],
    );
  }

  /// `Subscription Terms`
  String get discount_screen_subscription_terms {
    return Intl.message(
      'Subscription Terms',
      name: 'discount_screen_subscription_terms',
      desc: '',
      args: [],
    );
  }

  /// `Your Apple ID payment method will be automatically charged. The subscription renews automatically at the end of each period, until you cancel. To avoid being charged, cancel the subscription in your iTunes & App Store/Apple ID account settings at least 24 hours before the current subscription period. If you are unsure how to cancel a subscription, please visit the Apple Support website. Note that deleting the app does not cancel your subscriptions. You may wish to make a printscreen of this information for your reference.`
  String get discount_screen_subscription_text {
    return Intl.message(
      'Your Apple ID payment method will be automatically charged. The subscription renews automatically at the end of each period, until you cancel. To avoid being charged, cancel the subscription in your iTunes & App Store/Apple ID account settings at least 24 hours before the current subscription period. If you are unsure how to cancel a subscription, please visit the Apple Support website. Note that deleting the app does not cancel your subscriptions. You may wish to make a printscreen of this information for your reference.',
      name: 'discount_screen_subscription_text',
      desc: '',
      args: [],
    );
  }

  /// `By continuing you accept our`
  String get discount_screen_subscription_accept {
    return Intl.message(
      'By continuing you accept our',
      name: 'discount_screen_subscription_accept',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get discount_screen_subscription_privacy {
    return Intl.message(
      'Privacy Policy',
      name: 'discount_screen_subscription_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get discount_screen_subscription_terms_of_use {
    return Intl.message(
      'Terms of Use',
      name: 'discount_screen_subscription_terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get discount_screen_subscription_and {
    return Intl.message(
      'and',
      name: 'discount_screen_subscription_and',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe for `
  String get discount_screen_btn_text {
    return Intl.message(
      'Subscribe for ',
      name: 'discount_screen_btn_text',
      desc: '',
      args: [],
    );
  }

  /// `Sorry you have no discounts for your account yet.`
  String get discount_screen_error_text {
    return Intl.message(
      'Sorry you have no discounts for your account yet.',
      name: 'discount_screen_error_text',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get discount_screen_popup_title {
    return Intl.message(
      'Information',
      name: 'discount_screen_popup_title',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get workout_chip_level {
    return Intl.message(
      'Information',
      name: 'workout_chip_level',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with Google`
  String get sign_up_with_google_btn {
    return Intl.message(
      'Sign Up with Google',
      name: 'sign_up_with_google_btn',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Google`
  String get sign_in_with_google_btn {
    return Intl.message(
      'Sign In with Google',
      name: 'sign_in_with_google_btn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with Apple`
  String get sign_up_with_apple_btn {
    return Intl.message(
      'Sign Up with Apple',
      name: 'sign_up_with_apple_btn',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Apple`
  String get sign_in_with_apple_btn {
    return Intl.message(
      'Sign In with Apple',
      name: 'sign_in_with_apple_btn',
      desc: '',
      args: [],
    );
  }

  /// `By continuing you accept our`
  String get paywall_accept_privacy {
    return Intl.message(
      'By continuing you accept our',
      name: 'paywall_accept_privacy',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get paywall_accept_and {
    return Intl.message(
      'and',
      name: 'paywall_accept_and',
      desc: '',
      args: [],
    );
  }

  /// `subscription for`
  String get paywall_android_subscription {
    return Intl.message(
      'subscription for',
      name: 'paywall_android_subscription',
      desc: '',
      args: [],
    );
  }

  /// `after trial`
  String get paywall_android_subscription_after {
    return Intl.message(
      'after trial',
      name: 'paywall_android_subscription_after',
      desc: '',
      args: [],
    );
  }

  /// `This subscription gives you unlimited access to all content and features of this app. If you don't cancel before the trial ends you will be automatically charged {price} each {time} until you cancel.`
  String paywall_android_subscription_description(Object price, Object time) {
    return Intl.message(
      'This subscription gives you unlimited access to all content and features of this app. If you don\'t cancel before the trial ends you will be automatically charged $price each $time until you cancel.',
      name: 'paywall_android_subscription_description',
      desc: '',
      args: [price, time],
    );
  }

  /// `{title} subscription for {price}/{time} after trial`
  String paywall_android_subscription_title(
      Object title, Object price, Object time) {
    return Intl.message(
      '$title subscription for $price/$time after trial',
      name: 'paywall_android_subscription_title',
      desc: '',
      args: [title, price, time],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
