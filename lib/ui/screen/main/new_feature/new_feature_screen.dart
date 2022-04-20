import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_config.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class NewFeatureScreen extends StatefulWidget {
  @override
  _NewFeatureScreenState createState() => _NewFeatureScreenState();
}

class _NewFeatureScreenState extends State<NewFeatureScreen> {
  static ColorTween _itemBorderColorTween =
      ColorTween(begin: AppColorScheme.colorBlack5, end: AppColorScheme.colorYellow);
  List<Widget> _pages;
  PageController _pageController;
  double _currentPage = 0.0;
  Set<int> _selectedItems = {0};

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(OnNewFeatureShownAction(deepHash(store.state.config.newFeatures)));
          _pages = store.state.config.newFeatures.map((e) => FeaturePage(feature: e)).toList();
          _currentPage = 0;
          _pageController = PageController();
        },
        converter: _ViewModel.fromStore,
        onDispose: (store) {
          _pageController.dispose();
        },
        builder: (context, vm) => _buildContent(vm));
  }

  _buildContent(_ViewModel vm) => NotificationListener<ScrollNotification>(
        onNotification: (n) => _onScroll(n),
        child: Scaffold(
          backgroundColor: AppColorScheme.colorPrimaryBlack,
          appBar: CupertinoNavigationBar(
            backgroundColor: AppColorScheme.colorPrimaryBlack,
            padding: EdgeInsetsDirectional.zero,
            middle: Text(S.of(context).new_feature_screen_title,
                style: textBold16.copyWith(color: AppColorScheme.colorPrimaryWhite)),
            trailing: CupertinoButton(
                child: Text(S.of(context).all__skip, style: textBold16.copyWith(color: AppColorScheme.colorYellow)),
                padding: EdgeInsets.only(right: 32),
                onPressed: () {
                  vm.navigateToMainPage();
                }),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: _pages,
                ),
              ),
              SafeArea(
                  child: SizedBox(
                height: 56,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: AbsorbPointer(
                          child: AnimatedItemPicker(
                            key: ValueKey(_currentPage),
                            axis: Axis.horizontal,
                            itemCount: _pages.length,
                            initialSelection: _selectedItems,
                            onItemPicked: (index, selected) {},
                            itemBuilder: (index, animValue) => Container(
                              height: 7,
                              width: 7,
                              margin: EdgeInsets.all(7),
                              decoration: new BoxDecoration(
                                  color: _itemBorderColorTween.transform(animValue), shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 32,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => _next(vm),
                            child: Row(
                              children: [
                                Text(S.of(context).all__next,
                                    style: textRegular14.copyWith(color: AppColorScheme.colorYellow)),
                                Icon(Icons.arrow_forward_ios, color: AppColorScheme.colorYellow, size: 20)
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ))
            ],
          ),
        ),
      );

  void _next(_ViewModel vm) {
    if (_currentPage.ceil() == _pages.length - 1) {
      vm.navigateToMainPage();
    } else {
      _animateScroll(min(_currentPage.round() + 1, _pages.length - 1));
    }
  }

  Future<void> _animateScroll(int page) async {
    await _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics) {
      setState(() {
        _currentPage = metrics.page;
      });
    }

    if (notification is ScrollEndNotification) {
      setState(() {
        _selectedItems.clear();
        _selectedItems.add(_currentPage.ceil());
      });
    }

    return false;
  }
}

class _ViewModel {
  Function navigateToMainPage;

  _ViewModel({@required this.navigateToMainPage});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(navigateToMainPage: () => store.dispatch(NavigateToMainScreenAction()));
  }
}

class FeaturePage extends StatelessWidget {
  final NewFeature feature;

  const FeaturePage({@required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TfImage(url: feature.image, background: Colors.transparent, width: MediaQuery.of(context).size.width - 32),
          SizedBox(height: 32),
          Text(feature.title,
              style: textRegular20.copyWith(color: AppColorScheme.colorPrimaryWhite), textAlign: TextAlign.justify),
          SizedBox(height: 16),
          Text(feature.description,
              style: textRegular16.copyWith(color: AppColorScheme.colorBlack8), textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
