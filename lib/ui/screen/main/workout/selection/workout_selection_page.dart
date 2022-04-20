import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/utils/locales_service.dart';
import 'package:ui_kit/ui_kit.dart';

import 'workout_list_page.dart';

final LocalesService _localesService = DependencyProvider.get<LocalesService>();

class WorkoutSelectionPage extends StatefulWidget {
  const WorkoutSelectionPage({Key key}) : super(key: key);

  @override
  _WorkoutSelectionPageState createState() => _WorkoutSelectionPageState();
}

class _WorkoutSelectionPageState extends State<WorkoutSelectionPage>
    with SingleTickerProviderStateMixin {
  void _onTabTapped(int index) {
    PageStorage.of(context)
        .writeState(context, _tabController.index, identifier: "tab");
  }

  List<Widget> _tabs = <Widget>[
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        _localesService.locales.time.toUpperCase(),
        style: title16.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        _localesService.locales.equipment.toUpperCase(),
        style: title16.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        _localesService.locales.program_setup_summary__level.toUpperCase(),
        style: title16.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
      ),
    ),
  ];

  static const List<Widget> _pages = <Widget>[
    WorkoutListPage(
        type: WorkoutListType.Time, key: PageStorageKey('WorkoutListPage1')),
    WorkoutListPage(
        type: WorkoutListType.Equipment,
        key: PageStorageKey('WorkoutListPage2')),
    WorkoutListPage(
        type: WorkoutListType.Level, key: PageStorageKey('WorkoutListPage3')),
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    int initialIndex =
        PageStorage.of(context).readState(context, identifier: "tab") ?? 0;
    _tabController = TabController(
        vsync: this, length: _tabs.length, initialIndex: initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onWillChange: (previousVm, newVm) {},
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
    appBar: SimpleAppBar(
      leadingType: LeadingType.back,
      leadingAction: () => Navigator.of(context).pop(),
      title: S.of(context).programs_progress__workouts,
      bottom: TabBar(
        controller: _tabController,
        onTap: _onTabTapped,
        tabs: _tabs,
        isScrollable: true,
        indicatorColor: AppColorScheme.colorYellow
      ),
    ),
    body: DefaultTabController(
      length: 3,
      child: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    ),
  );
}

class _ViewModel {
  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
