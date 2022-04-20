import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/ui/screen/onboarding/model/goal.dart';
import 'package:totalfit/ui/screen/onboarding/model/reason.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_desired_weight_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_goal_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_habit_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_weight_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_workout_day_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/plan/create_plan_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_birthday_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_equipment_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_gender_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_height_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_level_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_plan_duration_screen.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/pages/user_reason_screen.dart';
import 'package:totalfit/ui/screen/onboarding/model/onboarding_data.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:totalfit/ui/screen/onboarding/widgets/onboarding_action_bar.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit/ui_kit.dart';
import 'pages/user_name_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Widget> _pages;
  PageController _pageController;
  double _currentPage = 0.0;
  ValueNotifier<OnBoardingData> _data = ValueNotifier(OnBoardingData.initial());

  @override
  void initState() {
    _pages = _longOnboardingFlow();
    _currentPage = 0;
    _pageController = PageController();
    super.initState();
  }

  List<Widget> _longOnboardingFlow() => [
        UserNameScreen(onNext: (name) {
          _data.value = _data.value.copyWith(name: name);
          _next();
        }),
        UserGenderScreen(onNext: (gender) {
          _data.value = _data.value.copyWith(gender: gender.name);
          _next();
        }),
        UserBirthdayScreen(onNext: (birthday) {
          _data.value = _data.value.copyWith(birthday: birthday);
          _next();
        }),
        UserHeightScreen(onNext: (height, metric) {
          _data.value =
              _data.value.copyWith(height: height, preferredHighMetric: metric);
          _next();
        }),
        UserWeightScreen(onNext: (weight, metric) {
          _data.value = _data.value
              .copyWith(weight: weight, preferredWeightMetric: metric);
          _next();
        }),
        UserDesiredWeightScreen(onNext: (desiredWeight) {
          _data.value = _data.value.copyWith(desiredWeight: desiredWeight);
          _next();
        }),
        UserReasonScreen(onNext: (reason) {
          _data.value = _data.value.copyWith(reason: reason);
          _sendEvent(
              Event.ONBOARDING_USER_REASON, {"reason": reason.toBackendKey()});
          _next();
        }),
        UserHabitScreen(onNext: (habits) {
          _data.value = _data.value.copyWith(habits: habits);
          _sendEvent(
              Event.ONBOARDING_USER_HABITS, {"habits": json.encode(habits)});
          _next();
        }),
        UserGoalScreen(onNext: (goals) {
          _data.value = _data.value.copyWith(goals: goals);
          _sendEvent(Event.ONBOARDING_USER_GOALS, {
            "goals": json.encode(goals.map((e) => e.toBackendKey()).toList())
          });
          _next();
        }),
        UserLevelScreen(onNext: (level) {
          _data.value = _data.value.copyWith(level: level);
          _sendEvent(Event.ONBOARDING_USER_LEVEL, {"level": level.key});
          _next();
        }),
        UserPlanDurationScreen(onNext: (duration) {
          _data.value = _data.value.copyWith(duration: duration);
          _sendEvent(Event.ONBOARDING_USER_DURATION_PLAN,
              {"duration": duration.toString()});
          _next();
        }),
        UserWorkoutDayScreen(onNext: (days) {
          final workoutDays = days.map((e) => e.key).toList();
          _data.value = _data.value.copyWith(workoutDays: workoutDays);
          _sendEvent(Event.ONBOARDING_USER_WORKOUT_DAYS,
              {"workoutDays": json.encode(workoutDays)});
          _next();
        }),
        UserEquipmentScreen(
          onNext: (equipment) {
            final equipmentList =
                equipment.map((e) => e.getName(context)).toList();
            _data.value = _data.value.copyWith(equipment: equipmentList);
            _sendEvent(Event.ONBOARDING_USER_EQUIPMENT,
                {"equipment": json.encode(equipmentList)});
            _next();
          },
        ),
        CreatePlanScreen()
      ];

  List<Widget> _shortOnboardingFlow() => [
        UserNameScreen(onNext: (name) {
          _data.value = _data.value.copyWith(name: name);
          _next();
        }),
        UserGenderScreen(onNext: (gender) {
          _sendEvent(
              Event.ONBOARDING_USER_GENDER, {"gender": gender.toString()});
          _data.value = _data.value.copyWith(gender: gender.name);
          _next();
        }),
        UserBirthdayScreen(onNext: (birthday) {
          _sendEvent(Event.ONBOARDING_USER_REASON, {"birthday": birthday});
          _data.value = _data.value.copyWith(birthday: birthday);
          _next();
        }),
        UserHeightScreen(onNext: (height, metric) {
          _data.value =
              _data.value.copyWith(height: height, preferredHighMetric: metric);
          _next();
        }),
        UserWeightScreen(onNext: (weight, metric) {
          _data.value = _data.value
              .copyWith(weight: weight, preferredWeightMetric: metric);
          _next();
        }),
        UserReasonScreen(onNext: (reason) {
          _data.value = _data.value.copyWith(reason: reason);
          _sendEvent(
              Event.ONBOARDING_USER_REASON, {"reason": reason.toBackendKey()});
          _next();
        }),
        UserHabitScreen(onNext: (habits) {
          _data.value = _data.value.copyWith(habits: habits);
          _sendEvent(
              Event.ONBOARDING_USER_HABITS, {"habits": json.encode(habits)});
          _next();
        }),
        UserGoalScreen(onNext: (goals) {
          _data.value = _data.value.copyWith(goals: goals);
          _sendEvent(Event.ONBOARDING_USER_GOALS, {
            "goals": json.encode(goals.map((e) => e.toBackendKey()).toList())
          });
          _next();
        }),
        CreatePlanScreen()
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _previous();
        return _currentPage == 0;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) => _onScroll(n),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColorScheme.colorPrimaryBlack,
            body: Column(
              children: [
                OnboardingActionBar(
                    title: _getTitle(),
                    value: _getValue(),
                    showBackArrow: _currentPage.round() > 0,
                    onBackPressed: () {
                      _previous();
                    }),
                Expanded(
                  child: ValueListenableBuilder<OnBoardingData>(
                      valueListenable: _data,
                      builder: (context, value, child) {
                        return Provider<OnBoardingData>.value(
                          value: value,
                          child: child,
                        );
                      },
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: _pages,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _next() {
    _animateScroll(min(_currentPage.round() + 1, _pages.length - 1));
  }

  void _previous() {
    _animateScroll(max(_currentPage.round() - 1, 0));
  }

  Future<void> _animateScroll(int page) async {
    await _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics) {
      setState(() => _currentPage = metrics.page);
    }

    return false;
  }

  String _getTitle() {
    if (_currentPage.round() <= 4) {
      return S.of(context).onboarding_title_1;
    } else {
      return S.of(context).onboarding_title_2;
    }
  }

  double _getValue() {
    if (!_pageController.hasClients) {
      return 0.0;
    }
    double fullDistance =
        (_pages.length - 1) * MediaQuery.of(context).size.width;
    return _pageController.position.pixels / fullDistance;
  }

  _sendEvent(Event event, Map<String, String> attrs) {
    StoreProvider.of<AppState>(context)
        .dispatch(SendOnboardingEventAction(event, attrs));
  }
}
