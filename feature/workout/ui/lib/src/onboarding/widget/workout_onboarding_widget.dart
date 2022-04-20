import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/onboarding/widget/dot_widget.dart';
import 'package:workout_ui/src/onboarding/widget/fake_progress_indicator_widget.dart';
import 'package:workout_ui/src/onboarding/widget/skip_button_widget.dart';

class WorkoutOnBoardingWidget extends StatefulWidget {
  final List<Widget> onBoardingItems;
  final int activeIndex;
  final String skipButtonText;
  final VoidCallback startWorkout;
  final Function(int) onActiveIndexChanged;

  const WorkoutOnBoardingWidget({
    required this.activeIndex,
    required this.startWorkout,
    required this.onActiveIndexChanged,
    this.onBoardingItems = const [],
    this.skipButtonText = '',
    Key? key
  }) : super(key: key);

  @override
  _WorkoutOnBoardingWidgetState createState() =>
    _WorkoutOnBoardingWidgetState();
}

class _WorkoutOnBoardingWidgetState extends State<WorkoutOnBoardingWidget> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlack.withOpacity(.6),
      body: Stack(
        children: [
          const Positioned.fill(
            child: TfImage(
              url: workoutOnBoardingBg,
            ),
          ),
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: widget.onBoardingItems.map((e) =>
                GestureDetector(
                  onTap: () {
                    if (widget.activeIndex < widget.onBoardingItems.length - 1) {
                      final increasedActiveIndex = widget.activeIndex + 1;
                      _pageController.jumpToPage(increasedActiveIndex);
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        widget.onActiveIndexChanged(increasedActiveIndex);
                      });
                    }
                  },
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0 && widget.activeIndex > 0) {
                      final decreasedActiveIndex = widget.activeIndex - 1;
                      _pageController.jumpToPage(decreasedActiveIndex);
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        widget.onActiveIndexChanged(decreasedActiveIndex);
                      });
                    } else if (details.delta.dx < 0 &&
                        widget.activeIndex < widget.onBoardingItems.length - 1
                    ) {
                      final increasedActiveIndex = widget.activeIndex + 1;
                      _pageController.jumpToPage(increasedActiveIndex);
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        widget.onActiveIndexChanged(increasedActiveIndex);
                      });
                    }
                  },
                  child: e,
                )
              ).toList(),
            ),
          ),
          const Positioned(
            top: 20.0,
            left: 0.0,
            right: 0.0,
            child: FakeProgressIndicatorWidget()
          ),
          Positioned(
            bottom: 70.0,
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.onBoardingItems.asMap().entries.map((e) =>
                    DotWidget(
                      color: e.key == widget.activeIndex ?
                        AppColorScheme.colorYellow :
                        AppColorScheme.colorPrimaryWhite
                    )
                  ).toList(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 16.0,
            child: SkipButtonWidget(
              startWorkout: widget.startWorkout,
              skipButtonText: widget.skipButtonText,
            )
          ),
        ],
      ),
    );
  }
}
