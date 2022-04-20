import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class RatePicker extends StatefulWidget {
  final double width;
  final double initialRate;
  final Function(double) onRateSelected;

  RatePicker(
      {@required this.width,
      @required this.initialRate,
      @required this.onRateSelected});

  @override
  _RatePickerState createState() => _RatePickerState();
}

const gradientColors = [
  AppColorScheme.colorRed,
  AppColorScheme.colorOrange,
  AppColorScheme.colorYellow,
  AppColorScheme.colorGreen
];
const List<double> gradientStops = [0.0, 0.25, 0.65, 0.85];

class _RatePickerState extends State<RatePicker> {
  static const double PICKER_SIZE = 70;
  Color currentColor;

  double draggedSelectorSize = PICKER_SIZE - PICKER_SIZE / 4;
  double normalSelectorSize = PICKER_SIZE - PICKER_SIZE / 3;
  double rangeSelectorHeight =
      PICKER_SIZE - PICKER_SIZE / 2 + _LinesClipper.line_edge_radius * 2;

  double pickerPositionX = 0;
  bool isDragging = false;

  @override
  void didChangeDependencies() {
    if (widget.initialRate != 0) {
      pickerPositionX = widget.initialRate * widget.width +
          (MediaQuery.of(context).size.width - widget.width) / 2;
    }
    super.didChangeDependencies();
  }

  void _onPanUpdate(BuildContext context, double globalPositionX) {
    setState(() {
      pickerPositionX = globalPositionX - normalSelectorSize / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PICKER_SIZE,
      child: Container(
        width: double.infinity,
        child: Center(
          child:
              Stack(fit: StackFit.loose, overflow: Overflow.visible, children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.none,
                child: GestureDetector(
                  onPanDown: (details) =>
                      _onPanUpdate(context, details.globalPosition.dx),
                  child: ClipPath(
                    clipper: _LinesClipper(),
                    child: Container(
                      width: widget.width,
                      height: rangeSelectorHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: gradientColors,
                            stops: gradientStops),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: _getSelectorPosition(context),
                child: GestureDetector(
                  onPanDown: (details) {
                    setState(() {
                      isDragging = true;
                      _onPanUpdate(context, details.globalPosition.dx);
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      isDragging = false;
                    });
                  },
                  onPanUpdate: (details) {
                    _onPanUpdate(context, details.globalPosition.dx);
                    double rate = _getRateValue();
                    if (rate < 0) {
                      rate = 0;
                    }
                    widget.onRateSelected(rate);
                  },
                  onPanStart: (details) =>
                      _onPanUpdate(context, details.globalPosition.dx),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    width:
                        isDragging ? draggedSelectorSize : normalSelectorSize,
                    height:
                        isDragging ? draggedSelectorSize : normalSelectorSize,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColorScheme.colorPrimaryWhite, width: 4),
                      shape: BoxShape.circle,
                      color: _getCurrentColor(
                          gradientColors, gradientStops, _getRateValue()
                          //  (pickerPositionX) / widget.width),
                          ),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }

  double _getRateValue() {
    return (pickerPositionX -
            (MediaQuery.of(context).size.width - widget.width) / 2) /
        widget.width;
  }

  double _getSelectorPosition(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final x0 = (screenWidth - widget.width) / 2;
    final x1 = (screenWidth + widget.width) / 2;
    final leftBorder = x0 - PICKER_SIZE / 2;
    final rightBorder = x1 - PICKER_SIZE / 2;

    if (pickerPositionX < leftBorder + normalSelectorSize / 2) {
      return leftBorder + normalSelectorSize / 2;
    }
    if (pickerPositionX > rightBorder) {
      return rightBorder;
    }
    return pickerPositionX;
  }

  /// from Flutter:
  /// Calculate the color at position [t] of the gradient defined by [colors] and [stops].
  Color _getCurrentColor(List<Color> colors, List<double> stops, double t) {
    if (t <= stops.first) return colors.first;
    if (t >= stops.last) return colors.last;
    final int index = stops.lastIndexWhere((double s) => s <= t);
    currentColor = Color.lerp(
      colors[index],
      colors[index + 1],
      (t - stops[index]) / (stops[index + 1] - stops[index]),
    );

    return currentColor;
  }
}

class _LinesClipper extends CustomClipper<Path> {
  static const _lineWidth = 4.0;
  static const _lineSpace = 2.0;
  static const line_edge_radius = _lineWidth / 2;
  double redundantStartPadding = 0.0;

  @override
  Path getClip(Size size) {
    Path path = Path();

    final lineCount = size.width / (_lineWidth + _lineSpace);

    final actualCount = lineCount.toInt();

    if (actualCount < lineCount) {
      redundantStartPadding = lineCount - actualCount;
    }

    for (int i = 0; i < actualCount; i++) {
      _drawLine(i, path, size.height, redundantStartPadding);
    }

    return path;
  }

  _drawLine(
      int lineNumber, Path path, double height, double redundantStartPadding) {
    double beginX;

    if (redundantStartPadding > 0) {
      beginX = (_lineWidth + _lineSpace) * lineNumber +
          redundantStartPadding * (_lineWidth / 2 + _lineSpace * 2);
    } else {
      beginX = (_lineWidth + _lineSpace) * lineNumber;
    }

    double endX = beginX + _lineWidth;

    path.moveTo(beginX, 0);
    path.lineTo(beginX, height - line_edge_radius);

    path.arcToPoint(Offset(endX, height - line_edge_radius),
        radius: Radius.circular(line_edge_radius * 2), clockwise: false);
    path.lineTo(endX, line_edge_radius);

    path.arcToPoint(Offset(beginX, line_edge_radius),
        radius: Radius.circular(line_edge_radius * 2), clockwise: false);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
