import 'package:flutter/material.dart';

import 'item_widget.dart';

class HorizontalScrollableSelector extends StatefulWidget {
  final Function(int selectedPosition)? onPullUpComplete;
  final Function(int selectedPosition)? onItemTaped;
  final VoidCallback? onScrollStarted;
  final double? height;
  final int itemCount;
  final int initialPosition;
  final double itemWidth;
  final ItemWidgetBuilder itemBuilder;

  HorizontalScrollableSelector(
      {required this.height,
      required this.itemCount,
      required this.itemBuilder,
      required this.initialPosition,
      required this.itemWidth,
      this.onScrollStarted,
      this.onPullUpComplete,
      this.onItemTaped});

  @override
  _HorizontalScrollableSelectorState createState() =>
      _HorizontalScrollableSelectorState();
}

class _HorizontalScrollableSelectorState
    extends State<HorizontalScrollableSelector> {
  bool isListScrolling = false;
  var upScrolling = false;
  var scrolledPixels = 0.0;
  var selectedPosition = 0;
  late ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: _buildListView(widget.itemBuilder, context),
    );
  }

  @override
  void initState() {
    selectedPosition = widget.initialPosition;
    controller = new ScrollController(
        initialScrollOffset: widget.itemWidth * widget.initialPosition)
      ..addListener(() {
        if ((scrolledPixels - controller.position.pixels).abs() > 15 &&
            !isListScrolling) {
          widget.onScrollStarted?.call();

          isListScrolling = true;
        }
        setState(() {});
      });

    super.initState();
  }

  Widget _buildListView(ItemWidgetBuilder itemBuilder, BuildContext context) {
    return NotificationListener(
      onNotification: (Notification notification) {
        if (notification is ScrollEndNotification) {
          if (upScrolling) {
            return false;
          }
          if (!isListScrolling) {
            return false;
          }
          _upScroll(widget.itemWidth);
        }
        return false;
      },
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: controller,
          itemCount: widget.itemCount + 4,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0 ||
                index == 1 ||
                index == widget.itemCount + 3 ||
                index == widget.itemCount + 2) {
              return Container(width: widget.itemWidth);
            }

            var calculatedIndex =
                _calculateCallbackIndexAccordingToSpaces(index);
            return ItemWidget(
              width: widget.itemWidth,
              child: itemBuilder(context, calculatedIndex,
                  calculatedIndex == selectedPosition),
              scale: _calculateScale(
                  index, widget.itemWidth, MediaQuery.of(context).size.width),
              onTap: () {
                _updateSelectedPosition();
                controller
                    .animateTo(
                        controller.position.pixels +
                            ((index - 2) - selectedPosition) * widget.itemWidth,
                        curve: Curves.easeOut,
                        duration: Duration(milliseconds: 250))
                    .then((_) {
                  widget.onItemTaped?.call(selectedPosition);
                });
              },
            );
          }),
    );
  }

  int _calculateCallbackIndexAccordingToSpaces(int index) {
    if (index == 0 || index == 1) {
      return 0;
    }
    if (index - 2 >= widget.itemCount) {
      return widget.itemCount - 1;
    }
    return index - 2;
  }

  double _calculateScale(int index, double itemWidth, double screenWidth) {
    double scale = 1;

    var itemWidthWithPadding = screenWidth / 5;

    int targetIndex = index - 2;
    int lowerBound = targetIndex - 1;
    int upperBound = targetIndex + 1;

    double lastPositionVisiblePart =
        controller.position.pixels / itemWidthWithPadding;
    int lastVisiblePosition = lastPositionVisiblePart.toInt();

    if (lastVisiblePosition >= lowerBound &&
        lastVisiblePosition <= upperBound &&
        index == targetIndex + 2) {
      scale = 2 - (targetIndex - lastPositionVisiblePart).abs();

      if (scale < 1) {
        return 1;
      }
      if (scale > 2) {
        return 2;
      }
      return scale;
    }
    return scale;
  }

  void _upScroll(double itemWidth) {
    Future.microtask(() {
      upScrolling = true;

      ListCurrentScreenPosition listPosition = _updateSelectedPosition();

      controller
          .animateTo(
              listPosition.lastItemVisiblePart > 0.5
                  ? controller.position.pixels +
                      itemWidth * (1 - listPosition.lastItemVisiblePart)
                  : controller.position.pixels -
                      itemWidth * listPosition.lastItemVisiblePart,
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 250))
          .then((_) {
        upScrolling = false;
        isListScrolling = false;
        scrolledPixels = controller.position.pixels;
        widget.onPullUpComplete?.call(selectedPosition);
      }).catchError((_) {
        scrolledPixels = controller.position.pixels;
        upScrolling = false;
        isListScrolling = false;
      });
    });
  }

  ListCurrentScreenPosition _updateSelectedPosition() {
    var screenWidth = MediaQuery.of(context).size.width;
    var itemWidthWithPadding = screenWidth / 5;

    double lastPositionVisiblePart =
        controller.position.pixels / itemWidthWithPadding;
    int lastVisiblePosition = lastPositionVisiblePart.toInt();

    double visiblePart = lastPositionVisiblePart - lastVisiblePosition;
    selectedPosition =
        visiblePart > 0.5 ? lastVisiblePosition + 1 : lastVisiblePosition;

    return ListCurrentScreenPosition(
        selectedPosition: selectedPosition, lastItemVisiblePart: visiblePart);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ListCurrentScreenPosition {
  final int selectedPosition;
  double lastItemVisiblePart;

  ListCurrentScreenPosition(
      {required this.selectedPosition, required this.lastItemVisiblePart});
}

typedef ItemWidgetBuilder = Widget Function(
    BuildContext context, int index, bool isSelected);
