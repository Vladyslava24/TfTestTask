import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/loading_state/progress_state.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:totalfit/ui/screen/main/programs/progress/widgets/program_progress_wod_widget.dart';
import 'package:totalfit/ui/screen/main/workout/utils/workout_utils.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/summary_progress_indicator.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgressWorkoutWidget extends StatefulWidget {
  final WorkoutListItem item;
  final VoidCallback onWorkoutSelected;
  final VoidCallback navigateToWorkoutSelectionPage;
  final Key key;

  ProgressWorkoutWidget({
    @required this.item,
    @required this.onWorkoutSelected,
    @required this.navigateToWorkoutSelectionPage,
    @required this.key,
  }) : super(key: key);

  @override
  _ProgressWorkoutWidgetState createState() => _ProgressWorkoutWidgetState();
}

class _ProgressWorkoutWidgetState extends State<ProgressWorkoutWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _animationController.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_buildTitle(vm), _buildItem(vm), _buildButton(vm)],
      ),
    );
  }

  Widget _buildTitle(_ViewModel vm) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              bodyHexIc,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).train_your_body,
              textAlign: TextAlign.left,
              style: title20.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
                letterSpacing: 0.015,
              ),
            ),
          ],
        ),
      );

  Widget _buildItem(_ViewModel vm) {
    double completionRate = 0;
    if (widget.item.workoutProgressList != null ||
        widget.item.workoutProgressList.isNotEmpty) {
      completionRate =
          getCompletionRate(widget.item.workoutProgressList.last.workoutPhase);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: widget.item.progressState == ProgressState.IDLE
                        ? Colors.transparent
                        : AppColorScheme.colorYellow,
                    border: Border.all(
                      color: AppColorScheme.colorYellow,
                      width: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 2.5,
                  child: Opacity(
                    opacity: widget.item.progressState == ProgressState.IDLE
                        ? 0.0
                        : 1.0,
                    child: SvgPicture.asset(
                      checkIc,
                      width: 12,
                      height: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: ColorFiltered(
                    colorFilter: widget.item.progressState == ProgressState.IDLE
                        ? const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          )
                        : const ColorFilter.mode(
                            AppColorScheme.colorPrimaryBlack,
                            BlendMode.saturation,
                          ),
                    child: TfImage(
                        url: widget.item.workoutProgressList == null
                            ? ""
                            : widget
                                .item.workoutProgressList.last.workout.image,
                        width: double.infinity,
                        height: 211),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        S
                            .of(context)
                            .programs_progress__workout_of_the_day
                            .toUpperCase(),
                        textAlign: TextAlign.left,
                        style: textRegular10.copyWith(
                          letterSpacing: 0.05,
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.workoutProgressList == null
                            ? ""
                            : widget
                                .item.workoutProgressList.last.workout.theme,
                        textAlign: TextAlign.left,
                        style: title16.copyWith(
                          letterSpacing: 0.0041,
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          buildBadge(
                            widget.item.workoutProgressList == null
                                ? ""
                                : "${widget.item.workoutProgressList.last.workout.estimatedTime} ${S.of(context).min}",
                            AppColorScheme.colorBlack4,
                          ),
                          const SizedBox(width: 4),
                          buildBadge(
                            widget.item.workoutProgressList == null
                                ? ""
                                : widget.item.workoutProgressList.last.workout
                                    .difficultyLevel,
                            AppColorScheme.colorBlack4,
                          )
                        ],
                      ),
                      completionRate == 0.0 ||
                              completionRate == 1 ||
                              widget.item.workoutProgressList == null ||
                              widget.item.workoutProgressList.isEmpty
                          ? const SizedBox.shrink()
                          : LayoutBuilder(
                              builder: (context, constraints) => Column(
                                children: [
                                  const SizedBox(width: 0, height: 12),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    width: constraints.biggest.width,
                                    child: StaticCustomLinearProgressIndicator(
                                      0.0,
                                      value: completionRate,
                                      color: AppColorScheme.colorYellow,
                                      idleColor: AppColorScheme.colorBlack7
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onWorkoutSelected,
                        splashColor:
                            AppColorScheme.colorYellow.withOpacity(0.3),
                        highlightColor:
                            AppColorScheme.colorYellow.withOpacity(0.1),
                        child: const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
                widget.item.workoutProgressList != null &&
                widget.item.workoutProgressList.isNotEmpty &&
                widget.item.workoutProgressList.last.workout.plan == 'PREMIUM' &&
                !vm.isPremiumUser ?
                Positioned(
                  right: 12.0,
                  top: 12.0,
                  child: IconLockWidget(
                    padding: EdgeInsets.zero,
                  )
                ) : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(_ViewModel vm) {
    if (widget.item.workoutProgressList == null ||
        widget.item.workoutProgressList
                .where(
                    (element) => element.finished != null && element.finished)
                .toList()
                .length >
            1) {
      return ActionButton(
          text: S.of(context).progress_workout_item_button_text,
          padding: const EdgeInsets.only(top: 12),
          onPressed: () => vm.navigateToProfileScreen(),
          textColor: AppColorScheme.colorPrimaryWhite,
          color: AppColorScheme.colorBlack2);
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _ViewModel {
  bool workoutsLoaded = false;
  Function navigateToProfileScreen;
  bool isPremiumUser;

  _ViewModel({
    @required this.workoutsLoaded,
    @required this.navigateToProfileScreen,
    @required this.isPremiumUser
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        isPremiumUser: store.state.isPremiumUser(),
        navigateToProfileScreen: () =>
            store.dispatch(UpdateSelectedTab(tab: BottomTab.Profile)),
        workoutsLoaded: store.state.mainPageState.workouts != null &&
            store.state.mainPageState.workouts.isNotEmpty);
  }
}
