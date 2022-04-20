import 'dart:async';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:totalfit/ui/widgets/indexed_transition_switcher.dart';

import 'package:totalfit/ui/screen/main/profile/profile_screen.dart';
import 'package:totalfit/ui/screen/main/programs/program_tab.dart';
import 'package:totalfit/ui/screen/main/progress/progress_view_pager.dart';
import 'package:totalfit/ui/screen/main/explore/explore_screen.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:profile_api/profile_ui_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {
          if (store.state.config != null &&
              store.state.config.newFeatures.isNotEmpty) {
            store.dispatch(OnNewFeatureShownAction(
                deepHash(store.state.config.newFeatures)));
          }
        },
        onWillChange: (oldVm, newVm) {
          if (oldVm.error.isEmpty && newVm.error.isNotEmpty) {
            TfDialog.show(
                context,
                TfDialogAttributes(
                    title: 'Error',
                    description: newVm.error,
                    positiveText: 'ok'));
            newVm.hideError();
          }
        },
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => WillPopScope(
        onWillPop: () => _onBackPressed(vm),
        child: Scaffold(
          body: Stack(
            children: [
              IndexedTransitionSwitcher(
                  index: vm.selectedTab.index,
                  children: [
                    const ProgramTab(),
                    const ExploreScreen(),
                    const ProgressViewPagerScreen(),
                    //const ProfileScreen()
                     ProfileUiProvider.getScreen(vm.user),
                  ],
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return FadeThroughTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        fillColor: AppColorScheme.colorBlack,
                        child: child);
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                  ignoring: vm.isTabsLocked,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: const Radius.circular(8)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: BottomNavigationBar(
                        backgroundColor:
                            AppColorScheme.colorBlack2.withOpacity(0.86),
                        type: BottomNavigationBarType.fixed,
                        unselectedItemColor: AppColorScheme.colorBlack7,
                        selectedFontSize: 12.0,
                        unselectedFontSize: 12.0,
                        selectedItemColor:
                            AppColorScheme.colorPrimaryWhite.withOpacity(0.95),
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              backgroundColor: AppColorScheme.colorBlack,
                              icon: const Icon(
                                  BottomNavBarIcon.ic_programs_filled),
                              label: S.of(context).bottom_menu__programs),
                          BottomNavigationBarItem(
                              backgroundColor: AppColorScheme.colorBlack,
                              icon: const Icon(
                                  BottomNavBarIcon.ic_workouts_filled),
                              label: S.of(context).bottom_menu__explore),
                          BottomNavigationBarItem(
                              backgroundColor: AppColorScheme.colorBlack,
                              icon: const Icon(
                                  BottomNavBarIcon.ic_progress_filled),
                              label: S.of(context).bottom_menu__progress),
                          BottomNavigationBarItem(
                              backgroundColor: AppColorScheme.colorBlack,
                              icon: const Icon(
                                  BottomNavBarIcon.ic_profile_filled),
                              label: S.of(context).bottom_menu__profile)
                        ],
                        currentIndex: vm.selectedTab.index,
                        onTap: (index) => vm.updateSelectedTab(index),
                      ),
                    ),
                  ),
                ),
              ),
              vm.isLoading
                  ? Positioned.fill(
                      child: Container(
                        color:
                            AppColorScheme.colorPrimaryBlack.withOpacity(0.62),
                        child: CircularLoadingIndicator(),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      );

  Future<bool> _onBackPressed(_ViewModel vm) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return Future.sync(() => false);
    } else {
      return Future.sync(() => true);
    }
  }
}

class _ViewModel {
  BottomTab selectedTab;
  Function(int) updateSelectedTab;
  Function() hideError;
  bool isTabsLocked;
  bool isLoading;
  String error;
  User user;

  _ViewModel(
      {@required this.selectedTab,
      @required this.isTabsLocked,
      @required this.isLoading,
      @required this.error,
      @required this.hideError,
      @required this.user,
      @required this.updateSelectedTab});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        selectedTab: store.state.mainPageState.selectedTab,
        isLoading: store.state.mainPageState.showLoadingIndicator,
        user: store.state.loginState.user,
        error: store.state.mainPageState.error,
        hideError: () => store.dispatch(OnWorkoutSummaryLoadError("")),
        isTabsLocked: store.state.mainPageState.workouts == null ||
            store.state.mainPageState.workouts.isEmpty,
        updateSelectedTab: (index) =>
            store.dispatch(UpdateSelectedTab(tab: BottomTab.values[index])));
  }
}

enum BottomTab { Program, Explore, Progress, Profile }
