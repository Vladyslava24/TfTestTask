
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'mood_localizations_en.dart';
import 'mood_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of MoodLocalizations returned
/// by `MoodLocalizations.of(context)`.
///
/// Applications need to include `MoodLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'l10n/mood_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MoodLocalizations.localizationsDelegates,
///   supportedLocales: MoodLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MoodLocalizations.supportedLocales
/// property.
abstract class MoodLocalizations {
  MoodLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MoodLocalizations of(BuildContext context) {
    return Localizations.of<MoodLocalizations>(context, MoodLocalizations)!;
  }

  static const LocalizationsDelegate<MoodLocalizations> delegate = _MoodLocalizationsDelegate();

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
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @moodScreenEmptyCategory.
  ///
  /// In en, this message translates to:
  /// **'Category not loaded'**
  String get moodScreenEmptyCategory;

  /// No description provided for @moodScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'How do you feel today?'**
  String get moodScreenTitle;

  /// No description provided for @moodScreenStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Looks like, you are'**
  String get moodScreenStepTitle;

  /// No description provided for @moodScreenSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'But which words describe\nyour feelings best?'**
  String get moodScreenSelectionDescription;

  /// No description provided for @moodScreenReasonDescription.
  ///
  /// In en, this message translates to:
  /// **'Now! What makes you feel that way?'**
  String get moodScreenReasonDescription;

  /// No description provided for @moodScreenEmptySelection.
  ///
  /// In en, this message translates to:
  /// **'Selection data not loaded'**
  String get moodScreenEmptySelection;

  /// No description provided for @moodScreenEmptyReason.
  ///
  /// In en, this message translates to:
  /// **'Reason data not loaded'**
  String get moodScreenEmptyReason;

  /// No description provided for @moodDialogErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get moodDialogErrorTitle;
}

class _MoodLocalizationsDelegate extends LocalizationsDelegate<MoodLocalizations> {
  const _MoodLocalizationsDelegate();

  @override
  Future<MoodLocalizations> load(Locale locale) {
    return SynchronousFuture<MoodLocalizations>(lookupMoodLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_MoodLocalizationsDelegate old) => false;
}

MoodLocalizations lookupMoodLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return MoodLocalizationsEn();
    case 'ru': return MoodLocalizationsRu();
  }

  throw FlutterError(
    'MoodLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
