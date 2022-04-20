import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ExerciseProgressIndicator extends StatefulWidget {
  final int segmentCount;
  final int selectedSegment;
  final IndicatorType type;
  final List<int> rests;

  const ExerciseProgressIndicator({
    required this.segmentCount,
    required this.selectedSegment,
    required this.type,
    this.rests = const [],
    Key? key
  }) : super(key: key);

  @override
  _ExerciseProgressIndicatorState createState() =>
      _ExerciseProgressIndicatorState();
}

class _ExerciseProgressIndicatorState extends State<ExerciseProgressIndicator> {
  static const _height = 8.0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyRed,
      alignment: Alignment.topCenter,
      child: _size == null ?
        Container(height: _height) :
        widget.type == IndicatorType.circular ?
          _buildCircularSegments(widget.segmentCount) :
          _buildLinearSegments(widget.segmentCount, widget.rests)
    );
  }

  final GlobalKey _keyRed = GlobalKey();
  Size? _size;

  _getSizes() {
    final RenderBox? renderBoxRed =
        _keyRed.currentContext!.findRenderObject() as RenderBox?;
    setState(() {
      _size = renderBoxRed?.size;
    });
  }

  Widget _buildLinearSegments(int segmentCount, List<int> rests) {
    const rightPadding = 12.0;
    const restWidth = 2.0;
    const parentPadding = 32.0;

    final segmentWithoutRest = segmentCount - rests.length;
    final restCount = rests.length;

    final width = double.parse(((
      _size!.width -
      parentPadding -
      (restCount * restWidth) -
      (segmentCount * rightPadding)) / segmentWithoutRest).toStringAsFixed(2));

    final children = <Widget>[];

    for (int i = 0; i < segmentCount; i++) {
      final segment = ProgressSegment(
        key: ValueKey("ProgressSegment $i"),
        isSelected: widget.selectedSegment >= i,
        width: width,
      );

      rests.contains(i) ?
        children.add(ClipRRect(
          borderRadius: BorderRadius.circular(0.5),
          child: Container(
            color: AppColorScheme.colorPrimaryWhite,
            width: restWidth,
            height: 10,
          ),
        )) :
        children.add(segment);

      if (i < segmentCount - 1) {
        const rightInset = SizedBox(height: _height, width: rightPadding);
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
        width: _size!.width,
        height: _size!.width,
        interval: Interval(i * intervalLength, (i + 1) * intervalLength),
      );

      children.add(segment);
    }
    return Stack(
      children: children
    );
  }
}

class ProgressSegment extends StatefulWidget {
  final double width;
  final bool isSelected;

  const ProgressSegment(
      {required this.width, required this.isSelected, Key? key})
      : super(key: key);

  @override
  _ProgressSegmentState createState() => _ProgressSegmentState();
}

class _ProgressSegmentState extends State<ProgressSegment>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  bool _isSelected = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    _colorTween = ColorTween(
            begin: AppColorScheme.colorBlack8.withOpacity(0.5),
            end: AppColorScheme.colorYellow.withOpacity(0.8))
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
    return SizedBox(
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

  const CircularProgressSegment(
      {required this.isSelected,
      required this.startAngle,
      required this.sweepAngle,
      required this.width,
      required this.height,
      required this.interval,
      Key? key})
      : super(key: key);

  @override
  _CircularProgressSegmentState createState() =>
      _CircularProgressSegmentState();
}

class _CircularProgressSegmentState extends State<CircularProgressSegment>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  bool _isSelected = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    _colorTween = ColorTween(
            begin: AppColorScheme.colorBlack8.withOpacity(0.5),
            end: AppColorScheme.colorYellow.withOpacity(0.8))
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
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        foregroundPainter: CircularProgressPainter(
          color: _colorTween.value,
          startAngle: widget.startAngle,
          sweepAngle: widget.sweepAngle,
          completePercent: widget.isSelected ? 1.0 : 0.0,
          strokeWidth: 4.0,
          radius: widget.width / 10
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

class CircularProgressPainter extends CustomPainter {
  final Color color;
  final double completePercent;
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;
  final double radius;

  CircularProgressPainter(
      {required this.color,
      required this.completePercent,
      required this.strokeWidth,
      required this.startAngle,
      required this.sweepAngle,
      required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + (11 * pi / 180) / 2,
        sweepAngle - (11 * pi / 180),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LinearProgressPainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;

  LinearProgressPainter({
    required this.lineColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum IndicatorType { linear, circular }
