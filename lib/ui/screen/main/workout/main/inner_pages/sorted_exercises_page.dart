import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/utils.dart';

import 'relative_exercises_page.dart';

class SortedExercisesPage extends StatefulWidget {
  final String initialTag;

  const SortedExercisesPage({@required this.initialTag, Key key}) : super(key: key);

  @override
  _SortedExercisesPageState createState() => _SortedExercisesPageState();
}

class _SortedExercisesPageState extends State<SortedExercisesPage> with SingleTickerProviderStateMixin {
  List<Widget> _tabs;
  List<Widget> _pages;
  TabController _tabController;
  int _initialIndex;

  Function _recentRequest;
  bool _showProgress;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {
          if (store.state.mainPageState.sortedExercises.isEmpty) {
            _recentRequest = () => store.dispatch(LoadExerciseListAction());
            _recentRequest.call();
            _showProgress = true;
          } else {
            _showProgress = false;
          }
        },
        onInitialBuild: (vm) {
          if (vm.sortedExercises.isNotEmpty) {
            _buildItemList(vm);
            _showProgress = false;
            setState(() {});
          }
        },
        converter: _ViewModel.fromStore,
        onWillChange: (oldVm, newVm) {
          if (!deepEquals(newVm.sortedExercises, oldVm.sortedExercises)) {
            _buildItemList(newVm);
          }
          if (oldVm.pageState != SortedExercisePageState.LOADING &&
              newVm.pageState == SortedExercisePageState.LOADING) {
            _showProgress = true;
          }
          if (oldVm.pageState == SortedExercisePageState.LOADING &&
              newVm.pageState != SortedExercisePageState.LOADING) {
            _showProgress = false;
          }
          if (!oldVm.pageState.isError() && newVm.pageState.isError()) {
            final attrs = TfDialogAttributes(
              title: S.of(context).dialog_error_title,
              description: newVm.pageState.getErrorMessage(),
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
        builder: (context, vm) => _buildContent(vm),
        onDispose: (store) {
          if (_tabController != null) {
            _tabController.dispose();
          }
        });
  }

  _buildItemList(_ViewModel vm) {
    _tabs = List.from(vm.sortedExercises.keys)
        .map(
          (tab) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Text(
              tab.replaceAll('_', ' '),
              style: title16.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ),
        )
        .toList();
    _pages = [];
    vm.sortedExercises.entries.forEach(
      (element) {
        _pages.add(
          RelativeExercisesPage(
            exerciseTag: element.key,
            key: PageStorageKey(element.key),
          ),
        );
      },
    );

    _initialIndex = vm.sortedExercises.keys.toList().indexOf(widget.initialTag);
    _tabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: _initialIndex == -1 ? 0 : _initialIndex);
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        appBar: SimpleAppBar(
            leadingType: LeadingType.back,
            leadingAction: () => Navigator.of(context).pop(),
            title: S.of(context).exercises),
        backgroundColor: AppColorScheme.colorBlack,
        body: Stack(
          fit: StackFit.loose,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _tabBar(vm),
                Expanded(
                    child: _tabController != null
                        ? DefaultTabController(
                            length: _tabs.length,
                            child: TabBarView(
                              controller: _tabController,
                              children: _pages,
                            ),
                          )
                        : Container()),
              ],
            ),
            _showProgress
                ? Positioned.fill(
                    child: CircularLoadingIndicator(),
                  )
                : Container(),
          ],
        ),
      );

  Widget _tabBar(_ViewModel vm) => Column(
        children: <Widget>[
          _tabController != null
              ? Material(
                  color: AppColorScheme.colorBlack,
                  child: TabBar(
                    controller: _tabController,
                    tabs: _tabs,
                    isScrollable: true,
                    indicatorColor: AppColorScheme.colorYellow,
                  ),
                )
              : Container(),
        ],
      );
}

class _ViewModel {
  Map<String, Set<Exercise>> sortedExercises;
  SortedExercisePageState pageState;

  _ViewModel({@required this.sortedExercises, @required this.pageState});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      sortedExercises: store.state.mainPageState.sortedExercises,
      pageState: store.state.mainPageState.sortedExercisePageState,
    );
  }
}

class SortedExercisePageState {
  static const SortedExercisePageState INITIAL = SortedExercisePageState._("INITIAL", null);
  static const SortedExercisePageState LOADING = SortedExercisePageState._("LOADING", null);
  static const SortedExercisePageState COMPLETED = SortedExercisePageState._("COMPLETED", null);

  final String _name;
  final String _error;

  factory SortedExercisePageState.error(String error) {
    return SortedExercisePageState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const SortedExercisePageState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortedExercisePageState &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;

  @override
  String toString() => _name;
}
