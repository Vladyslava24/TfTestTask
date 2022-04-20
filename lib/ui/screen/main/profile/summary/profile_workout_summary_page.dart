import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/profile_share_workout_results_bundle.dart';
import 'package:totalfit/model/profile_workout_summary_bundle.dart';
import 'package:totalfit/model/skill_summary_list_items.dart';
import 'package:totalfit/model/workout_voice_message.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/profile_share_workout_results_actions.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/workout/summary/list_item_widgets.dart';
import 'package:ui_kit/ui_kit.dart';

class ProfileWorkoutSummaryPage extends StatefulWidget {
  final WorkoutSummaryBundle bundle;

  ProfileWorkoutSummaryPage({@required this.bundle});

  @override
  _ProfileWorkoutSummaryPageState createState() => _ProfileWorkoutSummaryPageState();
}

class _ProfileWorkoutSummaryPageState extends State<ProfileWorkoutSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store),
        onInitialBuild: (vm) {
          if (widget.bundle.workoutPhase != WorkoutPhase.COOLDOWN &&
              widget.bundle.workoutPhase != WorkoutPhase.FINISHED) {

          }
        },
        onWillChange: (oldVm, newVm) {
          if (newVm.error is! IdleException) {
            _handleError(newVm);
          }
        },
        onInit: (store) {
          store.dispatch(BuildWorkoutSummaryScreenStateAction(bundle: widget.bundle));
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Future<void> _handleError(_ViewModel vm) async {
    vm.clearSummaryError();

    final attrs = TfDialogAttributes(
      title: S.of(context).dialog_error_title,
      description: vm.error.getMessage(context),
      negativeText: S.of(context).dialog_error_recoverable_negative_text,
      positiveText: S.of(context).all__retry,
    );
    final result = await TfDialog.show(context, attrs);
    if (result is Cancel) {
      vm.quitWorkout();
    }
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: WillPopScope(
            onWillPop: () => _onBackPressed(vm),
            child: _buildItemList(vm),
          ),
        ),
      );

  Future<bool> _onBackPressed(_ViewModel vm) async {
    vm.quitWorkout();
    return Future.sync(() => false);
  }

  Widget _buildItemList(_ViewModel vm) {
    return Material(
      color: AppColorScheme.colorBlack,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: vm.listItems != null
            ? Stack(
                children: [
                  Positioned.fill(
                    child: ListView.builder(
                        key: ValueKey("summary_list"),
                        itemCount: vm.listItems.length,
                        itemBuilder: (context, index) {
                          final item = vm.listItems[index];
                          if (item is PageHeaderWorkoutSummaryListItem) {
                            return PageHeaderWorkoutSummaryWidget(
                              item: item,
                              key: ValueKey('ProfilePageHeaderWorkoutSummaryWidget'),
                            );
                          }

                          if (item is ListBottomPaddingItem) {
                            return ListBottomPadding();
                          }

                          if (item is ResultItem) {
                            return ResultItemWidget(item: item);
                          }

                          if (item is SkillItem) {
                            return SkillResultItemWidget(item: item);
                          }

                          return Container();
                        }),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ActionButton(
                      padding: EdgeInsets.all(16),
                      text: vm.isWorkoutCompleted
                          ? S.of(context).share.toUpperCase()
                          : S.of(context).all__finish.toUpperCase(),
                      color: AppColorScheme.colorYellow,
                      onPressed: () => vm.goToShareResultsPage(),
                    ),
                  ),
                ],
              )
            : CircularLoadingIndicator(),
      ),
    );
  }
}

class _ViewModel {
  final List<dynamic> listItems;
  final Function() goToShareResultsPage;
  final Function quitWorkout;
  final bool isWorkoutCompleted;
  final TfException error;
  final Function clearSummaryError;

  _ViewModel(
      {this.listItems,
      this.goToShareResultsPage,
      this.quitWorkout,
      this.isWorkoutCompleted,
      this.error,
      this.clearSummaryError,
      @required store});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store: store,
        listItems: store.state.profileWorkoutSummaryState.listItems,
        error: store.state.profileWorkoutSummaryState.error,
        clearSummaryError: () {},
        isWorkoutCompleted: store.state.profileWorkoutSummaryState.isWorkoutCompleted,
        quitWorkout: () => store.dispatch(PopScreenAction()),
        goToShareResultsPage: () async {
          var bundle = ProfileShareWorkoutResultsScreenBundle(
            workout: store.state.profileWorkoutSummaryState.workout,
            progress: store.state.profileWorkoutSummaryState.progress,
          );

          store.dispatch(NavigateToProfileShareScreenAction(bundle: bundle));
        });
  }

  @override
  WorkoutVoiceMessage getVoiceMessage() => WorkoutVoiceMessage.FINISH;
}

enum FlowSource { ProgressPage, CooldownPage }
