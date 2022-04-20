


import 'mood_localizations.dart';

/// The translations for English (`en`).
class MoodLocalizationsEn extends MoodLocalizations {
  MoodLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get moodScreenEmptyCategory => 'Category not loaded';

  @override
  String get moodScreenTitle => 'How do you feel today?';

  @override
  String get moodScreenStepTitle => 'Looks like, you are';

  @override
  String get moodScreenSelectionDescription => 'But which words describe\nyour feelings best?';

  @override
  String get moodScreenReasonDescription => 'Now! What makes you feel that way?';

  @override
  String get moodScreenEmptySelection => 'Selection data not loaded';

  @override
  String get moodScreenEmptyReason => 'Reason data not loaded';

  @override
  String get moodDialogErrorTitle => 'Failure';
}
