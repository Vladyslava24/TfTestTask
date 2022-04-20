import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/program_request.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/domain/bloc/program_summary_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/model/program_days_of_week.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/choose_program_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/programs/setup/widgets/program_setup_summary_widget.dart';
import 'package:totalfit/ui/screen/paywall_screen.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramSetupSummaryScreen extends StatefulWidget {
  final ProgramSummaryMode mode;
  final LevelType level;
  final int numberOfWeeks;
  final String startDate;
  final String targetId;
  final List<int> selectedDays;

  ProgramSetupSummaryScreen(
    this.mode, {
    @required this.level,
    @required this.numberOfWeeks,
    @required this.startDate,
    @required this.targetId,
    @required this.selectedDays,
  });

  @override
  _ProgramSetupSummaryScreenState createState() => _ProgramSetupSummaryScreenState();
}

class _ProgramSetupSummaryScreenState extends State<ProgramSetupSummaryScreen> {
  final ValueNotifier<DateTime> _birthDayNotifier = ValueNotifier<DateTime>(DateTime.now());
  DateTime _selectedDate;
  String _selectedDateText = "";
  final _block = ProgramSummaryBlock();
  UpdateProgramEvent _updateProgramEvent;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      onInit: (store) {
        if (widget.mode == ProgramSummaryMode.Start) {
          _setSelectedDate(DateTime.now(), () => store.dispatch(SendStartDateSelectedEventAction(_selectedDateText)));
        } else {
          _setSelectedDate(DateTime.parse(widget.startDate),
              () => store.dispatch(SendStartDateSelectedEventAction(_selectedDateText)));
        }
      },
      converter: _ViewModel.fromStore,
      builder: (context, vm) => BlocListener<ProgramSummaryBlock, UpdateProgramEvent>(
        bloc: _block,
        child: Stack(children: [
          _buildContent(context, vm, screenWidth),
          Positioned.fill(child: Visibility(visible: _updateProgramEvent is Loading, child: DimmedCircularLoadingIndicator()))
        ]),
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
            if (widget.mode == ProgramSummaryMode.Start) {
              vm.onProgramStarted(state.program, state.workoutProgress);
            } else {
              vm.onProgramUpdated(state.program);
            }
          }

          setState(() {
            _updateProgramEvent = state;
          });
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, _ViewModel vm, double screenWidth) => Scaffold(
        appBar: SimpleAppBar(
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.of(context).pop(),
          title: S.of(context).program_setup_summary__app_bar_title,
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: WillPopScope(
            onWillPop: () => _onBackPressed(vm),
            child: _buildItemList(vm),
          ),
        ),
      );

  Widget _buildItemList(_ViewModel vm) {
    bool isDateEditable = (widget.mode == ProgramSummaryMode.Start) || isTodayOrAfter(DateTime.parse(widget.startDate));
    return Stack(
      children: <Widget>[
        Column(
          children: [
            ProgramSetupSummaryWidget(
              title: S.of(context).program_setup_summary__level,
              value: widget.level.key,
            ),
            ProgramSetupSummaryWidget(
              title: S.of(context).program_setup_summary__number_of_weeks,
              value: "${widget.numberOfWeeks} ${S.of(context).choose_program_number_of_weeks_screen__weeks}",
            ),
            ProgramSetupSummaryWidget(
              title: S.of(context).program_setup_summary__days_of_the_week,
              value: widget.selectedDays.map((i) => DayOfWeek.LIST[i].stringValue(context)).join(", "),
            ),
            GestureDetector(
              onTap: () {
                if (isDateEditable) {
                  _showNativeDatePicker(vm);
                }
              },
              child: ProgramSetupSummaryWidget(
                isEditable: isDateEditable,
                title: S.of(context).program_setup_summary__start_date,
                value: _selectedDateText,
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ActionButton(
            text: widget.mode == ProgramSummaryMode.Start
                ? S.of(context).program_setup_summary__start_program.toUpperCase()
                : S.of(context).program_setup_summary__update_program.toUpperCase(),
            color: AppColorScheme.colorYellow,
            textColor: AppColorScheme.colorPrimaryBlack,
            padding: const EdgeInsets.all(16),
            onPressed: () async {
              if (vm.isPremiumUser) {
                _sendRequest();
              } else {
                final subscribed = await PaywallScreen.show(context);
                if (subscribed != null && subscribed) {
                  _sendRequest();
                }
              }
            },
          ),
        ),
        //   _progressIndicator(vm),
      ],
    );
  }

  _sendRequest() {
    var request = ProgramRequest(
        level: widget.level.key,
        numberOfWeeks: widget.numberOfWeeks,
        targetId: widget.targetId,
        startDate: toServerDateFormat(_selectedDateText),
        daysOfWeek: widget.selectedDays.map((i) => DayOfWeek.LIST[i].key).toList());
    _block.add(BlockAction(widget.mode, request: request));
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }

  _showNativeDatePicker(_ViewModel vm) {
    if (Platform.isIOS) {
      _showIosDatePicker(vm);
    } else {
      _showMaterialDatePicker(vm);
    }
  }

  _showIosDatePicker(_ViewModel vm) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            initialDateTime:
                _selectedDateText.isEmpty ? DateTime.now() : DateTime.parse(ensureValidFormat(_selectedDateText)),
            onDateTimeChanged: (DateTime newDate) {
              _selectedDate = newDate;
            },
            mode: CupertinoDatePickerMode.date,
          ),
        );
      },
    );
    if (_selectedDate != null) {
      _setSelectedDate(_selectedDate, () => vm.sendStartDateSelectedEvent(_selectedDateText));
    }
  }

  void _setSelectedDate(DateTime dateTime, VoidCallback sendStartDateSelectedEvent) {
    if (dateTime != null) {
      if (_birthDayNotifier != null) {
        _birthDayNotifier.value = dateTime;
      }
      final formattedDate = unifiedUiDateFormat(dateTime);
      _selectedDateText = formattedDate;
      sendStartDateSelectedEvent();
    }
  }

  _showMaterialDatePicker(_ViewModel vm) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    _setSelectedDate(selectedDate, () => vm.sendStartDateSelectedEvent(_selectedDateText));
  }
}

class _ViewModel {
  final Function(ActiveProgram, WorkoutProgressDto) onProgramStarted;
  final Function(ActiveProgram) onProgramUpdated;
  final Function(String) sendStartDateSelectedEvent;
  final bool isPremiumUser;

  _ViewModel({
    this.isPremiumUser,
    this.onProgramStarted,
    this.onProgramUpdated,
    this.sendStartDateSelectedEvent,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isPremiumUser: store.state.isPremiumUser(),
      sendStartDateSelectedEvent: (date) => store.dispatch(SendStartDateSelectedEventAction(date)),
      onProgramStarted: (activeProgram, workoutProgress) {
        store.dispatch(SetActiveProgramAction(program: activeProgram));
        store.dispatch(SendProgramStartedEventAction(program: activeProgram));
        if (workoutProgress != null) {
          store.dispatch(UpdateWorkoutProgressOnProgramStartAction(progress: workoutProgress));
        }
        store.dispatch(SwitchProgramTabAction(showActiveProgram: activeProgram != null));
        store.dispatch(RefreshProgramOnListAction(isNeedToRefresh: true));
        store.dispatch(SetProgramLoadingAction(isLoading: false));
        store.dispatch(NavigateOnActiveProgramAction());
      },
      onProgramUpdated: (updatedProgram) {
        store.dispatch(OnProgramUpdatedAction(updatedProgram));
        store.dispatch(LoadProgramProgressPageAction());
      },
    );
  }
}

enum ProgramSummaryMode { Start, Update }
