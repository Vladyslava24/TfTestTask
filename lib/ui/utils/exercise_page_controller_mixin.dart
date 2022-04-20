import 'package:flutter/material.dart';

mixin ExercisePageControllerMixin<T extends StatefulWidget> on State<T> {
  PageController _pageController;
  bool isAnimating = false;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  int currentPage() {
    return _pageController.page.toInt();
  }

  animateToNextPageFrom(int currentPage) {
    isAnimating = true;
    _pageController
        .animateToPage(currentPage + 1, duration: Duration(milliseconds: 400), curve: Curves.easeInOut)
        .whenComplete(() => isAnimating = false);
  }

  animateToPreviousPageFrom(int currentPage) {
    isAnimating = true;
    _pageController
        .animateToPage(currentPage - 1, duration: Duration(milliseconds: 400), curve: Curves.easeInOut)
        .whenComplete(() => isAnimating = false);
  }

  PageController getPageController() => _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
