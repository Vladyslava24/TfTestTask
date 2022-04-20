import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/domain/bloc/edit_program_bloc/edit_program_bloc.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/model/program_days_of_week.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/programs/setup/summary/program_setup_summary_screen.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class EditProgramScreen extends StatefulWidget {
  @override
  _EditProgramScreenState createState() => _EditProgramScreenState();
}

class _EditProgramScreenState extends State<EditProgramScreen> {
  LevelType _selectedLevel;
  int _selectedNumberOfWeeks;
  final Set<int> _selectedDays = {};
  EditProgramBloc _bloc;
  static const double _ITEM_HEIGHT = 48.0;
  static const double _ITEM_MARGIN = 4.0;

  static ColorTween _itemLevelBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  static ColorTween _itemLevelTextColorTween = ColorTween(
    begin: AppColorScheme.colorPrimaryWhite,
    end: AppColorScheme.colorPrimaryBlack,
  );

  static ColorTween _itemWeekBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  static ColorTween _itemWeekTextColorTween = ColorTween(
    begin: AppColorScheme.colorPrimaryWhite,
    end: AppColorScheme.colorPrimaryBlack,
  );

  static ColorTween _itemDayBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack4,
    end: AppColorScheme.colorYellow,
  );

  static ColorTween _itemDayTextColorTween = ColorTween(
    begin: AppColorScheme.colorPrimaryWhite,
    end: AppColorScheme.colorYellow,
  );

  static ColorTween _iconColorTween = ColorTween(
    begin: AppColorScheme.colorBlack4,
    end: AppColorScheme.colorBlack2,
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        _bloc = EditProgramBloc(remoteStorage: DependencyProvider.get<RemoteStorage>());
      },
      onInitialBuild: (vm) {
        _selectedDays.addAll(vm.selectedDays);
        _selectedNumberOfWeeks = vm.numberOfWeeks;
        _selectedLevel = vm.difficultyLevel;
      },
      distinct: true,
      onDispose: (_) => _bloc.close(),
      converter: _ViewModel.fromStore,
      builder: (context, vm) => BlocProvider.value(
        value: _bloc,
        child: Stack(children: [
          BlocConsumer<EditProgramBloc, EditProgramState>(listener: (BuildContext context, EditProgramState state) {
            if (state?.status == InterruptStatus.done) {
              vm.onProgramInterrupted(vm.program != null ? vm.program.id : null);
              Navigator.pop(context);
            }

            if (state?.exception is TfException) {
              final attrs = TfDialogAttributes(
                title: S.of(context).all__error,
                description: state.exception.toString(),
                negativeText: S.of(context).dialog_error_recoverable_negative_text,
                positiveText: S.of(context).all__retry,
              );
              TfDialog.show(context, attrs).then((result) {
                if (result is Confirm) {
                  _quitProgramRequest(vm);
                }
              });
            }
          }, builder: (BuildContext context, EditProgramState state) {
            return _buildContent(vm);
          }),
          BlocBuilder<EditProgramBloc, EditProgramState>(builder: (BuildContext context, EditProgramState state) {
            if (state.isLoading) {
              return Positioned.fill(child: DimmedCircularLoadingIndicator());
            }
            return Container();
          }),
        ]),
      ),
    );
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        appBar: SimpleAppBar(
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.of(context).pop(),
          title: S.of(context).program_edit_title,
          actionType: ActionType.button,
          actionFunction: () {
            final days = _selectedDays.toList();
            days.sort();
            vm.navigateToSummary(_selectedLevel, _selectedNumberOfWeeks, vm.startDate, vm.programId, days);
          },
          actionButtonText: S.of(context).all__save,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: WillPopScope(
            onWillPop: () => _onBackPressed(vm),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).program_edit_level.toUpperCase(),
                      style: textRegular10.copyWith(
                        color: AppColorScheme.colorBlack7,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: _ITEM_HEIGHT,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(cardBorderRadius),
                        color: AppColorScheme.colorBlack2,
                        shape: BoxShape.rectangle),
                    padding: EdgeInsets.all(6),
                    child: AnimatedItemPicker(
                      axis: Axis.horizontal,
                      itemCount: vm.levels.length,
                      expandedItems: true,
                      initialSelection: {vm.levels.indexOf(vm.difficultyLevel)},
                      onItemPicked: (index, selected) {
                        _selectedLevel = vm.levels[index];
                      },
                      itemBuilder: (index, animatedValue) => _ItemWidget(
                        name: vm.levels[index].uiName.toLowerCase(),
                        textStyle: title16,
                        backgroundColor: _itemLevelBackgroundColorTween.transform(animatedValue),
                        textColor: _itemLevelTextColorTween.transform(animatedValue),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).program_edit_number_of_weeks.toUpperCase(),
                      style: textRegular10.copyWith(
                        color: AppColorScheme.colorBlack7,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: _ITEM_HEIGHT,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(cardBorderRadius),
                      color: AppColorScheme.colorBlack2,
                      shape: BoxShape.rectangle,
                    ),
                    padding: EdgeInsets.all(6),
                    child: AnimatedItemPicker(
                      axis: Axis.horizontal,
                      itemCount: vm.weekList.length,
                      expandedItems: true,
                      initialSelection: {vm.weekList.indexOf(vm.numberOfWeeks)},
                      onItemPicked: (index, selected) {
                        _selectedNumberOfWeeks = vm.weekList[index];
                      },
                      itemBuilder: (index, animatedValue) => _ItemWidget(
                        name: vm.weekList[index].toString(),
                        textStyle: title14,
                        backgroundColor: _itemWeekBackgroundColorTween.transform(animatedValue),
                        textColor: _itemWeekTextColorTween.transform(animatedValue),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).program_edit_days.toUpperCase(),
                      style: textRegular10.copyWith(
                        color: AppColorScheme.colorBlack7,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: (_ITEM_HEIGHT + 2 * _ITEM_MARGIN) * DayOfWeek.LIST.length,
                    child: AnimatedItemPicker(
                      axis: Axis.vertical,
                      multipleSelection: true,
                      itemCount: DayOfWeek.LIST.length,
                      maxItemSelectionCount: 6,
                      initialSelection: vm.selectedDays != null ? Set.of(vm.selectedDays) : Set<int>(),
                      onItemPicked: (index, selected) {
                        if (_selectedDays.contains(index)) {
                          _selectedDays.remove(index);
                        } else {
                          _selectedDays.add(index);
                        }
                      },
                      itemBuilder: (index, animatedValue) => Container(
                        height: _ITEM_HEIGHT,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(cardBorderRadius),
                          color: AppColorScheme.colorBlack2,
                          shape: BoxShape.rectangle,
                        ),
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(top: _ITEM_MARGIN, bottom: _ITEM_MARGIN),
                        child: Row(
                          children: [
                            SizedBox(width: 6),
                            Container(
                                width: 26,
                                height: 26,
                                child: Icon(Icons.done, size: 23, color: _iconColorTween.transform(animatedValue)),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _itemDayBackgroundColorTween.transform(animatedValue),
                                    border: Border.all(color: Colors.yellow))),
                            SizedBox(width: 12),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                DayOfWeek.LIST[index].stringValue(context),
                                textAlign: TextAlign.center,
                                style: title16.copyWith(
                                  color: _itemDayTextColorTween.transform(animatedValue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColorScheme.colorBlack2,
                      shape: BoxShape.rectangle,
                    ),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _quitProgramRequest(vm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, color: AppColorScheme.colorRed),
                          SizedBox(width: 8),
                          Text(
                            S.of(context).quit_program,
                            textAlign: TextAlign.center,
                            style: title16.copyWith(
                              color: AppColorScheme.colorRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ]),
              ),
            ),
          ),
        ),
      );

  _quitProgramRequest(_ViewModel vm) {
    print('_quitProgramRequest');
    _bloc.add(QuitProgramAction());
    vm.sendPressedProgramQuitEventAction();
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }
}

class _ViewModel {
  final String programId;
  final String startDate;
  final List<int> selectedDays;
  final int numberOfWeeks;
  final LevelType difficultyLevel;
  final List<LevelType> levels;
  final ActiveProgram program;
  final Function(String) onProgramInterrupted;
  final Function sendPressedProgramQuitEventAction;
  final List<int> weekList;
  final Function(LevelType, int, String, String, List<int>) navigateToSummary;

  _ViewModel({
    this.programId,
    this.startDate,
    this.selectedDays,
    this.numberOfWeeks,
    this.difficultyLevel,
    this.program,
    this.levels,
    this.onProgramInterrupted,
    this.navigateToSummary,
    this.weekList,
    this.sendPressedProgramQuitEventAction,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      programId: store.state.programProgressState.activeProgram?.id,
      program: store.state.programProgressState.activeProgram,
      startDate: store.state.programProgressState.activeProgram?.schedule?.first?.workouts?.first?.date ?? today(),
      selectedDays: store.state.programProgressState.activeProgram?.daysOfTheWeek?.map((e) => e - 1)?.toList(),
      levels: store.state.programProgressState.activeProgram?.levels ?? [],
      numberOfWeeks: store.state.programProgressState.activeProgram?.numberOfWeeks,
      difficultyLevel: LevelType.fromJson(store.state.programProgressState.activeProgram?.difficultyLevel),
      weekList: List.generate(store.state.programProgressState.activeProgram?.maxWeekNumber ?? 0, (index) => index + 1),
      onProgramInterrupted: (programId) => store.dispatch(OnProgramInterruptedAction(programId)),
      sendPressedProgramQuitEventAction: () => store.dispatch(SendPressedProgramQuitEventAction()),
      navigateToSummary:
          (LevelType level, int numberOfWeeks, String startDate, String targetId, List<int> selectedDays) {
        store.dispatch(NavigateToProgramSetupSummaryPageAction(ProgramSummaryMode.Update,
            level: level,
            selectedDays: selectedDays,
            startDate: startDate,
            numberOfWeeks: numberOfWeeks,
            targetId: targetId));
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String name;
  final TextStyle textStyle;

  _ItemWidget(
      {@required this.name, @required this.textStyle, @required this.textColor, @required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: backgroundColor),
            color: backgroundColor,
            shape: BoxShape.rectangle),
        child: Text(name, style: textStyle.copyWith(color: textColor), textAlign: TextAlign.center));
  }
}
