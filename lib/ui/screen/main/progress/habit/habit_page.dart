import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/model/loading_state/habit_page_state.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:ui_kit/ui_kit.dart';
import 'habit_list.dart';

class HabitPage extends StatefulWidget {
  final int progressPageIndex;

  HabitPage({@required this.progressPageIndex});

  @override
  _HabitPageState createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> _tabs;
  List<HabitDto> _habitModelList = [];
  Function _recentRequest;
  bool _showProgress;
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {
          _tabs = [];
          if (_habitModelList.isEmpty) {
            _recentRequest = () => store.dispatch(LoadHabitListAction());
            _recentRequest.call();
            _showProgress = true;
          } else {
            _showProgress = false;
          }
        },
        onInitialBuild: (vm) {
          if (vm.habitList.isNotEmpty) {
            _updateHabitModelList(vm);
            _showProgress = false;
            setState(() {});
          }
        },
        onWillChange: (oldVm, newVm) {
          if (oldVm.habitPageState != HabitPageState.LOADING &&
              newVm.habitPageState == HabitPageState.LOADING) {
            _showProgress = true;
          }
          if (oldVm.habitPageState == HabitPageState.LOADING &&
              newVm.habitPageState != HabitPageState.LOADING) {
            _showProgress = false;
          }
          if (!deepEquals(newVm.habitList, oldVm.habitList) ||
              !deepEquals(
                  newVm.progressHabitModels, oldVm.progressHabitModels)) {
            setState(() {
              isLocked = false;
            });
            _updateHabitModelList(newVm);
          }
          if (!oldVm.habitPageState.isError() && newVm.habitPageState.isError()) {
            final attrs = TfDialogAttributes(
              title: S.of(context).dialog_error_title,
              description: newVm.habitPageState.getErrorMessage(),
              negativeText: S.of(context).dialog_error_recoverable_negative_text,
              positiveText: S.of(context).all__retry,
            );
            TfDialog.show(context, attrs).then((r) {
              if (r is Cancel) {
                Navigator.of(context).pop();
              } else {
                _recentRequest.call();
              }
            });
          }
        },
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  void _updateHabitModelList(_ViewModel vm) {
    _habitModelList.clear();
    final modelsFromList = vm.habitList
        .map((h) => HabitDto(
            id: null,
            recommended: h.id == vm.recommendedHabit.id,
            chosen: false,
            habit: h))
        .toList();

    _habitModelList.addAll(modelsFromList);

    _habitModelList.sort((a, b) {
      if (a.recommended && !b.recommended) {
        return -1;
      }
      if (!a.recommended && b.recommended) {
        return 1;
      }

      return a.habit.name.compareTo(b.habit.name);
    });

    vm.progressHabitModels.forEach((e) {
      final listToUpdate =
          _habitModelList.where((h) => h.habit.id == e.habit.id).toList();
      listToUpdate.forEach((m) {
        m.chosen = e.chosen;
        m.id = e.id;
      });
    });

    if (_tabs.isEmpty) {
      _tabs = _buildTabs(_habitModelList);
      _tabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: 0);
    }
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
    appBar: SimpleAppBar(
      leadingType: LeadingType.back,
      leadingAction: () => Navigator.of(context).pop(),
      leadingColor: AppColorScheme.colorPurple2,
      title: S.of(context).healthy_habits,
    ),
    backgroundColor: AppColorScheme.colorBlack,
    body: Stack(
      children: [
        Column(
          children: [
            _tabBar(vm),
            Expanded(
              child: _tabs.isNotEmpty
                  ? DefaultTabController(
                      length: _tabs.length,
                      child: TabBarView(
                        controller: _tabController,
                        children: _buildPages(vm),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
        _showProgress
            ? Positioned.fill(child: CircularLoadingIndicator())
            : Container()
      ],
    ),
  );

  Widget _tabBar(_ViewModel vm) => _tabController != null ?
    Material(
      color: AppColorScheme.colorBlack,
      child: TabBar(
        controller: _tabController,
        tabs: _tabs,
        isScrollable: true,
        indicatorColor: AppColorScheme.colorPurple2,
        unselectedLabelColor:
        AppColorScheme.colorPrimaryWhite.withOpacity(0.68),
        labelColor: AppColorScheme.colorPurple2,
        labelStyle: title16,
      ),
    ) : Container();

  List<Widget> _buildTabs(List<HabitDto> habits) {
    Set<String> tags = habits.map((e) {
      return e.habit.tag;
    }).toSet();
    return tags
        .map(
          (tag) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Text(
              tag.replaceAll('_', ' '),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildPages(_ViewModel vm) {
    Set<String> tags = _habitModelList.map((e) => e.habit.tag).toSet();
    return tags
        .map(
          (tag) => Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: HabitList(
              activatedCount: _habitModelList
                  .where((element) => element.chosen)
                  .toList()
                  .length,
              list: _habitModelList
                  .where((element) =>
                      element.recommended || element.habit.tag == tag)
                  .toList(),
              onHabitPressed: (model) {
                if (!isLocked) {
                  _recentRequest = () => vm.selectHabit(model.habit.id, model.id,
                      today(), !model.chosen, model.habit.name);
                  _recentRequest.call();
                }
                setState(() {
                  isLocked = true;
                });
              },
              key: PageStorageKey('HabitPage${tag.hashCode}'),
            ),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }
}

class _ViewModel {
  List<Habit> habitList;
  Habit recommendedHabit;
  List<HabitDto> progressHabitModels;
  HabitPageState habitPageState;
  Function loadHabitList;
  Function(String, String, String, bool, String) selectHabit;

  _ViewModel({
    @required this.habitList,
    @required this.recommendedHabit,
    @required this.selectHabit,
    @required this.progressHabitModels,
    @required this.loadHabitList,
    @required this.habitPageState,
  });

  static _ViewModel fromStore(
    Store<AppState> store,
  ) {
    return _ViewModel(
      habitList: store.state.mainPageState.habitList,
      recommendedHabit: store.state.mainPageState.recommendedHabit,
      progressHabitModels:
          store.state.mainPageState.progressPages.last.habitModels,
      loadHabitList: () => store.dispatch(LoadHabitListAction()),
      selectHabit: (habitId, habitModelId, date, selected, habit) =>
          store.dispatch(SelectHabitAction(
              habitId: habitId,
              habitModelId: habitModelId,
              date: today(),
              selected: selected,
              habit: habit)),
      habitPageState: store.state.mainPageState.habitPageState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          deepEquals(habitList, other.habitList) &&
          deepEquals(progressHabitModels, other.progressHabitModels) &&
          habitPageState == other.habitPageState &&
          recommendedHabit == other.recommendedHabit;

  @override
  int get hashCode =>
      deepHash(progressHabitModels) ^
      deepHash(habitList) ^
      habitPageState.hashCode ^
      recommendedHabit.hashCode;
}
