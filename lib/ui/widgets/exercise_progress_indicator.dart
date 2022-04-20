import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ExerciseProgressIndicator extends StatefulWidget {
  final int segmentCount;
  final int selectedSegment;
  final int rounds;
  final IndicatorType type;

  const ExerciseProgressIndicator(
      {@required this.segmentCount, @required this.selectedSegment, @required this.type, this.rounds = 1});

  @override
  _ExerciseProgressIndicatorState createState() => _ExerciseProgressIndicatorState();
}

class _ExerciseProgressIndicatorState extends State<ExerciseProgressIndicator> {
  static const _HEIGHT = 8.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyRed,
      child: _size == null
          ? Container(height: _HEIGHT)
          : widget.type == IndicatorType.CIRCULAR
              ? _buildCircularSegments(widget.segmentCount)
              : _buildLinearSegments(widget.segmentCount),
    );
  }

  GlobalKey _keyRed = GlobalKey();
  Size _size;

  _getSizes() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    setState(() {
      _size = renderBoxRed.size;
    });
  }

  Widget _buildLinearSegments(int segmentCount) {
    final rightPadding = 12.0;
    final parentLeftPadding = 16.0;
    final parentRightPadding = 16.0;
    final width =
        (_size.width - (parentLeftPadding + parentRightPadding - rightPadding) - (widget.rounds - 1) * rightPadding) /
                segmentCount -
            rightPadding;

    final children = <Widget>[];

    for (int i = 0; i < segmentCount; i++) {
      final segment = ProgressSegment(
        key: ValueKey("ProgressSegment $i"),
        isSelected: widget.selectedSegment >= i,
        width: width,
      );
      children.add(segment);

      if ((i + 1) % (segmentCount / widget.rounds) == 0 && (i + 1) != segmentCount) {
        final rightInset = Container(height: _HEIGHT, width: rightPadding);
        children.add(rightInset);
        children.add(ClipRRect(
          borderRadius: BorderRadius.circular(0.5),
          child: Container(
            color: AppColorScheme.colorPrimaryWhite,
            width: 2,
            height: 10,
          ),
        ));
      }

      if (i < segmentCount - 1) {
        final rightInset = Container(height: _HEIGHT, width: rightPadding);
        children.add(rightInset);
      }
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  Widget _buildCircularSegments(int segmentCount) {
    final intervalLength = 1 / segmentCount;
    final children = <Widget>[];

    double arcLength = 2 * pi / segmentCount;

    for (int i = 0; i < segmentCount; i++) {
      final segment = CircularProgressSegment(
          key: ValueKey("ProgressSegment $i"),
          isSelected: widget.selectedSegment >= i,
          startAngle: (pi + pi / 2) + i * arcLength,
          sweepAngle: arcLength,
          width: _size.width,
          height: _size.width,
          interval: Interval(i * intervalLength, (i + 1) * intervalLength));

      children.add(segment);
    }
    return Stack(children: children);
  }
}

class ProgressSegment extends StatefulWidget {
  final double width;
  final bool isSelected;

  ProgressSegment({this.width, this.isSelected, @required Key key}) : super(key: key);

  @override
  _ProgressSegmentState createState() => _ProgressSegmentState();
}

class _ProgressSegmentState extends State<ProgressSegment> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;

  bool _isSelected = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    _colorTween =
        ColorTween(begin: AppColorScheme.colorBlack8.withOpacity(0.5), end: AppColorScheme.colorYellow.withOpacity(0.8))
            .animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSelected != widget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward(from: 0.0);
      } else {
        _animationController.reverse(from: 1.0);
      }
      _isSelected = widget.isSelected;
    }
    return Container(
      width: widget.width,
      child: CustomPaint(
        foregroundPainter: LinearProgressPainter(
          lineColor: _colorTween.value,
          strokeWidth: 4.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CircularProgressSegment extends StatefulWidget {
  final bool isSelected;
  final double width;
  final double height;
  final Interval interval;
  final double startAngle;
  final double sweepAngle;
  final Offset center;

  CircularProgressSegment(
      {this.isSelected,
      this.startAngle,
      this.sweepAngle,
      this.width,
      this.height,
      this.interval,
      this.center,
      @required Key key})
      : super(key: key);

  @override
  _CircularProgressSegmentState createState() => _CircularProgressSegmentState();
}

class _CircularProgressSegmentState extends State<CircularProgressSegment> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;

  bool _isSelected = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    _colorTween =
        ColorTween(begin: AppColorScheme.colorBlack8.withOpacity(0.5), end: AppColorScheme.colorYellow.withOpacity(0.8))
            .animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSelected != widget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward(from: 0.0);
      } else {
        _animationController.reverse(from: 1.0);
      }
      _isSelected = widget.isSelected;
    }
    return Container(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
          foregroundPainter: CircularProgressPainter(
              color: _colorTween.value,
              startAngle: widget.startAngle,
              sweepAngle: widget.sweepAngle,
              completePercent: widget.isSelected ? 1.0 : 0.0,
              strokeWidth: 4.0,
              radius: widget.width / 2)),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CircularProgressPainter extends CustomPainter {
  final Color color;
  final double completePercent;
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;
  final double radius;

  CircularProgressPainter(
      {this.color, this.completePercent, this.strokeWidth, this.startAngle, this.sweepAngle, this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Offset center = new Offset(size.width / 2, size.height / 2);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), startAngle + (11 * pi / 180) / 2,
        sweepAngle - (11 * pi / 180), false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LinearProgressPainter extends CustomPainter {
  Color lineColor;
  double strokeWidth;

  LinearProgressPainter({this.lineColor, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum IndicatorType { LINEAR, CIRCULAR }
