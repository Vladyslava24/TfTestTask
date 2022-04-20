import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:totalfit/ui/screen/paywall_screen.dart';
import 'package:totalfit/ui/utils/helpers.dart';
import 'package:ui_kit/ui_kit.dart';

import 'progress_page.dart';

class ProgressViewPagerScreen extends StatefulWidget {
  const ProgressViewPagerScreen();

  @override
  _ProgressViewPagerScreenState createState() => _ProgressViewPagerScreenState();
}

class _ProgressViewPagerScreenState extends State<ProgressViewPagerScreen> with AutomaticKeepAliveClientMixin {
  PageController _pageController;
  bool _isScrolling = false;
  bool _isPageLoading = false;
  bool _isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          int initial = store.state.mainPageState.progressPageIndex;
          store.dispatch(InitProgressAction());
          _pageController = PageController(initialPage: initial);
        },
        onWillChange: (oldVm, newVm) {
          if (oldVm.selectedTab != BottomTab.Progress &&
              newVm.selectedTab == BottomTab.Progress &&
              oldVm.progressPageIndex != newVm.progressPageIndex) {
            _pageController.jumpToPage(newVm.progressPageIndex);
          }

          if (oldVm.pages[oldVm.progressPageIndex].isLoading() &&
              !newVm.pages[oldVm.progressPageIndex].isLoading() &&
              !newVm.pages[oldVm.progressPageIndex].isInErrorState() &&
              !newVm.isPremiumUser &&
              _isFirstLoad &&
              !newVm.showHexagonOnBoarding) {
            if (newVm.launchCount % 2 == 0) {
              Future.delayed(Duration(milliseconds: 2500), () {
                if (mounted) {
                  PaywallScreen.show(context);
                }
              });
            }

            _isFirstLoad = false;
          }
        },
        onDispose: (store) {
          _pageController.dispose();
        },
        builder: (context, vm) => Container(color: AppColorScheme.colorBlack, child: _buildPageView(vm)));
  }

  _scrollToNext(_ViewModel vm) {
    if (vm.progressPageIndex < 99 && !_isScrolling && !_isPageLoading) {
      _isScrolling = true;
      vm.incrementProgressPageIndex();
      _pageController
          .nextPage(duration: Duration(milliseconds: PAGE_SCROLL_DURATION), curve: Curves.easeIn)
          .whenComplete(() => _isScrolling = false);
    }
  }

  _scrollToPrevious(_ViewModel vm) {
    if (vm.progressPageIndex > 0 && !_isScrolling && !_isPageLoading) {
      _isScrolling = true;
      vm.decrementProgressPageIndex();
      _pageController
          .previousPage(duration: Duration(milliseconds: PAGE_SCROLL_DURATION), curve: Curves.easeIn)
          .whenComplete(() => _isScrolling = false);
    }
  }

  Widget _buildPageView(_ViewModel vm) {
    final children = <Widget>[];
    for (int i = 0; i < vm.pages.length; i++) {
      children.add(
        ProgressPage(
          index: i,
          nextPage: () => _scrollToNext(vm),
          previousPage: () => _scrollToPrevious(vm),
          loadingCallback: (loading) {
            _isPageLoading = loading;
          },
        ),
      );
    }

    return ScrollConfiguration(
      behavior: NoScrollGlowBehavior(),
      child: PageView.builder(
          itemBuilder: (context, index) => children[index],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            Future.delayed(Duration(milliseconds: PAGE_SCROLL_DURATION), () {
              if (mounted) {
                if (index == vm.progressPageIndex && vm.pages[vm.progressPageIndex].isLoading()) {
                  final previousProgressDate =
                      todayDate.subtract(Duration(days: PROGRESS_STUB_PAGES_COUNT - vm.progressPageIndex - 1));
                  vm.fetchProgress(previousProgressDate, vm.progressPageIndex);
                }
              }
            });
          },
          controller: _pageController),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ViewModel {
  final List<ProgressPageModel> pages;
  Function(DateTime, int) fetchProgress;
  Function incrementProgressPageIndex;
  Function decrementProgressPageIndex;
  BottomTab selectedTab;
  int progressPageIndex;
  int launchCount;
  bool isPremiumUser;
  bool showHexagonOnBoarding;

  _ViewModel({
    @required this.pages,
    @required this.fetchProgress,
    @required this.selectedTab,
    @required this.progressPageIndex,
    @required this.incrementProgressPageIndex,
    @required this.decrementProgressPageIndex,
    @required this.launchCount,
    @required this.isPremiumUser,
    @required this.showHexagonOnBoarding,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      pages: store.state.mainPageState.progressPages,
      showHexagonOnBoarding: store.state.preferenceState.showHexagonOnBoarding,
      selectedTab: store.state.mainPageState.selectedTab,
      progressPageIndex: store.state.mainPageState.progressPageIndex,
      launchCount: store.state.preferenceState.launchCount,
      isPremiumUser: store.state.isPremiumUser(),
      incrementProgressPageIndex: () {
        final nextProgressDate = todayDate
            .subtract(Duration(days: PROGRESS_STUB_PAGES_COUNT - store.state.mainPageState.progressPageIndex + 1));
        store.dispatch(IncrementProgressPageIndex(nextProgressDate));
      },
      decrementProgressPageIndex: () {
        final previousProgressDate = todayDate
            .subtract(Duration(days: PROGRESS_STUB_PAGES_COUNT - store.state.mainPageState.progressPageIndex - 1));
        store.dispatch(DecrementProgressPageIndex(previousProgressDate));
      },
      fetchProgress: (date, index) => store.dispatch(FetchProgressAction(date, index)),
    );
  }
}

const int PAGE_SCROLL_DURATION = 275;
const int PROGRESS_STUB_PAGES_COUNT = 100;
