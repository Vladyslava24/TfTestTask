


import 'mood_localizations.dart';

/// The translations for Russian (`ru`).
class MoodLocalizationsRu extends MoodLocalizations {
  MoodLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get moodScreenEmptyCategory => 'Категория не загружена';

  @override
  String get moodScreenTitle => 'How do you feel today?';

  @override
  String get moodScreenStepTitle => 'Looks like, you are {category}';

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
