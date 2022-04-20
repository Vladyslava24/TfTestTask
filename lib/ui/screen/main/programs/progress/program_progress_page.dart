import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/domain/bloc/program_progress_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/profile_workout_summary_bundle.dart';
import 'package:totalfit/model/progress/program_completed_item.dart';
import 'package:totalfit/model/progress/program_full_schedule_item.dart';
import 'package:totalfit/model/progress/program_progress_header_item.dart';
import 'package:totalfit/model/progress/program_progress_workout_item.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/programs/progress/widgets/scheduled_workout_item_widget.dart';
import 'package:totalfit/ui/utils/utils.dart';

import 'widgets/full_schedule_widget.dart';
import 'widgets/program_completed_item_widget.dart';
import 'widgets/program_progress_header_widget.dart';
import 'widgets/program_progress_wod_widget.dart';

class ProgramProgressPage extends StatefulWidget {
  const ProgramProgressPage({Key key}) : super(key: key);

  @override
  _ProgramProgressPageState createState() => _ProgramProgressPageState();
}

class _ProgramProgressPageState extends State<ProgramProgressPage> {
  ScrollController _scrollController;
  final _block = ProgramProgressBlock();
  dynamic _lastRequestAction;
  ProgramProgressBlocEvent _blocEvent;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      onInit: (store) {
        _scrollController = ScrollController();
        store.dispatch(LoadProgramProgressPageAction());
      },
      onDispose: (store) {
        _scrollController.dispose();
      },
      converter: _ViewModel.fromStore,
      builder: (context, vm) => SafeArea(
        child: Scaffold(
          appBar: SimpleAppBar(
            leadingType: LeadingType.button,
            leadingText: S.of(context).programs_progress__all_programs,
            leadingAction: () => vm.showAllPrograms(),
            actionType: ActionType.settings,
            actionFunction: () => vm.editProgram(),
          ),
          backgroundColor: AppColorScheme.colorBlack,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: WillPopScope(
              onWillPop: () => _onBackPressed(vm),
              child: _buildItemList(vm),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(_ViewModel vm) => SafeArea(
        child: BlocListener<ProgramProgressBlock, ProgramProgressBlocEvent>(
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
                _retry();
              }
            }
            if (state is OnProgramFinished) {
              vm.onProgramFinished(state.response);
            }

            setState(() {
              _blocEvent = state;
            });
          },
          child: Stack(
            children: [
              _buildContent(vm),
              Positioned.fill(
                child: Visibility(
                  visible: _blocEvent is Loading,
                  child: DimmedCircularLoadingIndicator(),
                ),
              ),
            ],
          ),
        ),
      );

  _buildContent(_ViewModel vm) => ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 0),
        itemCount: vm.listItems.length,
        itemBuilder: (context, index) {
          final item = vm.listItems[index];

          if (item is ProgramProgressHeaderItem) {
            return ProgramProgressHeaderWidget(item: item);
          }

          if (item is ProgramProgressWODItem) {
            return ProgramProgressWODWidget(
              item: item,
              key: ValueKey('ProgramProgressWODItem'),
              onWorkoutSelected: () {
                if (item.workoutProgress != null &&
                    (item.workoutProgress.finished != null && item.workoutProgress.finished)) {
               //   _sendLoadWorkoutSummaryRequest(item.workoutProgress.id, item.workoutProgress.startedAt);
                  vm.navigateToWorkoutSummary(item.workoutProgress.id, DateTime.parse(item.workoutProgress.startedAt));
                } else {
                  vm.onStartWorkout(item.workout, null);
                }
              },
            );
          }

          if (item is FullScheduleItem) {
            return FullScheduleWidget(item: item, onFullScheduleClick: vm.onFullScheduleClick);
          }

          if (item is ProgramCompletedItem) {
            return ProgramCompletedItemWidget(onFinishProgram: () => _sendFinishProgramRequest(vm));
          }

          if (item is ScheduledWorkoutItem) {
            return ScheduledWorkoutItemWidget(
              item: item,
              onItemClick: (item) {
                if (item.workoutProgress.finished) {

                  //_sendLoadWorkoutSummaryRequest(item.workoutProgress.id, item.workoutProgress.startedAt);
                  vm.navigateToWorkoutSummary(item.workoutProgress.id, DateTime.parse(item.workoutProgress.startedAt));
                } else {
                  vm.onStartWorkout(item.workoutProgress.workout, item.date);
                }
              },
            );
          }

          if (item is SpaceItem) {
            return const SizedBox(height: 90);
          }

          return const SizedBox.shrink();
        },
      );

  _sendFinishProgramRequest(_ViewModel vm) {
    _lastRequestAction = FinishProgramAction(vm.programId);
    _block.add(_lastRequestAction);
  }

  _sendLoadWorkoutSummaryRequest(String workoutProgressId, String startedAt) {
    _lastRequestAction = LoadWorkoutSummaryAction(workoutProgressId: workoutProgressId, startedAt: startedAt);
    _block.add(_lastRequestAction);
  }

  _retry() {
    _block.add(_lastRequestAction);
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }
}

class _ViewModel {
  final int programId;
  final List<FeedItem> listItems;
  final Function(WorkoutDto, DateTime) onStartWorkout;
  final Function() onDropWorkoutState;
  final Function(FinishProgramResponse) onProgramFinished;
  final Function(String, DateTime) navigateToWorkoutSummary;
  final VoidCallback onFullScheduleClick;
  final VoidCallback showAllPrograms;
  final VoidCallback editProgram;

  _ViewModel({
    this.programId,
    this.listItems,
    this.onStartWorkout,
    this.onDropWorkoutState,
    this.onProgramFinished,
    this.navigateToWorkoutSummary,
    this.onFullScheduleClick,
    this.showAllPrograms,
    this.editProgram,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        programId: int.parse(store.state.programProgressState.activeProgram.id),
        listItems: store.state.programProgressState.listItems,
        onDropWorkoutState: () => store.dispatch(QuitWorkoutAction(null)),
        onFullScheduleClick: () => store.dispatch(NavigateToFullSchedulePageAction()),
        onProgramFinished: (response) => store.dispatch(NavigateToProgramSummaryAction(response)),
        showAllPrograms: () => store.dispatch(SwitchProgramTabAction(showActiveProgram: false)),
        editProgram: () => store.dispatch(NavigateToEditProgramPageAction()),
        navigateToWorkoutSummary: (workoutProgressId, date ) {
          store.dispatch(OnViewWorkoutSummaryAction(item: CompletedWorkoutListItem(
            originDate: date,
            workoutProgressId: workoutProgressId,
          )));
          //store.dispatch(NavigateToWorkoutSummaryPageWithBundleAction(bundle: bundle))
        },

        onStartWorkout: (workout, startDate) =>
            store.dispatch(NavigateToWorkoutPreviewPageAction(workout, startDate: startDate)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && deepEquals(listItems, other.listItems);

  @override
  int get hashCode => deepHash(listItems);
}
