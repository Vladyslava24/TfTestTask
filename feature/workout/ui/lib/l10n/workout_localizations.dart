
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'workout_localizations_en.dart';

/// Callers can lookup localized strings with an instance of WorkoutLocalizations returned
/// by `WorkoutLocalizations.of(context)`.
///
/// Applications need to include `WorkoutLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'l10n/workout_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: WorkoutLocalizations.localizationsDelegates,
///   supportedLocales: WorkoutLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the WorkoutLocalizations.supportedLocales
/// property.
abstract class WorkoutLocalizations {
  WorkoutLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static WorkoutLocalizations of(BuildContext context) {
    return Localizations.of<WorkoutLocalizations>(context, WorkoutLocalizations)!;
  }

  static const LocalizationsDelegate<WorkoutLocalizations> delegate = _WorkoutLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @exercise_category_title_warm_up.
  ///
  /// In en, this message translates to:
  /// **'Warm-up'**
  String get exercise_category_title_warm_up;

  /// No description provided for @exercise_category_title_skill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get exercise_category_title_skill;

  /// No description provided for @exercise_category_title_wod.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get exercise_category_title_wod;

  /// No description provided for @exercise_category_title_cooldown.
  ///
  /// In en, this message translates to:
  /// **'Stretching Session'**
  String get exercise_category_title_cooldown;

  /// No description provided for @exercise_category_title_rest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get exercise_category_title_rest;

  /// No description provided for @exercise_category_subtitle_warm_up_multiple_rounds.
  ///
  /// In en, this message translates to:
  /// **'{roundCount} rounds • {exerciseCount} exercises'**
  String exercise_category_subtitle_warm_up_multiple_rounds(int roundCount, int exerciseCount);

  /// No description provided for @exercise_category_subtitle_warm_up.
  ///
  /// In en, this message translates to:
  /// **'{count} exercises'**
  String exercise_category_subtitle_warm_up(int count);

  /// No description provided for @exercise_category_subtitle_wod.
  ///
  /// In en, this message translates to:
  /// **'{wodType} • {quantity} {metrics} • {wodCount} exercises'**
  String exercise_category_subtitle_wod(String wodType, int quantity, String metrics, int wodCount);

  /// No description provided for @all_exercise.
  ///
  /// In en, this message translates to:
  /// **'exercise'**
  String get all_exercise;

  /// No description provided for @all_exercises.
  ///
  /// In en, this message translates to:
  /// **'exercises'**
  String get all_exercises;

  /// No description provided for @all_round.
  ///
  /// In en, this message translates to:
  /// **'round'**
  String get all_round;

  /// No description provided for @all_rounds.
  ///
  /// In en, this message translates to:
  /// **'rounds'**
  String get all_rounds;

  /// No description provided for @exercise_category_subtitle_cooldown.
  ///
  /// In en, this message translates to:
  /// **'{count} exercises'**
  String exercise_category_subtitle_cooldown(int count);

  /// No description provided for @preview_audio_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get preview_audio_settings_title;

  /// No description provided for @preview_audio_settings_button_title.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get preview_audio_settings_button_title;

  /// No description provided for @preview_audio_settings_item_title1.
  ///
  /// In en, this message translates to:
  /// **'Voice and Sounds'**
  String get preview_audio_settings_item_title1;

  /// No description provided for @preview_audio_settings_item_title2.
  ///
  /// In en, this message translates to:
  /// **'Voice and Music'**
  String get preview_audio_settings_item_title2;

  /// No description provided for @preview_audio_settings_item_title3.
  ///
  /// In en, this message translates to:
  /// **'Sound Off (Only Music)'**
  String get preview_audio_settings_item_title3;

  /// No description provided for @preview_workout_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get preview_workout_settings_title;

  /// No description provided for @preview_workout_settings_button_title.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get preview_workout_settings_button_title;

  /// No description provided for @preview_workout_settings_item_title1.
  ///
  /// In en, this message translates to:
  /// **'Turn Off Warm-Up'**
  String get preview_workout_settings_item_title1;

  /// No description provided for @preview_workout_settings_item_title2.
  ///
  /// In en, this message translates to:
  /// **'Turn Off Stretching Session'**
  String get preview_workout_settings_item_title2;

  /// No description provided for @preview_workout_button_download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get preview_workout_button_download;

  /// No description provided for @preview_workout_button_loading.
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get preview_workout_button_loading;

  /// No description provided for @preview_workout_button_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get preview_workout_button_start;

  /// No description provided for @preview_unlock_workout.
  ///
  /// In en, this message translates to:
  /// **'Unlock Workout'**
  String get preview_unlock_workout;

  /// No description provided for @preview_workout_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get preview_workout_details;

  /// No description provided for @preview_workout_equipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get preview_workout_equipment;

  /// No description provided for @exercise_button_result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get exercise_button_result;

  /// No description provided for @exercise_button_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get exercise_button_finish;

  /// No description provided for @workout_summary_time_score_title.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get workout_summary_time_score_title;

  /// No description provided for @workout_summary_workout_result_title.
  ///
  /// In en, this message translates to:
  /// **'Workout score'**
  String get workout_summary_workout_result_title;

  /// No description provided for @workout_summary_calories.
  ///
  /// In en, this message translates to:
  /// **'Estimated\ncalories burned'**
  String get workout_summary_calories;

  /// No description provided for @workout_summary_duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get workout_summary_duration;

  /// No description provided for @workout_summary_exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get workout_summary_exercises;

  /// No description provided for @workout_summary_rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get workout_summary_rounds;

  /// No description provided for @workout_summary_round.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get workout_summary_round;

  /// No description provided for @workout_summary_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get workout_summary_share;

  /// No description provided for @workout_summary_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get workout_summary_finish;

  /// No description provided for @exercise_button_skip_rest.
  ///
  /// In en, this message translates to:
  /// **'Skip Rest'**
  String get exercise_button_skip_rest;

  /// No description provided for @onboarding_button_text.
  ///
  /// In en, this message translates to:
  /// **'Push ups'**
  String get onboarding_button_text;

  /// No description provided for @onboarding_step_one_advice.
  ///
  /// In en, this message translates to:
  /// **'Tap here to pause\n workout and see the menu'**
  String get onboarding_step_one_advice;

  /// No description provided for @onboarding_step_two_advice.
  ///
  /// In en, this message translates to:
  /// **'Tap here to watch tutorial\n for the exercise'**
  String get onboarding_step_two_advice;

  /// No description provided for @onboarding_step_three_advice1.
  ///
  /// In en, this message translates to:
  /// **'Tap here or swipe\n left to go to the previous\n exercise'**
  String get onboarding_step_three_advice1;

  /// No description provided for @onboarding_step_three_advice2.
  ///
  /// In en, this message translates to:
  /// **'Tap here or swipe\n right to go to the next\n exercise'**
  String get onboarding_step_three_advice2;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @workout_flow_exercise_overlay_title.
  ///
  /// In en, this message translates to:
  /// **'Next exercise'**
  String get workout_flow_exercise_overlay_title;

  /// No description provided for @workout_congratulation_title.
  ///
  /// In en, this message translates to:
  /// **'Well Done!'**
  String get workout_congratulation_title;

  /// No description provided for @workout_congratulation_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re a great athlete!'**
  String get workout_congratulation_subtitle;

  /// No description provided for @workout_congratulation_action_btn_text.
  ///
  /// In en, this message translates to:
  /// **'Watch result'**
  String get workout_congratulation_action_btn_text;
}

class _WorkoutLocalizationsDelegate extends LocalizationsDelegate<WorkoutLocalizations> {
  const _WorkoutLocalizationsDelegate();

  @override
  Future<WorkoutLocalizations> load(Locale locale) {
    return SynchronousFuture<WorkoutLocalizations>(lookupWorkoutLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_WorkoutLocalizationsDelegate old) => false;
}

WorkoutLocalizations lookupWorkoutLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return WorkoutLocalizationsEn();
  }

  throw FlutterError(
    'WorkoutLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
