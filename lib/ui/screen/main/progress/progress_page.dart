import 'package:totalfit/model/loading_state/workout_of_the_day_state.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/purchase_item.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/discount_item_widget.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/model/loading_state/environmental_page_state.dart';
import 'package:totalfit/model/loading_state/habit_completion_state.dart';
import 'package:totalfit/model/loading_state/statement_update_state.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/model/statement.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/progress/skeleton/skeleton_item_widget.dart';
import 'helper.dart';
import 'item_widgets/breathing_item_widget.dart';
import 'item_widgets/empty_state_item_widget.dart';
import 'item_widgets/environmental_widget.dart';
import 'item_widgets/habit_item_widget.dart';
import 'item_widgets/mood_item_widget.dart';
import 'item_widgets/progress_header_item_widget.dart';
import 'item_widgets/progress_workout_item_widget.dart';
import 'item_widgets/story_and_statements_item_widget.dart';
import 'item_widgets/wisdom_item_widget.dart';
import 'onboarding/hexagon_onboarding_page.dart';
import 'progress_view_pager.dart';

class ProgressPage extends StatefulWidget {
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final Function(bool) loadingCallback;
  final int index;

  const ProgressPage(
      {@required this.nextPage,
      @required this.previousPage,
      @required this.loadingCallback,
      @required this.index,
      Key key})
      : super(key: key);

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller;
  List<ProgressListItem> items = [];
  Function _lastRequest;
  bool _showProgress;
  String priority = 'Body';

  @override
  void initState() {
    _showProgress = false;
    widget.loadingCallback(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store, widget.index),
        onInit: (store) {
          _controller = ScrollController();
          items.addAll(buildItemList(
              store.state.mainPageState.progressPages[widget.index]));
        },
        onWillChange: (oldVm, newVm) {
          if (oldVm.model.hexagonState != newVm.model.hexagonState ||
              !deepEquals(
                  oldVm.model.moodTrackingList, newVm.model.moodTrackingList)) {
            _controller.animateTo(0.0,
                duration: Duration(milliseconds: 150), curve: Curves.easeIn);
          }

          if (oldVm.model.priority != newVm.model.priority) {
            priority = newVm.model.priority;
          }

          if (oldVm.model.statementUpdateState !=
              newVm.model.statementUpdateState) {
            final newState = newVm.model.statementUpdateState;
            if (oldVm.model.statementUpdateState !=
                    StatementUpdateState.UPDATING &&
                newState == StatementUpdateState.UPDATING) {
              _showProgress = true;
              widget.loadingCallback(_showProgress);
            }
            if (oldVm.model.statementUpdateState ==
                    StatementUpdateState.UPDATING &&
                newState != StatementUpdateState.UPDATING) {
              _showProgress = false;
              widget.loadingCallback(_showProgress);
            }
            if (!oldVm.model.statementUpdateState.isError() &&
                newState.isError()) {
              final attrs = TfDialogAttributes(
                title: S.of(context).dialog_error_title,
                description: newState.getErrorMessage(),
                negativeText:
                    S.of(context).dialog_error_recoverable_negative_text,
                positiveText: S.of(context).all__retry,
              );

              TfDialog.show(context, attrs).then((r) {
                if (r is Cancel) {
                  newVm.removeUpdateStatementError(widget.index);
                } else {
                  _lastRequest.call();
                }
              });
            }
          }

          if (oldVm.model.habitCompletionState !=
              newVm.model.habitCompletionState) {
            final newState = newVm.model.habitCompletionState;
            if (oldVm.model.habitCompletionState !=
                    HabitCompletionState.UPDATING &&
                newState == HabitCompletionState.UPDATING) {
              _showProgress = true;
              widget.loadingCallback(_showProgress);
            }
            if (oldVm.model.habitCompletionState ==
                    HabitCompletionState.UPDATING &&
                newState != HabitCompletionState.UPDATING) {
              _showProgress = false;
              widget.loadingCallback(_showProgress);
            }
            if (!oldVm.model.habitCompletionState.isError() &&
                newState.isError()) {
              final attrs = TfDialogAttributes(
                title: S.of(context).dialog_error_title,
                description: newState.getErrorMessage(),
                negativeText:
                    S.of(context).dialog_error_recoverable_negative_text,
                positiveText: S.of(context).all__retry,
              );
              TfDialog.show(context, attrs).then((r) {
                if (r is Cancel) {
                  newVm.removeHabitCompletionToggleError();
                } else {
                  _lastRequest.call();
                }
              });
            }
          }

          if (oldVm.model.environmentalPageState !=
              newVm.model.environmentalPageState) {
            final newState = newVm.model.environmentalPageState;
            if (oldVm.model.environmentalPageState !=
                    EnvironmentalPageState.UPDATING &&
                newState == EnvironmentalPageState.UPDATING) {
              _showProgress = true;
              widget.loadingCallback(_showProgress);
            }
            if (oldVm.model.environmentalPageState ==
                    EnvironmentalPageState.UPDATING &&
                newState != EnvironmentalPageState.UPDATING) {
              _showProgress = false;
              widget.loadingCallback(_showProgress);
            }
            if (!oldVm.model.environmentalPageState.isError() &&
                newState.isError()) {
              TfDialog.show(
                      context,
                      TfDialogAttributes(
                          title: S.of(context).dialog_error_title,
                          description: newState.getErrorMessage()))
                  .then((r) {
                if (r is Cancel) {
                  newVm.removeEnvironmentalToggleError();
                } else {
                  _lastRequest.call();
                }
              });
            }
          }

          if (oldVm.model != newVm.model) {
            items.clear();
            items.addAll(buildItemList(newVm.model));
          }
          if (oldVm.model.isLoading() != newVm.model.isLoading()) {
            widget.loadingCallback(newVm.model.isLoading());
          }
        },
        onDispose: (store) {
          _controller.dispose();
        },
        builder: (context, vm) => vm.showHexagonOnBoarding
            ? HexagonOnBoardingPage(
                video: vm.model.breathingModel.video, index: widget.index)
            : _buildContent(vm, context));
  }

  Widget _buildContent(_ViewModel vm, BuildContext context) => Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: _buildChildren(vm, context)),
      );

  Widget _buildChildren(_ViewModel vm, BuildContext context) {
    return Material(
      color: AppColorScheme.colorBlack,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView.builder(
                controller: _controller,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  if (item is ProgressHeaderListItem) {
                    return ProgressHeaderWidget(
                        nextArrowVisible: _isLoaded(vm) &&
                            (widget.index != PROGRESS_STUB_PAGES_COUNT - 1),
                        previousArrowVisible:
                            _isLoaded(vm) && !vm.model.isInErrorState(),
                        nextPage: widget.nextPage,
                        previousPage: widget.previousPage,
                        item: item,
                        onHexagonExpansionChanged: (isExpanded) =>
                            vm.onHexagonExpansionChanged(isExpanded));
                  }

                  if (item is LoadingIndicatorItem) {
                    return SkeletonBodyWidget();
                  }

                  if (item is ProgressDiscountListItem &&
                      isToday(vm) &&
                      !vm.isPremiumUser && vm.discountProduct != null) {

                    return DiscountItemWidget.easter(
                      name: 'easter',
                      onClose: () {
                        setState(() {
                          items.removeWhere(
                                  (e) => e is ProgressDiscountListItem);
                        });
                        vm.changeDiscountEnableValue(false);
                      },
                    );
                  }

                  if (item is WorkoutListItem) {
                    return ProgressWorkoutWidget(
                        onWorkoutSelected: () {
                          if (isToday(vm)) {
                            vm.toggleWODSelection
                                .call(WorkoutOfTheDayState.LOADING);
                            if (item.progressState.toString().toLowerCase() ==
                                "completed") {
                              vm.onWorkoutDoneSelected();
                            } else {
                              vm.onWorkoutSelected(
                                  item.workoutProgressList.last.workout);
                            }
                          }
                        },
                        navigateToWorkoutSelectionPage: () {
                          vm.navigateToWorkoutSelectionPage();
                        },
                        item: item,
                        key: ValueKey('PageHeaderWorkoutSummaryWidget'));
                  }

                  if (item is EnvironmentalListItem) {
                    return EnvironmentalListItemWidget(
                      item: item,
                      key: ValueKey('EnvironmentalListItemWidget'),
                      onSaveValue: (value) {
                        if (isToday(vm)) {
                          _lastRequest =
                              () => vm.saveEnvironmental(value, widget.index);
                          _lastRequest.call();
                        }
                      },
                    );
                  }

                  if (item is BreathingListItem) {
                    return BreathingItemWidget(
                        item: item,
                        key: ValueKey('BreathingListItem'),
                        onSelected: () {
                          if (isToday(vm)) {
                            vm.navigateToBreathingPage(
                                widget.index, item.breathingModel.video);
                          }
                        });
                  }

                  if (item is HabitListItem) {
                    return HabitListItemWidget(
                        item: item,
                        isToday: isToday(vm),
                        onUpdateHabit: (model) {
                          if (isToday(vm)) {
                            vm.toggleHabitSelection(
                                !model.completed, model.id, model.habit.name);
                          }
                        },
                        key: ValueKey('HabitListItemWidget'),
                        openHabitPicker: () {
                          if (isToday(vm)) {
                            vm.navigateToHabitPage(widget.index);
                          }
                        });
                  }

                  if (item is WisdomListItem) {
                    return WisdomListItemWidget(
                        item: item,
                        key: ValueKey('WisdomListItemWidget'),
                        onSelected: () {
                          if (isToday(vm)) {
                            vm.navigateToWisdomPage(
                                widget.index, item.wisdomModel.name);
                          }
                        });
                  }

                  if (item is StoryAndStatementListItem) {
                    return StoryAndStatementsListItemWidget(
                        item: item,
                        isClickable: isToday(vm),
                        key: ValueKey('StoryListItemWidget'),
                        onStatementChanged: (statement) {
                          _lastRequest =
                              () => vm.updateStatement(statement, widget.index);
                          _lastRequest.call();
                        },
                        onStorySelected: () {
                          if (isToday(vm)) {
                            vm.navigateToStoryPage(
                                widget.index, item.storyModel.name);
                          }
                        });
                  }

                  if (item is MoodListProgressItem) {
                    return MoodListItemWidget(
                        item: item.moodList,
                        isToday: isToday(vm),
                        key: ValueKey('MoodListItemWidget'));
                  }

                  if (item is EmptyStateItem) {
                    return EmptyStateItemWidget();
                  }

                  if (item is ErrorItem) {
                    final hexSize = MediaQuery.of(context).size.width * 0.7;
                    return Container(
                      height: (MediaQuery.of(context).size.height -
                          hexSize -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          215),
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.error,
                              style: title20.copyWith(
                                color: AppColorScheme.colorPrimaryWhite,
                              ),
                            ),
                            Container(
                              height: 16.0,
                            ),
                            ActionButton(
                              text: S.of(context).all__retry,
                              padding: EdgeInsets.all(32.0),
                              onPressed: () => vm.retryLoading(
                                  DateTime.parse(vm.model.date), widget.index),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (item is SpaceItem) {
                    return Container(height: 63);
                  }

                  return Container();
                },
              ),
            ),
            _showProgress
                ? Positioned.fill(
                    child: Container(
                      color: AppColorScheme.colorPrimaryBlack.withOpacity(0.62),
                      child: CircularLoadingIndicator(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  bool _isLoaded(_ViewModel vm) => !vm.model.isLoading();

  @override
  bool get wantKeepAlive => true;

  bool isToday(_ViewModel vm) =>
      isTodayDate(DateTime.parse(vm.model.date).millisecondsSinceEpoch);
}

class _ViewModel {
  final Function(WorkoutDto) onWorkoutSelected;
  final Function() onWorkoutDoneSelected;
  final Function(int, String) navigateToStoryPage;
  final Function(int, String) navigateToWisdomPage;
  final Function(int) navigateToHabitPage;
  final Function navigateToWorkoutSelectionPage;
  final Function(int, String) navigateToBreathingPage;
  final Function(DateTime, int) retryLoading;
  final Function(Statement, int) updateStatement;
  final Function(int, int) saveEnvironmental;
  final Function(bool, String, String) toggleHabitSelection;
  final Function(WorkoutOfTheDayState) toggleWODSelection;
  final Function(int) removeUpdateStatementError;
  final Function removeHabitCompletionToggleError;
  final Function removeEnvironmentalToggleError;
  final Function onHexagonExpansionChanged;
  final Function refreshHexagon;
  final ProgressPageModel model;
  final bool showHexagonOnBoarding;
  final List<PurchaseItem> annualPurchaseItems;
  final bool isPremiumUser;
  final Function changeDiscountEnableValue;
  final PurchaseItem discountProduct;

  _ViewModel(
      {@required this.navigateToStoryPage,
      @required this.navigateToWisdomPage,
      @required this.navigateToHabitPage,
      @required this.updateStatement,
      @required this.saveEnvironmental,
      @required this.navigateToWorkoutSelectionPage,
      @required this.navigateToBreathingPage,
      @required this.onWorkoutSelected,
      @required this.onWorkoutDoneSelected,
      @required this.retryLoading,
      @required this.toggleHabitSelection,
      @required this.removeUpdateStatementError,
      @required this.removeHabitCompletionToggleError,
      @required this.removeEnvironmentalToggleError,
      @required this.changeDiscountEnableValue,
      @required this.model,
      @required this.onHexagonExpansionChanged,
      @required this.refreshHexagon,
      @required this.showHexagonOnBoarding,
      @required this.annualPurchaseItems,
      @required this.isPremiumUser,
      @required this.toggleWODSelection,
      @required this.discountProduct});

  static _ViewModel fromStore(Store<AppState> store, int progressIndex) =>
      _ViewModel(
          isPremiumUser: store.state.isPremiumUser(),
          annualPurchaseItems:
              store.state.mainPageState.purchaseItems.isNotEmpty
                  ? store.state.mainPageState.purchaseItems
                      .where((p) => p.itemType == PurchaseItemType.annual)
                      .toList()
                  : [],
          changeDiscountEnableValue: (bool value) =>
              store.dispatch(DiscountChangeValueAction(value: value)),
          discountProduct: store.state.mainPageState.discountProduct,
          showHexagonOnBoarding:
              store.state.preferenceState.showHexagonOnBoarding,
          model: store.state.mainPageState.progressPages[progressIndex],
          navigateToStoryPage: (index, name) => store.dispatch(
              NavigateToStoryPageAction(
                  progressPageIndex: index, storyName: name)),
          navigateToHabitPage: (progressIndex) => store.dispatch(
              NavigateToHabitPageAction(progressPageIndex: progressIndex)),
          removeUpdateStatementError: (progressIndex) => store.dispatch(
              RemoveUpdateStatementErrorAction(progressIndex: progressIndex)),
          removeHabitCompletionToggleError: () =>
              store.dispatch(RemoveHabitCompletionToggleErrorAction()),
          removeEnvironmentalToggleError: () =>
              store.dispatch(RemoveEnvironmentalToggleErrorToggleErrorAction()),
          retryLoading: (date, index) => store.dispatch(
              RetryLoadingProgressPageAction(date: date, index: index)),
          toggleWODSelection: (status) =>
              store.dispatch(OnChangeWODLoadingAction(status)),
          toggleHabitSelection: (completed, habitProgressId, habit) =>
              store.dispatch(OnToggleHabitCompletionAction(completed: completed, habitProgressId: habitProgressId, habit: habit)),
          navigateToWorkoutSelectionPage: () => store.dispatch(ShowSortedWorkoutsAction()),
          navigateToWisdomPage: (index, name) => store.dispatch(NavigateToWisdomPageAction(progressPageIndex: index, wisdomName: name)),
          navigateToBreathingPage: (index, video) => store.dispatch(NavigateToBreathingPageAction(progressPageIndex: index, video: video)),
          updateStatement: (statement, progressIndex) => store.dispatch(UpdateStatementAction(statement: statement, progressIndex: progressIndex)),
          saveEnvironmental: (value, progressIndex) => store.dispatch(SaveEnvironmentalResultAction(value: value, progressIndex: progressIndex)),
          onWorkoutSelected: (workout) => store.dispatch(NavigateToWorkoutPreviewPageAction(workout)),
          onWorkoutDoneSelected: () {
            store.dispatch(OnViewWorkoutSummaryAction(
                item: CompletedWorkoutListItem(
              originDate: DateTime.now(),
              workoutProgressId: store.state.mainPageState.progressPages.last
                  .workoutProgressList.last.id,
            )));
          },
          onHexagonExpansionChanged: (expanded) => store.dispatch(OnHexagonExpansionChangedAction(isExpanded: expanded)),
          refreshHexagon: () => store.dispatch(UpdateHexagonAction(store.state.mainPageState.progressPageIndex)));

  @override
  int get hashCode => model.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _ViewModel &&
      runtimeType == other.runtimeType &&
      model == other.model;
}

class SkeletonBodyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(3, (index) => SkeletonItemWidget()),
    );
  }
}
