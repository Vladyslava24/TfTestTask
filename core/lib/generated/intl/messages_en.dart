// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(price) => "Get ${price} Discount";

  static String m1(price) => "${price}/Year";

  static String m2(price) =>
      "Hop over to our Easter Sale!\n ${price} for Annual Subscription";

  static String m3(price) =>
      "New Year Discount!\n ${price} for Annual Subscription";

  static String m4(price) =>
      "Lucky Day Discount!\n ${price} for Annual Subscription";

  static String m5(count) => "${count} exercises";

  static String m6(count) => "${count} exercises";

  static String m7(roundCount, exerciseCount) =>
      "${roundCount} rounds • ${exerciseCount} exercises";

  static String m8(exerciseCount) => "1 round • ${exerciseCount} exercises";

  static String m9(wodType, quantity, metrics, wodCount) =>
      "${wodType} • ${quantity} ${metrics} • ${wodCount} exercises";

  static String m10(duration) => "${duration} week";

  static String m11(price, time) =>
      "This subscription gives you unlimited access to all content and features of this app. If you don\'t cancel before the trial ends you will be automatically charged ${price} each ${time} until you cancel.";

  static String m12(title, price, time) =>
      "${title} subscription for ${price}/${time} after trial";

  static String m13(discount) => "Save ${discount} %";

  static String m14(price) => "${price} / weekly";

  static String m15(number) => "Week ${number}";

  static String m16(date) => "Starts on ${date}";

  static String m17(duration) => "${duration} minutes";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "all__OK": MessageLookupByLibrary.simpleMessage("OK"),
        "all__alright": MessageLookupByLibrary.simpleMessage("ALRIGHT"),
        "all__cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "all__continue": MessageLookupByLibrary.simpleMessage("Continue"),
        "all__dont": MessageLookupByLibrary.simpleMessage("don’t"),
        "all__error": MessageLookupByLibrary.simpleMessage("Error"),
        "all__error_network_description": MessageLookupByLibrary.simpleMessage(
            "Please check your internet connection and try again."),
        "all__error_network_title":
            MessageLookupByLibrary.simpleMessage("No internet"),
        "all__error_unexpected_description":
            MessageLookupByLibrary.simpleMessage(
                "Ooops... Something went wrong. Try again later."),
        "all__error_unexpected_title":
            MessageLookupByLibrary.simpleMessage("Server error"),
        "all__finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "all__next": MessageLookupByLibrary.simpleMessage("Next"),
        "all__privacy_policy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "all__quit": MessageLookupByLibrary.simpleMessage("quit"),
        "all__retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "all__save": MessageLookupByLibrary.simpleMessage("Save"),
        "all__skill": MessageLookupByLibrary.simpleMessage("skill"),
        "all__skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "all__terms_of_use":
            MessageLookupByLibrary.simpleMessage("Terms Of Use"),
        "all__today": MessageLookupByLibrary.simpleMessage("today"),
        "amrap_tooltip_text": MessageLookupByLibrary.simpleMessage(
            "Finish AMRAP workout before countdown if you’ve already done."),
        "assess_your_technique":
            MessageLookupByLibrary.simpleMessage("Assess your technique"),
        "become_stronger_with_more_weight":
            MessageLookupByLibrary.simpleMessage(
                "Become stronger\nwith more weight"),
        "birthday": MessageLookupByLibrary.simpleMessage("Birthday"),
        "body": MessageLookupByLibrary.simpleMessage("Body"),
        "bodyWeight": MessageLookupByLibrary.simpleMessage("BODYWEIGHT"),
        "bottom_menu__explore": MessageLookupByLibrary.simpleMessage("Explore"),
        "bottom_menu__profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "bottom_menu__programs":
            MessageLookupByLibrary.simpleMessage("Programs"),
        "bottom_menu__progress":
            MessageLookupByLibrary.simpleMessage("Progress"),
        "bottom_menu__workouts":
            MessageLookupByLibrary.simpleMessage("Workouts"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "change": MessageLookupByLibrary.simpleMessage("change"),
        "change_capitalize": MessageLookupByLibrary.simpleMessage("Change"),
        "choose_habits": MessageLookupByLibrary.simpleMessage("Choose Habits"),
        "choose_or_take_photo":
            MessageLookupByLibrary.simpleMessage("Choose or take photo"),
        "choose_program_days__app_bar_title":
            MessageLookupByLibrary.simpleMessage("Choose days"),
        "choose_program_days__friday":
            MessageLookupByLibrary.simpleMessage("Friday"),
        "choose_program_days__monday":
            MessageLookupByLibrary.simpleMessage("Monday"),
        "choose_program_days__saturday":
            MessageLookupByLibrary.simpleMessage("Saturday"),
        "choose_program_days__sunday":
            MessageLookupByLibrary.simpleMessage("Sunday"),
        "choose_program_days__thursday":
            MessageLookupByLibrary.simpleMessage("Thursday"),
        "choose_program_days__tuesday":
            MessageLookupByLibrary.simpleMessage("Tuesday"),
        "choose_program_days__wednesday":
            MessageLookupByLibrary.simpleMessage("Wednesday"),
        "choose_program_level__advanced":
            MessageLookupByLibrary.simpleMessage("Advanced"),
        "choose_program_level__advanced_description":
            MessageLookupByLibrary.simpleMessage("I train over 3 times a week"),
        "choose_program_level__app_bar_title":
            MessageLookupByLibrary.simpleMessage("Choose your fitness level"),
        "choose_program_level__beginner":
            MessageLookupByLibrary.simpleMessage("Beginner"),
        "choose_program_level__beginner_description":
            MessageLookupByLibrary.simpleMessage("I am new to training"),
        "choose_program_level__intermediate":
            MessageLookupByLibrary.simpleMessage("Intermediate"),
        "choose_program_level__intermediate_description":
            MessageLookupByLibrary.simpleMessage("I train 1–2 times a week"),
        "choose_program_number_of_weeks_screen__app_bar_title":
            MessageLookupByLibrary.simpleMessage("Choose number of weeks"),
        "choose_program_number_of_weeks_screen__weeks":
            MessageLookupByLibrary.simpleMessage("weeks"),
        "choose_track_habits": MessageLookupByLibrary.simpleMessage(
            "Choose and track habits that you want to develop"),
        "city": MessageLookupByLibrary.simpleMessage("City"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "clear_filters": MessageLookupByLibrary.simpleMessage("Clear filters"),
        "clear_storage": MessageLookupByLibrary.simpleMessage("Clear Storage"),
        "clear_storage_device":
            MessageLookupByLibrary.simpleMessage(" on your device."),
        "code_error_auth_canceled":
            MessageLookupByLibrary.simpleMessage("Authorization canceled"),
        "code_error_auth_conflict":
            MessageLookupByLibrary.simpleMessage("User already exists"),
        "code_error_auth_failed": MessageLookupByLibrary.simpleMessage(
            "Failed to authorize. Check your credentials"),
        "code_error_auth_social_failed": MessageLookupByLibrary.simpleMessage(
            "Failed to sign up. Probably you\'ve already registered"),
        "code_error_auth_token_expired":
            MessageLookupByLibrary.simpleMessage("Token expired"),
        "code_error_build_program_ui_items":
            MessageLookupByLibrary.simpleMessage(
                "Failed to build Program UI items"),
        "code_error_db": MessageLookupByLibrary.simpleMessage(
            "Failed to access local database"),
        "code_error_delete_workout_progress":
            MessageLookupByLibrary.simpleMessage(
                "Failed to delete Workout Progress"),
        "code_error_fetch_active_program": MessageLookupByLibrary.simpleMessage(
            "Failed to fetch active program"),
        "code_error_finish_program":
            MessageLookupByLibrary.simpleMessage("Failed to finish Program"),
        "code_error_illegal_authorized_user_number":
            MessageLookupByLibrary.simpleMessage(
                "Illegal authorized user number"),
        "code_error_interrupt_program":
            MessageLookupByLibrary.simpleMessage("Failed to interrupt Program"),
        "code_error_load_explore":
            MessageLookupByLibrary.simpleMessage("Failed to load workout"),
        "code_error_load_program":
            MessageLookupByLibrary.simpleMessage("Failed to load Program"),
        "code_error_load_workout_progress":
            MessageLookupByLibrary.simpleMessage(
                "Failed to load Workout Progress"),
        "code_error_load_workout_summary": MessageLookupByLibrary.simpleMessage(
            "Failed to load Workout Summary"),
        "code_error_network":
            MessageLookupByLibrary.simpleMessage("Network error"),
        "code_error_no_authorized_user":
            MessageLookupByLibrary.simpleMessage("No authorized user"),
        "code_error_parse_response":
            MessageLookupByLibrary.simpleMessage("Failed to parse response"),
        "code_error_program_not_running":
            MessageLookupByLibrary.simpleMessage("Program not running"),
        "code_error_purchase": MessageLookupByLibrary.simpleMessage(
            "Failed to load make a Purchase"),
        "code_error_push_notifications_config":
            MessageLookupByLibrary.simpleMessage(
                "Failed set push notifications config"),
        "code_error_save_profile":
            MessageLookupByLibrary.simpleMessage("Failed to save profile"),
        "code_error_save_profile_image": MessageLookupByLibrary.simpleMessage(
            "Failed to save profile image"),
        "code_error_start_program":
            MessageLookupByLibrary.simpleMessage("Failed to start Program"),
        "code_error_timeout":
            MessageLookupByLibrary.simpleMessage("Operation timed out"),
        "code_error_unknown":
            MessageLookupByLibrary.simpleMessage("Error message not defined"),
        "code_error_update_program":
            MessageLookupByLibrary.simpleMessage("Failed to update Program"),
        "code_error_video_player": MessageLookupByLibrary.simpleMessage(
            "Failed to use a video player"),
        "completed": MessageLookupByLibrary.simpleMessage("completed"),
        "completed_workouts":
            MessageLookupByLibrary.simpleMessage("Completed workouts"),
        "country": MessageLookupByLibrary.simpleMessage("Country"),
        "create_plan_stage_1":
            MessageLookupByLibrary.simpleMessage("Analyzing your profile"),
        "create_plan_stage_2": MessageLookupByLibrary.simpleMessage(
            "Estimating your metabolic age"),
        "create_plan_stage_3": MessageLookupByLibrary.simpleMessage(
            "Adapting the plan to your busy schedule"),
        "create_plan_stage_4":
            MessageLookupByLibrary.simpleMessage("Selecting suitable workouts"),
        "deep_exhales": MessageLookupByLibrary.simpleMessage("a deep exhales."),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "develop_your_spirit":
            MessageLookupByLibrary.simpleMessage("Develop your Spirit"),
        "dialog__quit_your_current_program":
            MessageLookupByLibrary.simpleMessage(
                "Quit your current program to start a new one"),
        "dialog_error_login_title":
            MessageLookupByLibrary.simpleMessage("Login failed"),
        "dialog_error_recoverable_negative_text":
            MessageLookupByLibrary.simpleMessage("cancel"),
        "dialog_error_title": MessageLookupByLibrary.simpleMessage("Error!"),
        "dialog_ios_permission_description": MessageLookupByLibrary.simpleMessage(
            "To receive Reminders grant Notification permission in Settings"),
        "dialog_ios_permission_positive_text":
            MessageLookupByLibrary.simpleMessage("To Settings"),
        "dialog_ios_permission_title":
            MessageLookupByLibrary.simpleMessage("Notification Permission"),
        "dialog_quit_workout_description": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to quit your workout?"),
        "dialog_quit_workout_negative_text":
            MessageLookupByLibrary.simpleMessage("quit"),
        "dialog_quit_workout_title":
            MessageLookupByLibrary.simpleMessage("It’s not the end"),
        "difficulty": MessageLookupByLibrary.simpleMessage("Difficulty"),
        "discount_card_btn_text": m0,
        "discount_card_title_easter": MessageLookupByLibrary.simpleMessage(
            "Hop over to our Easter Sale!"),
        "discount_card_title_new_year": MessageLookupByLibrary.simpleMessage(
            "Let us be your New Year’s resolution!"),
        "discount_card_title_st_patrick":
            MessageLookupByLibrary.simpleMessage("It’s your lucky\nday today!"),
        "discount_screen_btn_text":
            MessageLookupByLibrary.simpleMessage("Subscribe for "),
        "discount_screen_error_text": MessageLookupByLibrary.simpleMessage(
            "Sorry you have no discounts for your account yet."),
        "discount_screen_popup_title":
            MessageLookupByLibrary.simpleMessage("Information"),
        "discount_screen_price": m1,
        "discount_screen_subscription_accept":
            MessageLookupByLibrary.simpleMessage(
                "By continuing you accept our"),
        "discount_screen_subscription_and":
            MessageLookupByLibrary.simpleMessage("and"),
        "discount_screen_subscription_privacy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "discount_screen_subscription_terms":
            MessageLookupByLibrary.simpleMessage("Subscription Terms"),
        "discount_screen_subscription_terms_of_use":
            MessageLookupByLibrary.simpleMessage("Terms of Use"),
        "discount_screen_subscription_text": MessageLookupByLibrary.simpleMessage(
            "Your Apple ID payment method will be automatically charged. The subscription renews automatically at the end of each period, until you cancel. To avoid being charged, cancel the subscription in your iTunes & App Store/Apple ID account settings at least 24 hours before the current subscription period. If you are unsure how to cancel a subscription, please visit the Apple Support website. Note that deleting the app does not cancel your subscriptions. You may wish to make a printscreen of this information for your reference."),
        "discount_screen_title_easter": m2,
        "discount_screen_title_new_year": m3,
        "discount_screen_title_st_patrick": m4,
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dont_worry_share_thoughts_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Don’t worry! We won’t share your thoughts with anyone"),
        "edit_profile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "emotional": MessageLookupByLibrary.simpleMessage("Emotional"),
        "entry_screen_already_have":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "entry_screen_btn_sign_in":
            MessageLookupByLibrary.simpleMessage("Sign In"),
        "entry_screen_btn_to_sign_up":
            MessageLookupByLibrary.simpleMessage("Continue with Email"),
        "entry_screen_i_agree_and":
            MessageLookupByLibrary.simpleMessage("\nand"),
        "entry_screen_i_agree_privacy":
            MessageLookupByLibrary.simpleMessage(" Privacy Policy"),
        "entry_screen_i_agree_to":
            MessageLookupByLibrary.simpleMessage("I agree to"),
        "entry_screen_sign_with":
            MessageLookupByLibrary.simpleMessage("Or Sign up with"),
        "entry_screen_terms_agree": MessageLookupByLibrary.simpleMessage(
            "Agree to Terms & Conditions and Privacy\nPolicy to continue"),
        "entry_screen_terms_button":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "entry_screen_terms_text": MessageLookupByLibrary.simpleMessage(
            "What’s covered in these terms. We know it’s tempting to skip these Terms of Service, but it’s important to establish what you can expect from us as you use Totalfit, and what we expect from you."),
        "entry_screen_terms_title":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
        "entry_screen_title": MessageLookupByLibrary.simpleMessage(
            "Train your Body,\nMind and Spirit\nin one app"),
        "environment_share":
            MessageLookupByLibrary.simpleMessage("Environmental Sphere"),
        "environmental": MessageLookupByLibrary.simpleMessage("Environmental"),
        "equipment": MessageLookupByLibrary.simpleMessage("Equipment"),
        "equipment_item_air_bike":
            MessageLookupByLibrary.simpleMessage("Air Bike"),
        "equipment_item_barbell":
            MessageLookupByLibrary.simpleMessage("Barbell"),
        "equipment_item_bench": MessageLookupByLibrary.simpleMessage("Bench"),
        "equipment_item_box": MessageLookupByLibrary.simpleMessage("Box"),
        "equipment_item_dumbbells":
            MessageLookupByLibrary.simpleMessage("Dumbbells"),
        "equipment_item_kettlebell":
            MessageLookupByLibrary.simpleMessage("Kettlebell"),
        "equipment_item_no_equipment":
            MessageLookupByLibrary.simpleMessage("No Equipment"),
        "equipment_item_pull_up_bar":
            MessageLookupByLibrary.simpleMessage("Pull-up Bar"),
        "equipment_item_rowing_machine":
            MessageLookupByLibrary.simpleMessage("Rowing Machine"),
        "errors_auth_canceled":
            MessageLookupByLibrary.simpleMessage("Authorization canceled."),
        "errors_field_empty":
            MessageLookupByLibrary.simpleMessage("The field must be not empty"),
        "errors_field_invalid_email":
            MessageLookupByLibrary.simpleMessage("Email address invalid"),
        "errors_field_invalid_password": MessageLookupByLibrary.simpleMessage(
            "Password should be at least 6 characters long"),
        "estimate_your_technique":
            MessageLookupByLibrary.simpleMessage("Estimate your technique"),
        "estimated_type":
            MessageLookupByLibrary.simpleMessage("Estimated Time"),
        "exercise": MessageLookupByLibrary.simpleMessage("Exercise"),
        "exercise_category_subtitle_cooldown": m5,
        "exercise_category_subtitle_warm_up": m6,
        "exercise_category_subtitle_warm_up_multiple_rounds": m7,
        "exercise_category_subtitle_warm_up_single_rounds": m8,
        "exercise_category_subtitle_wod": m9,
        "exercise_category_title_cooldown":
            MessageLookupByLibrary.simpleMessage("Cooldown"),
        "exercise_category_title_skill":
            MessageLookupByLibrary.simpleMessage("Skill"),
        "exercise_category_title_warm_up":
            MessageLookupByLibrary.simpleMessage("Warm-up"),
        "exercise_category_title_wod":
            MessageLookupByLibrary.simpleMessage("WOD"),
        "exercises": MessageLookupByLibrary.simpleMessage("Exercises"),
        "explore_btn_exercise_description":
            MessageLookupByLibrary.simpleMessage("250+ excercises"),
        "explore_btn_exercise_title":
            MessageLookupByLibrary.simpleMessage("Excercise Library"),
        "explore_btn_plan_description":
            MessageLookupByLibrary.simpleMessage("START 6 week program"),
        "explore_btn_plan_title":
            MessageLookupByLibrary.simpleMessage("Get weekly workout plan"),
        "explore_btn_wod_description":
            MessageLookupByLibrary.simpleMessage("100+ workouts"),
        "explore_btn_wod_title":
            MessageLookupByLibrary.simpleMessage("All Workouts"),
        "explore_error_btn_text": MessageLookupByLibrary.simpleMessage(
            "Failed to load workout. Tap to try again."),
        "explore_error_title":
            MessageLookupByLibrary.simpleMessage("Workout Collections"),
        "explore_more": MessageLookupByLibrary.simpleMessage("Explore more"),
        "explore_see_all": MessageLookupByLibrary.simpleMessage("See all"),
        "explore_wod_of_month":
            MessageLookupByLibrary.simpleMessage("Workout of the Month"),
        "filed_to_update_profile":
            MessageLookupByLibrary.simpleMessage("Failed to update Profile"),
        "filed_update_state":
            MessageLookupByLibrary.simpleMessage("Failed to update state!"),
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "final_time": MessageLookupByLibrary.simpleMessage("Final Time"),
        "first_name": MessageLookupByLibrary.simpleMessage("First name"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "gender": MessageLookupByLibrary.simpleMessage("Gender"),
        "go_and_learn_new_skill": MessageLookupByLibrary.simpleMessage(
            "Go on and learn a new skill!"),
        "go_and_learn_new_workout": MessageLookupByLibrary.simpleMessage(
            "Go on and start this workout!"),
        "goal_muscle_title":
            MessageLookupByLibrary.simpleMessage("Build muscle"),
        "goal_shape_title":
            MessageLookupByLibrary.simpleMessage("Stay in shape"),
        "goal_training_title":
            MessageLookupByLibrary.simpleMessage("Gym training"),
        "goal_weight_title":
            MessageLookupByLibrary.simpleMessage("Lose weight"),
        "grow_your_mind":
            MessageLookupByLibrary.simpleMessage("Grow your Mind"),
        "healthy_habits":
            MessageLookupByLibrary.simpleMessage("Healthy Habits"),
        "healthy_lifestyle_habit":
            MessageLookupByLibrary.simpleMessage("Healthy Lifestyle Habit"),
        "height": MessageLookupByLibrary.simpleMessage("Height"),
        "help_and_support":
            MessageLookupByLibrary.simpleMessage("help and support"),
        "hexagon_onboarding_hint_description_five":
            MessageLookupByLibrary.simpleMessage(
                "Fill your Totalfit Hexagon everyday for Optimal Health."),
        "hexagon_onboarding_hint_description_four":
            MessageLookupByLibrary.simpleMessage(
                "Read motivational stories and create actionable items for accountably."),
        "hexagon_onboarding_hint_description_one":
            MessageLookupByLibrary.simpleMessage(
                "Track your progress in 3 main areas: Body, Mind and Spirit."),
        "hexagon_onboarding_hint_description_six":
            MessageLookupByLibrary.simpleMessage(
                "Your customized training begins now! Practicing Breathing will help to reduce stress and increase concentration."),
        "hexagon_onboarding_hint_description_three":
            MessageLookupByLibrary.simpleMessage(
                "Gain wisdom, relax and focus through breathing practices and develop sustainable healthy habits."),
        "hexagon_onboarding_hint_description_two":
            MessageLookupByLibrary.simpleMessage(
                "Complete workouts, start burning calories and keep track of how much time you spend outside."),
        "hexagon_onboarding_hint_title_five":
            MessageLookupByLibrary.simpleMessage("Grow Everyday"),
        "hexagon_onboarding_hint_title_four":
            MessageLookupByLibrary.simpleMessage("Develop Spirit"),
        "hexagon_onboarding_hint_title_one":
            MessageLookupByLibrary.simpleMessage("Totalfit Hexagon"),
        "hexagon_onboarding_hint_title_six":
            MessageLookupByLibrary.simpleMessage("Your First Step"),
        "hexagon_onboarding_hint_title_three":
            MessageLookupByLibrary.simpleMessage("Grow Mind"),
        "hexagon_onboarding_hint_title_two":
            MessageLookupByLibrary.simpleMessage("Train your Body"),
        "hours": MessageLookupByLibrary.simpleMessage("hours"),
        "how_are_you_feeling_today":
            MessageLookupByLibrary.simpleMessage("How are you feeling today?"),
        "how_long_outside": MessageLookupByLibrary.simpleMessage(
            "How long have you been outside today?"),
        "i_will_statement_will_help_you": MessageLookupByLibrary.simpleMessage(
            "I will statement will help you to train your spirit."),
        "im_stressed_about":
            MessageLookupByLibrary.simpleMessage("I\'m stressed about"),
        "im_thankful_for":
            MessageLookupByLibrary.simpleMessage("I\'m thankful for"),
        "intellectual": MessageLookupByLibrary.simpleMessage("Intellectual"),
        "intro_fifth_screen_btn":
            MessageLookupByLibrary.simpleMessage("Let, start!"),
        "intro_fifth_screen_subtitle": MessageLookupByLibrary.simpleMessage(
            "We use a hexagon to show you daily and lifelong progress in 6 spheres:\nphisical, environmental, intellectual, social, spiritual and emotional"),
        "intro_fifth_screen_title":
            MessageLookupByLibrary.simpleMessage("Hexagon"),
        "intro_first_screen_subtitle": MessageLookupByLibrary.simpleMessage(
            "Welcome to Totalfit App! Do workouts, read useful stories and wisdoms and develop healthy habits every day."),
        "intro_first_screen_title": MessageLookupByLibrary.simpleMessage(
            "Body, Mind and Spirit training in one app"),
        "intro_fourth_screen_btn_cancel":
            MessageLookupByLibrary.simpleMessage("No, thanks"),
        "intro_fourth_screen_btn_confirm":
            MessageLookupByLibrary.simpleMessage("Cool, do it!"),
        "intro_fourth_screen_subtitle": MessageLookupByLibrary.simpleMessage(
            "We can send you notifications about workouts, healthy habits and new features"),
        "intro_fourth_screen_title":
            MessageLookupByLibrary.simpleMessage("Stay tuned"),
        "intro_second_screen_fitness_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "I want to get fit, strong and healthy"),
        "intro_second_screen_fitness_title":
            MessageLookupByLibrary.simpleMessage("Fitness"),
        "intro_second_screen_knowledge_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "I want to know more about my body"),
        "intro_second_screen_knowledge_title":
            MessageLookupByLibrary.simpleMessage("Knowledge"),
        "intro_second_screen_mindfulness_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "I want to stay focused and mindful"),
        "intro_second_screen_mindfulness_title":
            MessageLookupByLibrary.simpleMessage("Mindfulness"),
        "intro_second_screen_title":
            MessageLookupByLibrary.simpleMessage("What is your\n goal?"),
        "intro_third_screen_beginner_subtitle":
            MessageLookupByLibrary.simpleMessage("I just start my journey"),
        "intro_third_screen_medium_subtitle":
            MessageLookupByLibrary.simpleMessage("I train 1-2 times a week"),
        "intro_third_screen_pro_subtitle":
            MessageLookupByLibrary.simpleMessage("I train over 3 times a week"),
        "intro_third_screen_title": MessageLookupByLibrary.simpleMessage(
            "What is your\n fitness level?"),
        "last_name": MessageLookupByLibrary.simpleMessage("Last name"),
        "list_empty": MessageLookupByLibrary.simpleMessage(
            "The list is currently empty."),
        "log_out": MessageLookupByLibrary.simpleMessage("Log out"),
        "make_deep_inhales_and":
            MessageLookupByLibrary.simpleMessage("Make a deep inhales and"),
        "min": MessageLookupByLibrary.simpleMessage("min"),
        "min_read": MessageLookupByLibrary.simpleMessage("min read"),
        "mind": MessageLookupByLibrary.simpleMessage("Mind"),
        "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
        "monthly_community_habit":
            MessageLookupByLibrary.simpleMessage("Monthly community habit"),
        "music_and_voice":
            MessageLookupByLibrary.simpleMessage("Music and voice"),
        "mute_all_sounds":
            MessageLookupByLibrary.simpleMessage("Mute all sounds"),
        "new_feature_screen_title":
            MessageLookupByLibrary.simpleMessage("What\'s new"),
        "no_change": MessageLookupByLibrary.simpleMessage("No, change"),
        "no_country_selected":
            MessageLookupByLibrary.simpleMessage("No country selected"),
        "no_equipment": MessageLookupByLibrary.simpleMessage("No equipment"),
        "no_item_found": MessageLookupByLibrary.simpleMessage("No items found"),
        "no_workouts_found":
            MessageLookupByLibrary.simpleMessage("No workouts found"),
        "not_defined": MessageLookupByLibrary.simpleMessage("Not defined"),
        "not_now": MessageLookupByLibrary.simpleMessage("Not now"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notifications_settings":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "onboarding_summary_body_duration":
            MessageLookupByLibrary.simpleMessage("30 min a day"),
        "onboarding_summary_body_subtitle":
            MessageLookupByLibrary.simpleMessage("Weekly workout plan"),
        "onboarding_summary_body_title":
            MessageLookupByLibrary.simpleMessage("Train your Body"),
        "onboarding_summary_button_text":
            MessageLookupByLibrary.simpleMessage("Let\'s start"),
        "onboarding_summary_cta":
            MessageLookupByLibrary.simpleMessage("Get My Plan"),
        "onboarding_summary_mind_duration":
            MessageLookupByLibrary.simpleMessage("1 min a day"),
        "onboarding_summary_mind_subtitle":
            MessageLookupByLibrary.simpleMessage("Breathing & Daily Wisdom"),
        "onboarding_summary_mind_title":
            MessageLookupByLibrary.simpleMessage("Grow your Mind"),
        "onboarding_summary_plan_category_title":
            MessageLookupByLibrary.simpleMessage("Your everyday plan"),
        "onboarding_summary_program_duration": m10,
        "onboarding_summary_spirit_duration":
            MessageLookupByLibrary.simpleMessage("2 min a day"),
        "onboarding_summary_spirit_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Daily Stories & Healthy Habits"),
        "onboarding_summary_spirit_title":
            MessageLookupByLibrary.simpleMessage("Develop your Spirit"),
        "onboarding_summary_subtitle": MessageLookupByLibrary.simpleMessage(
            "Workouts, readings and self-development practices are ready to change your life"),
        "onboarding_summary_title": MessageLookupByLibrary.simpleMessage(
            "Your plan to optimal health is ready"),
        "onboarding_title_1": MessageLookupByLibrary.simpleMessage("About You"),
        "onboarding_title_2": MessageLookupByLibrary.simpleMessage("Main Goal"),
        "onboarding_user_birthday_screen_title":
            MessageLookupByLibrary.simpleMessage("What’s your birthday?"),
        "onboarding_user_desired_weight_screen_title":
            MessageLookupByLibrary.simpleMessage("What’s your desired weight?"),
        "onboarding_user_equipment_screen_title":
            MessageLookupByLibrary.simpleMessage("What equipment do you have?"),
        "onboarding_user_gender_screen_title":
            MessageLookupByLibrary.simpleMessage("Whats your gender?"),
        "onboarding_user_goal_screen_title":
            MessageLookupByLibrary.simpleMessage("What’s your fitness goals?"),
        "onboarding_user_habit_screen_habit_1":
            MessageLookupByLibrary.simpleMessage(
                "Avoid using gadgets 30 minutes before bedtime"),
        "onboarding_user_habit_screen_habit_10":
            MessageLookupByLibrary.simpleMessage(
                "Exclude sugar from all of your meals today"),
        "onboarding_user_habit_screen_habit_2":
            MessageLookupByLibrary.simpleMessage(
                "Keep track of hours you slept tonight"),
        "onboarding_user_habit_screen_habit_3":
            MessageLookupByLibrary.simpleMessage(
                "Don`t drink coffee 4-6 hours before sleep"),
        "onboarding_user_habit_screen_habit_4":
            MessageLookupByLibrary.simpleMessage(
                "Don`t drink alcohol 2-3 hours before sleep"),
        "onboarding_user_habit_screen_habit_5":
            MessageLookupByLibrary.simpleMessage("Drink 2l water every day"),
        "onboarding_user_habit_screen_habit_6":
            MessageLookupByLibrary.simpleMessage(
                "Practice deep breathing breaks during the day"),
        "onboarding_user_habit_screen_habit_7":
            MessageLookupByLibrary.simpleMessage(
                "Warm up your neck muscles while brushing your teeth"),
        "onboarding_user_habit_screen_habit_8":
            MessageLookupByLibrary.simpleMessage(
                "Before going to sleep, take five minutes to stretch and work on mobility"),
        "onboarding_user_habit_screen_habit_9":
            MessageLookupByLibrary.simpleMessage("Stretch while watching TV"),
        "onboarding_user_habit_screen_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Choose 1 — 3 healthy habits you’d like to develop"),
        "onboarding_user_height_screen_title":
            MessageLookupByLibrary.simpleMessage("What’s your height?"),
        "onboarding_user_level_screen_title":
            MessageLookupByLibrary.simpleMessage(
                "What’s your current activity level?"),
        "onboarding_user_name_screen_title":
            MessageLookupByLibrary.simpleMessage(
                "Hey there!\nWhat’s your name?"),
        "onboarding_user_plan_duration_screen_title":
            MessageLookupByLibrary.simpleMessage(
                "Choose the duration of your fitness plan?"),
        "onboarding_user_reason_android_screen_title":
            MessageLookupByLibrary.simpleMessage(
                "What should we focus on together?"),
        "onboarding_user_reason_ios_screen_title":
            MessageLookupByLibrary.simpleMessage(
                "Which is the most important to you?"),
        "onboarding_user_reason_screen_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Choose answers you want your fasting plan to focus on:"),
        "onboarding_user_weight_screen_title":
            MessageLookupByLibrary.simpleMessage("What’s your weight?"),
        "onboarding_user_workout_day_screen_title":
            MessageLookupByLibrary.simpleMessage(
                "Which days are you going to workout?"),
        "only_latin_supported": MessageLookupByLibrary.simpleMessage(
            "Only Latin input is supported"),
        "only_music": MessageLookupByLibrary.simpleMessage("Only music"),
        "only_voice": MessageLookupByLibrary.simpleMessage("Only voice"),
        "pause": MessageLookupByLibrary.simpleMessage("pause"),
        "paywall_accept_and": MessageLookupByLibrary.simpleMessage("and"),
        "paywall_accept_privacy": MessageLookupByLibrary.simpleMessage(
            "By continuing you accept our"),
        "paywall_android_subscription":
            MessageLookupByLibrary.simpleMessage("subscription for"),
        "paywall_android_subscription_after":
            MessageLookupByLibrary.simpleMessage("after trial"),
        "paywall_android_subscription_description": m11,
        "paywall_android_subscription_title": m12,
        "paywall_benefit_1":
            MessageLookupByLibrary.simpleMessage("World-class programs!"),
        "paywall_benefit_2":
            MessageLookupByLibrary.simpleMessage("250+ various workouts"),
        "paywall_benefit_3":
            MessageLookupByLibrary.simpleMessage("New releases weekly"),
        "paywall_button_text":
            MessageLookupByLibrary.simpleMessage("Start a 7-Day Trial"),
        "paywall_discount_amount": m13,
        "paywall_ios_policy_description": MessageLookupByLibrary.simpleMessage(
            "Your Apple ID payment method will be automatically charged. The subscription renews automatically at the end of each period, until you cancel. To avoid being charged, cancel the subscription in your iTunes & App Store/Apple ID account settings at least 24 hours before the current subscription period. If you are unsure how to cancel a subscription, please visit the Apple Support website. Note that deleting the app does not cancel your subscriptions. You may wish to make a printscreen of this information for your reference."),
        "paywall_ios_policy_title":
            MessageLookupByLibrary.simpleMessage("Subscription Terms"),
        "paywall_no_products":
            MessageLookupByLibrary.simpleMessage("No Products found"),
        "paywall_purchase_item_2_month":
            MessageLookupByLibrary.simpleMessage("2 months"),
        "paywall_purchase_item_3_month":
            MessageLookupByLibrary.simpleMessage("3 months"),
        "paywall_purchase_item_6_month":
            MessageLookupByLibrary.simpleMessage("6 months"),
        "paywall_purchase_item_annual":
            MessageLookupByLibrary.simpleMessage("Annual"),
        "paywall_purchase_item_custom":
            MessageLookupByLibrary.simpleMessage("Custom"),
        "paywall_purchase_item_lifetime":
            MessageLookupByLibrary.simpleMessage("Lifetime"),
        "paywall_purchase_item_monthly":
            MessageLookupByLibrary.simpleMessage("Monthly"),
        "paywall_purchase_item_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "paywall_purchase_item_weekly":
            MessageLookupByLibrary.simpleMessage("Weekly"),
        "paywall_restore_purchase":
            MessageLookupByLibrary.simpleMessage("Restore purchase"),
        "paywall_subscription_done": MessageLookupByLibrary.simpleMessage(
            "You already subscribed to Totalfit App."),
        "paywall_subtitle_1":
            MessageLookupByLibrary.simpleMessage("Start 7 day "),
        "paywall_subtitle_2":
            MessageLookupByLibrary.simpleMessage("Free Trial"),
        "paywall_title": MessageLookupByLibrary.simpleMessage(
            "unlock programs\nand all workouts"),
        "paywall_weekly_price": m14,
        "physical": MessageLookupByLibrary.simpleMessage("Physical"),
        "play": MessageLookupByLibrary.simpleMessage("play"),
        "please_answer_question": MessageLookupByLibrary.simpleMessage(
            "Please, answer the question.."),
        "points": MessageLookupByLibrary.simpleMessage("points"),
        "points_upper": MessageLookupByLibrary.simpleMessage("Points"),
        "premium": MessageLookupByLibrary.simpleMessage("Premium"),
        "program_completed_item_button_text":
            MessageLookupByLibrary.simpleMessage("FINISH PROGRAM"),
        "program_completed_item_sub_title":
            MessageLookupByLibrary.simpleMessage(
                "You’ve completed all scheduled workouts!"),
        "program_completed_item_title":
            MessageLookupByLibrary.simpleMessage("Wow! You nailed it!"),
        "program_description__goal":
            MessageLookupByLibrary.simpleMessage("Goal"),
        "program_description__info":
            MessageLookupByLibrary.simpleMessage("Info"),
        "program_description__setup":
            MessageLookupByLibrary.simpleMessage("Setup"),
        "program_edit_days":
            MessageLookupByLibrary.simpleMessage("Choose days"),
        "program_edit_level":
            MessageLookupByLibrary.simpleMessage("Choose your fitness Level"),
        "program_edit_number_of_weeks":
            MessageLookupByLibrary.simpleMessage("Choose number of weeks"),
        "program_edit_title":
            MessageLookupByLibrary.simpleMessage("Edit program"),
        "program_finished":
            MessageLookupByLibrary.simpleMessage("Program finished"),
        "program_full_schedule__program_schedule":
            MessageLookupByLibrary.simpleMessage("Program schedule"),
        "program_schedule_item_title": m15,
        "program_schedule_title":
            MessageLookupByLibrary.simpleMessage("Program schedule"),
        "program_setup_summary__app_bar_title":
            MessageLookupByLibrary.simpleMessage("Confirm Choises"),
        "program_setup_summary__days_of_the_week":
            MessageLookupByLibrary.simpleMessage("Days of the week"),
        "program_setup_summary__level":
            MessageLookupByLibrary.simpleMessage("Level"),
        "program_setup_summary__number_of_weeks":
            MessageLookupByLibrary.simpleMessage("Number of weeks"),
        "program_setup_summary__start_date":
            MessageLookupByLibrary.simpleMessage("Start Date"),
        "program_setup_summary__start_program":
            MessageLookupByLibrary.simpleMessage("Start program"),
        "program_setup_summary__update_program":
            MessageLookupByLibrary.simpleMessage("Reassemble program"),
        "program_start_button_text": m16,
        "program_workout_preview_missed_workout":
            MessageLookupByLibrary.simpleMessage("MISSED WORKOUT"),
        "programs__all_levels":
            MessageLookupByLibrary.simpleMessage("All levels"),
        "programs__and": MessageLookupByLibrary.simpleMessage("and"),
        "programs__choose_the_program_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Get daily workouts and see your progress and goals"),
        "programs__choose_the_program_title":
            MessageLookupByLibrary.simpleMessage("Choose the program"),
        "programs_progress__all_programs":
            MessageLookupByLibrary.simpleMessage("All programs"),
        "programs_progress__breathing_card_sub":
            MessageLookupByLibrary.simpleMessage("Daily practice"),
        "programs_progress__breathing_card_time":
            MessageLookupByLibrary.simpleMessage("1 min"),
        "programs_progress__breathing_card_title":
            MessageLookupByLibrary.simpleMessage("Breathing"),
        "programs_progress__days_a_week":
            MessageLookupByLibrary.simpleMessage("Days a week"),
        "programs_progress__empty_workout": MessageLookupByLibrary.simpleMessage(
            "There is no workout for today.\nUse this day to rest and recover."),
        "programs_progress__fantastic_youve_finished_program":
            MessageLookupByLibrary.simpleMessage(
                "Fantastic! You’ve finished program!"),
        "programs_progress__finish_program":
            MessageLookupByLibrary.simpleMessage("Finish program"),
        "programs_progress__full_schedule":
            MessageLookupByLibrary.simpleMessage("Full schedule"),
        "programs_progress__reschedule":
            MessageLookupByLibrary.simpleMessage("Reschedule"),
        "programs_progress__skills_learned":
            MessageLookupByLibrary.simpleMessage("Skills learned"),
        "programs_progress__this_week":
            MessageLookupByLibrary.simpleMessage("This week"),
        "programs_progress__workout_of_the_day":
            MessageLookupByLibrary.simpleMessage("Workout of the day"),
        "programs_progress__workouts":
            MessageLookupByLibrary.simpleMessage("workouts"),
        "programs_progress__wow_you_nailed_it":
            MessageLookupByLibrary.simpleMessage("Wow! You nailed it!"),
        "programs_progress__you_reached":
            MessageLookupByLibrary.simpleMessage("You reached"),
        "programs_progress__youve_completed_all_scheduled_workouts":
            MessageLookupByLibrary.simpleMessage(
                "You’ve completed all scheduled workouts!"),
        "progress_header_item_title":
            MessageLookupByLibrary.simpleMessage("Optimal Health for "),
        "progress_screen_mood_card_description":
            MessageLookupByLibrary.simpleMessage("How do you feel?"),
        "progress_screen_mood_card_title":
            MessageLookupByLibrary.simpleMessage("mood tracking"),
        "progress_workout_item_button_text":
            MessageLookupByLibrary.simpleMessage("SEE ALL COMPLETED WORKOUTS"),
        "push_notifications_title_all":
            MessageLookupByLibrary.simpleMessage("Allow all notifications"),
        "push_notifications_title_daily_reading":
            MessageLookupByLibrary.simpleMessage("Daily Readings"),
        "push_notifications_title_updates_and_news":
            MessageLookupByLibrary.simpleMessage("Updates and New Features"),
        "push_notifications_title_wod":
            MessageLookupByLibrary.simpleMessage("Workouts of the Day"),
        "quit_program": MessageLookupByLibrary.simpleMessage("Quit Program"),
        "quit_workout": MessageLookupByLibrary.simpleMessage("Quit workout"),
        "ready_to_rock_subtitle": MessageLookupByLibrary.simpleMessage(
            "Start your journey with a single workout"),
        "ready_to_rock_title":
            MessageLookupByLibrary.simpleMessage("Ready to rock?"),
        "reason_body_subtitle_android":
            MessageLookupByLibrary.simpleMessage("Workouts and Plans"),
        "reason_body_subtitle_ios":
            MessageLookupByLibrary.simpleMessage("Workouts and Programs"),
        "reason_body_title_android":
            MessageLookupByLibrary.simpleMessage("Workouts"),
        "reason_body_title_ios":
            MessageLookupByLibrary.simpleMessage("Body Training"),
        "reason_mind_subtitle_android":
            MessageLookupByLibrary.simpleMessage("Mind Development"),
        "reason_mind_subtitle_ios": MessageLookupByLibrary.simpleMessage(
            "Quizzes, Healthy Habits, and Breathing"),
        "reason_mind_title_android":
            MessageLookupByLibrary.simpleMessage("Mind Development"),
        "reason_mind_title_ios":
            MessageLookupByLibrary.simpleMessage("Mind Development"),
        "reason_spirit_subtitle_android":
            MessageLookupByLibrary.simpleMessage("Getting Calm"),
        "reason_spirit_subtitle_ios": MessageLookupByLibrary.simpleMessage(
            "Stories and Daily Reflection"),
        "reason_spirit_title_android":
            MessageLookupByLibrary.simpleMessage("Getting Calm"),
        "reason_spirit_title_ios":
            MessageLookupByLibrary.simpleMessage("Spirit Growing"),
        "repeat": MessageLookupByLibrary.simpleMessage("Repeat"),
        "reset_all_filters":
            MessageLookupByLibrary.simpleMessage("Reset all filters"),
        "reset_password_screen_app_bar":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "reset_password_screen_app_bar_alt":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "reset_password_screen_back":
            MessageLookupByLibrary.simpleMessage("Back to Login"),
        "reset_password_screen_back_to_login_info":
            MessageLookupByLibrary.simpleMessage(
                "We’ve sent you an email with a link to reset you password."),
        "reset_password_screen_button":
            MessageLookupByLibrary.simpleMessage("Recover password"),
        "reset_password_screen_confirm_password":
            MessageLookupByLibrary.simpleMessage("Confirm New Password"),
        "reset_password_screen_create_new_password":
            MessageLookupByLibrary.simpleMessage("Create New Password"),
        "reset_password_screen_description": MessageLookupByLibrary.simpleMessage(
            "Enter your email address and we will send you instructions on how to reset your password."),
        "reset_password_screen_input_email":
            MessageLookupByLibrary.simpleMessage("Email"),
        "reset_password_screen_new_password":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "reset_password_screen_title":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "rest": MessageLookupByLibrary.simpleMessage("Rest"),
        "result": MessageLookupByLibrary.simpleMessage("Result"),
        "round": MessageLookupByLibrary.simpleMessage("Round"),
        "rounds": MessageLookupByLibrary.simpleMessage("Rounds"),
        "school": MessageLookupByLibrary.simpleMessage("School"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "security": MessageLookupByLibrary.simpleMessage("Security"),
        "see_all": MessageLookupByLibrary.simpleMessage("See all"),
        "see_more": MessageLookupByLibrary.simpleMessage("See more"),
        "select_country":
            MessageLookupByLibrary.simpleMessage("Select country"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "share_result_error":
            MessageLookupByLibrary.simpleMessage("Share result Error"),
        "share_results": MessageLookupByLibrary.simpleMessage("Share Results"),
        "sharing": MessageLookupByLibrary.simpleMessage("Sharing"),
        "show": MessageLookupByLibrary.simpleMessage("Show"),
        "sign_in_screen_alt_auth_action":
            MessageLookupByLibrary.simpleMessage("Create new account."),
        "sign_in_screen_alt_auth_title":
            MessageLookupByLibrary.simpleMessage("Don’t have account?"),
        "sign_in_screen_button":
            MessageLookupByLibrary.simpleMessage("Sign in"),
        "sign_in_screen_description": MessageLookupByLibrary.simpleMessage(
            "Welcome back, you’ve been missed!\nyou’ve been missed!"),
        "sign_in_screen_forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "sign_in_screen_input_email":
            MessageLookupByLibrary.simpleMessage("Email"),
        "sign_in_screen_input_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "sign_in_screen_login_with":
            MessageLookupByLibrary.simpleMessage("Or Log In with"),
        "sign_in_screen_title":
            MessageLookupByLibrary.simpleMessage("Let’s sign you in"),
        "sign_in_with_apple_btn":
            MessageLookupByLibrary.simpleMessage("Sign In with Apple"),
        "sign_in_with_google_btn":
            MessageLookupByLibrary.simpleMessage("Sign In with Google"),
        "sign_up_email_allowance": MessageLookupByLibrary.simpleMessage(
            "I want to receive Totalfit news and special offers"),
        "sign_up_i_agree_and": MessageLookupByLibrary.simpleMessage("\nand"),
        "sign_up_i_agree_privacy":
            MessageLookupByLibrary.simpleMessage(" Privacy Policy"),
        "sign_up_i_agree_terms":
            MessageLookupByLibrary.simpleMessage(" Terms & Conditions"),
        "sign_up_i_agree_to":
            MessageLookupByLibrary.simpleMessage("I agree to"),
        "sign_up_screen_already_have":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "sign_up_screen_btn_sign_in":
            MessageLookupByLibrary.simpleMessage("Sign In"),
        "sign_up_screen_button":
            MessageLookupByLibrary.simpleMessage("Sign Up"),
        "sign_up_screen_description": MessageLookupByLibrary.simpleMessage(
            "Create an account now to start your\njourney to optimal health."),
        "sign_up_screen_input_name":
            MessageLookupByLibrary.simpleMessage("Name"),
        "sign_up_screen_sign_up_with":
            MessageLookupByLibrary.simpleMessage("Or Sign up with"),
        "sign_up_screen_title":
            MessageLookupByLibrary.simpleMessage("Let’s get started"),
        "sign_up_terms_agree": MessageLookupByLibrary.simpleMessage(
            "Agree to Terms & Conditions and Privacy\nPolicy to continue"),
        "sign_up_with_apple_btn":
            MessageLookupByLibrary.simpleMessage("Sign Up with Apple"),
        "sign_up_with_google_btn":
            MessageLookupByLibrary.simpleMessage("Sign Up with Google"),
        "single_workouts":
            MessageLookupByLibrary.simpleMessage("Single Workouts"),
        "skill_learned": MessageLookupByLibrary.simpleMessage("Skill learned"),
        "skill_tate_text_1": MessageLookupByLibrary.simpleMessage(
            "Poor. I can do it better! I should rewatch the tutorial and try again."),
        "skill_tate_text_2": MessageLookupByLibrary.simpleMessage(
            "Fair. Well, I am thinking maybe I should try the exercise one more time."),
        "skill_tate_text_3": MessageLookupByLibrary.simpleMessage(
            "Good. Ok, I got it, but i need to work more on my technique."),
        "skill_tate_text_4": MessageLookupByLibrary.simpleMessage(
            "Very good. It was awesome! I am full of energy and ready to reach new heights."),
        "skill_tate_text_5": MessageLookupByLibrary.simpleMessage(
            "Excellent. I pulled off a miracle! I nailed it on the very first take."),
        "sm_exercise": MessageLookupByLibrary.simpleMessage("exercises"),
        "social": MessageLookupByLibrary.simpleMessage("Social"),
        "sound": MessageLookupByLibrary.simpleMessage("Sound"),
        "sound_off": MessageLookupByLibrary.simpleMessage("Sound off"),
        "sounds": MessageLookupByLibrary.simpleMessage("Sounds"),
        "sounds_settings":
            MessageLookupByLibrary.simpleMessage("Sound settings"),
        "spirit": MessageLookupByLibrary.simpleMessage("Spirit"),
        "spiritual": MessageLookupByLibrary.simpleMessage("Spiritual"),
        "splash_screen_account_title":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "splash_screen_login": MessageLookupByLibrary.simpleMessage("Login"),
        "splash_screen_sign_up_button_title":
            MessageLookupByLibrary.simpleMessage("Sign Up"),
        "splash_title":
            MessageLookupByLibrary.simpleMessage("START YOUR JOURNEY TO"),
        "splash_title2":
            MessageLookupByLibrary.simpleMessage("  OPTIMAL HEALTH  "),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "statements": MessageLookupByLibrary.simpleMessage("Statements"),
        "step": MessageLookupByLibrary.simpleMessage("Step"),
        "storage": MessageLookupByLibrary.simpleMessage("Storage"),
        "story": MessageLookupByLibrary.simpleMessage("story"),
        "story_and_statements":
            MessageLookupByLibrary.simpleMessage("Story and Statements"),
        "support_and_feedback":
            MessageLookupByLibrary.simpleMessage("Support & Feedback"),
        "tap_clear_storage": MessageLookupByLibrary.simpleMessage(
            "Tap «Clear Storage» to delete all downloaded workouts and free up "),
        "tap_here_or_swipe_next_exercise": MessageLookupByLibrary.simpleMessage(
            "Tap here or swipe left to go to the next exercise"),
        "tap_here_or_swipe_prev_exercise": MessageLookupByLibrary.simpleMessage(
            "Tap here or swipe left to go to the previous exercise"),
        "tap_here_to_pause_workout": MessageLookupByLibrary.simpleMessage(
            "Tap here to pause workout and see the menu"),
        "tap_here_to_watch_workout": MessageLookupByLibrary.simpleMessage(
            "Tap here to watch tutorial for the exercise"),
        "tap_to_change": MessageLookupByLibrary.simpleMessage("Tap to change"),
        "test": MessageLookupByLibrary.simpleMessage("40-50 %s and %s"),
        "time": MessageLookupByLibrary.simpleMessage("Time"),
        "to_start_workout_download_exercises":
            MessageLookupByLibrary.simpleMessage(
                "To start the workout, please first download the exercises"),
        "total_time": MessageLookupByLibrary.simpleMessage("Total time"),
        "totalfit": MessageLookupByLibrary.simpleMessage("Totalfit"),
        "train_your_body":
            MessageLookupByLibrary.simpleMessage("Train your Body"),
        "use_panel_quickly_words_text": MessageLookupByLibrary.simpleMessage(
            "Use this panel to quickly add words to your text"),
        "use_words_above_write_faster": MessageLookupByLibrary.simpleMessage(
            "Use the words above to write faster"),
        "user_duration_1": MessageLookupByLibrary.simpleMessage("2 weeks"),
        "user_duration_2": MessageLookupByLibrary.simpleMessage("4 weeks"),
        "user_duration_3": MessageLookupByLibrary.simpleMessage("6 weeks"),
        "user_level_1":
            MessageLookupByLibrary.simpleMessage("I am strong and fit"),
        "user_level_2":
            MessageLookupByLibrary.simpleMessage("I workout sometimes"),
        "user_level_3":
            MessageLookupByLibrary.simpleMessage("I’ve just started"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "warm_up_completed":
            MessageLookupByLibrary.simpleMessage("Warm-up completed"),
        "watch_tutorial":
            MessageLookupByLibrary.simpleMessage("Watch tutorial"),
        "watch_tutorial_exercise": MessageLookupByLibrary.simpleMessage(
            "Watch tutorial and do the exercise"),
        "weight": MessageLookupByLibrary.simpleMessage("Weight"),
        "well_done": MessageLookupByLibrary.simpleMessage("Well done"),
        "what_does_story_motivate": MessageLookupByLibrary.simpleMessage(
            "What does this story motivate you to do?"),
        "wisdom": MessageLookupByLibrary.simpleMessage("Wisdom"),
        "wod_complited": MessageLookupByLibrary.simpleMessage("wod completed"),
        "wod_result": MessageLookupByLibrary.simpleMessage("WOD Result"),
        "wod_type": MessageLookupByLibrary.simpleMessage("WOD Type"),
        "workout": MessageLookupByLibrary.simpleMessage("Workout"),
        "workout_chip_level":
            MessageLookupByLibrary.simpleMessage("Information"),
        "workout_of_the_day":
            MessageLookupByLibrary.simpleMessage("Workout of The Day"),
        "workout_preview_completed_button_text":
            MessageLookupByLibrary.simpleMessage("GO TO SUMMARY"),
        "workout_preview_cooldown_button_text":
            MessageLookupByLibrary.simpleMessage("GO TO COOLDOWN"),
        "workout_preview_duration": m17,
        "workout_preview_idle_button_text":
            MessageLookupByLibrary.simpleMessage("START WORKOUT"),
        "workout_preview_warm_up_button_text":
            MessageLookupByLibrary.simpleMessage("GO TO SKILL"),
        "workout_preview_wod_button_text":
            MessageLookupByLibrary.simpleMessage("Go to workout of the day"),
        "workout_schedule_pop_confirm_text":
            MessageLookupByLibrary.simpleMessage("Schedule"),
        "workout_schedule_pop_sub_title":
            MessageLookupByLibrary.simpleMessage("Workout will take 10-25 min"),
        "workout_schedule_pop_title": MessageLookupByLibrary.simpleMessage(
            "When do you want to be notified about your next workout?"),
        "write_simple_action": MessageLookupByLibrary.simpleMessage(
            "Write a simple action that you can complete in the next 24 hours"),
        "yes": MessageLookupByLibrary.simpleMessage("yes"),
        "you_can_choose_two_more_habits": MessageLookupByLibrary.simpleMessage(
            "You can choose two more habits that you want to practice in next month"),
        "your_environmental_life":
            MessageLookupByLibrary.simpleMessage("Your Environmental Life"),
        "your_progress": MessageLookupByLibrary.simpleMessage("Your progress"),
        "your_result": MessageLookupByLibrary.simpleMessage("Your result"),
        "your_result_is":
            MessageLookupByLibrary.simpleMessage("Your result is"),
        "youre_almost_finished_workout": MessageLookupByLibrary.simpleMessage(
            "You\'re almost finished this workout"),
        "youre_greate_athlete": MessageLookupByLibrary.simpleMessage(
            "You’re a great athlete. On the next screen you can share your results with your community to train your social sphere")
      };
}
