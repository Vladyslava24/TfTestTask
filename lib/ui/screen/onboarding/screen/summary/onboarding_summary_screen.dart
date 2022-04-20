import 'dart:ui';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totalfit/data/dto/request/program_request.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/middleware/choose_program_middleware.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/ui/screen/onboarding/model/onboarding_data.dart';
import 'package:totalfit/ui/screen/onboarding/screen/summary/onboarding_summary_bloc.dart';
import 'package:totalfit/ui/screen/paywall_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kit/ui_kit.dart';

class OnboardingSummaryScreen extends StatefulWidget {
  final FeedProgramListItem item;
  final OnBoardingData onBoardingData;

  OnboardingSummaryScreen(this.item, this.onBoardingData);

  static Route route(FeedProgramItemResponse feedItem, OnBoardingData onBoardingData) {
    return MaterialPageRoute(
        builder: (_) =>
            OnboardingSummaryScreen(feedItem != null ? mapItem(StringStorage(), feedItem) : null, onBoardingData));
  }

  @override
  State<OnboardingSummaryScreen> createState() => _OnboardingSummaryScreenState();
}

class _OnboardingSummaryScreenState extends State<OnboardingSummaryScreen> {
  final _block = OnboardingSummaryBlock();
  OnboardingSummaryEvent _onboardingSummaryEvent;
  final ABTestService abTestService = DependencyProvider.get<ABTestService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light, child: _buildContent(widget.item, context)));
  }

  Widget _buildContent(FeedProgramListItem item, BuildContext context) {
    return SafeArea(
      child: BlocListener<OnboardingSummaryBlock, OnboardingSummaryEvent>(
        bloc: _block,
        listenWhen: (oldState, newState) => oldState?.runtimeType != newState?.runtimeType,
        listener: (c, state) async {
          print(state);
          if (state is Error) {
            final attrs = TfDialogAttributes(
              title: S.of(context).dialog_error_title,
              description: state.exception.getMessage(context),
              negativeText: S.of(context).dialog_error_recoverable_negative_text,
              positiveText: S.of(context).all__retry,
            );
            final result = await TfDialog.show(context, attrs);
            if (result is Confirm) {
              _sendRequest();
            }
          }
          if (state is OnRequestCompleted) {
            StoreProvider.of<AppState>(context).dispatch(ShowMainScreenAction());
          }

          setState(() {
            _onboardingSummaryEvent = state;
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          abTestService.remoteConfig
                              .getString('onboarding_summary_title'),
                          textAlign: TextAlign.left,
                          style: title30),
                      SizedBox(height: 8),
                      Text(S.of(context).onboarding_summary_subtitle,
                          textAlign: TextAlign.left, style: textRegular16.copyWith(color: AppColorScheme.colorBlack8)),
                      item != null ? SizedBox(height: 24) : SizedBox.shrink(),
                      item != null ? _buildProgramItem(item, context) : SizedBox.shrink(),
                      SizedBox(height: 24),
                      Text(S.of(context).onboarding_summary_plan_category_title,
                          textAlign: TextAlign.left, style: title20),
                      SizedBox(height: 16),
                      _buildCategory(_OnboardingSummaryCategory.body, context),
                      SizedBox(height: 16),
                      _buildCategory(_OnboardingSummaryCategory.spirit, context),
                      SizedBox(height: 16),
                      _buildCategory(_OnboardingSummaryCategory.mind, context),
                      SizedBox(height: 56.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: BaseElevatedButton(
                text: abTestService.remoteConfig.getString('onboarding_summary_cta'),
                onPressed: () => _completeOnboarding(context)
              )
            ),
            Positioned.fill(
              child: Visibility(
                visible: _onboardingSummaryEvent is Loading,
                child: DimmedCircularLoadingIndicator()
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendRequest() {
    final data = widget.onBoardingData;
    var request = ProgramRequest(
        level: data.level.key,
        numberOfWeeks: data.duration,
        targetId: widget.item.id,
        startDate: today(),
        daysOfWeek: data.workoutDays);
    _block.add(BlockAction(request: request));
  }

  _buildProgramItem(FeedProgramListItem item, BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      pressedOpacity: 0.9,
      onPressed: () => _completeOnboarding(context),
      child: Container(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          child: Stack(
            children: <Widget>[
              TfImage(
                url: item.image,
                width: double.infinity,
                height: 200,
              ),
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColorScheme.colorYellow.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              )),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _buildBadge(S.of(context).onboarding_summary_program_duration('${item.maxWeekNumber}')),
                        const SizedBox(width: 4),
                        _buildBadge(item.levelsForFeedUI),
                      ],
                    ),
                    const SizedBox(width: 0, height: 4),
                    Text(
                      item.name.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: title20.copyWith(color: AppColorScheme.colorPrimaryWhite),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.equipmentForFeedUI.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: textRegular10.copyWith(color: AppColorScheme.colorPrimaryWhite),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildBadge(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 8,
            top: 4,
            right: 8,
            bottom: 4,
          ),
          color: AppColorScheme.colorBlack3,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: textRegular12.copyWith(color: AppColorScheme.colorPrimaryWhite),
          ),
        ),
      ),
    );
  }

  _buildCategory(_OnboardingSummaryCategory category, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: AppColorScheme.colorBlack2,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.duration(context),
                      textAlign: TextAlign.left,
                      style: title14.copyWith(color: category.color),
                    ),
                    SizedBox(height: 12),
                    Text(
                      category.title(context),
                      textAlign: TextAlign.left,
                      style: title16,
                    ),
                    SizedBox(height: 2),
                    Text(
                      category.subtitle(context),
                      textAlign: TextAlign.left,
                      style: textRegular12.copyWith(color: AppColorScheme.colorBlack8),
                    ),
                    SizedBox(height: 12),
                    CupertinoButton(
                      onPressed: () => _completeOnboarding(context),
                      padding: EdgeInsets.zero,
                      child: Container(
                        decoration:
                            BoxDecoration(color: AppColorScheme.colorBlack4, borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Text(
                          abTestService.remoteConfig.getString('onboarding_summary_button_text'),
                          textAlign: TextAlign.left,
                          style: title14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TfImage(url: 'assets/images/${category.image}', fit: BoxFit.contain),
                ))
          ],
        ),
      ),
    );
  }

  _completeOnboarding(BuildContext context) async {
    final subscribed = await PaywallScreen.show(context);
    StoreProvider.of<AppState>(context).dispatch(ShowMainScreenAction());
    // if (subscribed) {
    //   _sendRequest();
    // } else {
    //   StoreProvider.of<AppState>(context).dispatch(ShowMainScreenAction());
    // }
  }
}

class _OnboardingSummaryCategory {
  static final body = _OnboardingSummaryCategory._(
      (c) => S.of(c).onboarding_summary_body_title,
      (c) => S.of(c).onboarding_summary_body_subtitle,
      (c) => S.of(c).onboarding_summary_body_duration,
      'im_onboarding_summary_body.png',
      AppColorScheme.colorYellow);
  static final spirit = _OnboardingSummaryCategory._(
      (c) => S.of(c).onboarding_summary_spirit_title,
      (c) => S.of(c).onboarding_summary_spirit_subtitle,
      (c) => S.of(c).onboarding_summary_spirit_duration,
      'im_onboarding_summary_spirit.png',
      AppColorScheme.colorBlue2);
  static final mind = _OnboardingSummaryCategory._(
      (c) => S.of(c).onboarding_summary_mind_title,
      (c) => S.of(c).onboarding_summary_mind_subtitle,
      (c) => S.of(c).onboarding_summary_mind_duration,
      'im_onboarding_summary_mind.png',
      AppColorScheme.colorPurple2);

  final String Function(BuildContext) title;
  final String Function(BuildContext) subtitle;
  final String Function(BuildContext) duration;
  final String image;
  final Color color;

  _OnboardingSummaryCategory._(
    this.title,
    this.subtitle,
    this.duration,
    this.image,
    this.color,
  );
}
