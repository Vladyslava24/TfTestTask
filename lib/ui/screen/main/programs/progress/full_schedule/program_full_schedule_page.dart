import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/domain/bloc/program_schedule_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/profile_workout_summary_bundle.dart';
import 'package:totalfit/model/progress/program_schedule_item.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/redux/actions/program_full_schedule_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/programs/progress/widgets/program_schedule_item_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramFullSchedulePage extends StatefulWidget {
  @override
  _ProgramFullSchedulePageState createState() => _ProgramFullSchedulePageState();
}

class _ProgramFullSchedulePageState extends State<ProgramFullSchedulePage> {
  ScrollController _scrollController;
  final _block = ProgramScheduleBlock();
  LoadWorkoutSummaryAction _lastRequestAction;
  BlocEvent _blocEvent;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {
          _scrollController = ScrollController();
          store.dispatch(LoadProgramFullSchedulePageAction());
        },
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => BlocListener<ProgramScheduleBlock, BlocEvent>(
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

          if (state is OnWorkoutSummaryLoaded) {
            vm.navigateToWorkoutSummary(state.bundle);
          }

          setState(() {
            _blocEvent = state;
          });
        },
        child: Scaffold(
          backgroundColor: AppColorScheme.colorBlack,
          appBar: SimpleAppBar(
            leadingType: LeadingType.back,
            leadingAction: () => Navigator.of(context).pop(),
            title: S.of(context).program_schedule_title,
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: WillPopScope(
              onWillPop: () => _onBackPressed(vm),
              child: Stack(
                children: [
                  _buildItemList(vm),
                  Positioned.fill(
                    child: Visibility(
                      visible: _blocEvent is Loading,
                      child: DimmedCircularLoadingIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildItemList(_ViewModel vm) => Container(
        child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 0),
            itemCount: vm.listItems.length,
            itemBuilder: (context, index) {
              final item = vm.listItems[index];
              if (item is ProgramScheduleItem) {
                return ProgramScheduleItemWidget(
                  item: item,
                  onExpansionChanged: (expanded) {},
                  onItemClick: (item) {
                    if (item.workoutProgress.finished) {
                      _sendRequest(item.workoutProgress.id, item.workoutProgress.startedAt);
                    } else {
                      vm.onStartWorkout(item);
                    }
                  },
                );
              }
              return const SizedBox(height: 90);
            }),
      );

  _sendRequest(String workoutProgressId, String startedAt) {
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
  final List<FeedItem> listItems;
  final Function(ScheduledWorkoutItem) onStartWorkout;
  final Function(WorkoutSummaryBundle) navigateToWorkoutSummary;

  _ViewModel({
    this.onStartWorkout,
    this.navigateToWorkoutSummary,
    this.listItems,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        listItems: store.state.programFullScheduleState.listItems,
        navigateToWorkoutSummary: (bundle) =>
            store.dispatch(NavigateToWorkoutSummaryPageWithBundleAction(bundle: bundle)),
        onStartWorkout: (item) =>
            store.dispatch(NavigateToWorkoutPreviewPageAction(item.workoutProgress.workout, startDate: item.date)));
  }
}
