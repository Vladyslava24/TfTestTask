import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class SummaryProgressIndicator extends StatefulWidget {
  final List<ProgressItem> progressItems;
  final bool addTitle;

  SummaryProgressIndicator({@required Key key, @required this.progressItems, this.addTitle = true}) : super(key: key);

  @override
  _SummaryProgressIndicatorState createState() => _SummaryProgressIndicatorState();
}

class _SummaryProgressIndicatorState extends State<SummaryProgressIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<SummaryProgressIndicator> {
  AnimationController _animationController;
  final CancelableCompleter<dynamic> _completer = CancelableCompleter();

  @override
  void initState() {
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });
    _completer.complete(Future.delayed(Duration(milliseconds: 200), () => _animationController.forward()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final children = <Widget>[];
    if (widget.addTitle) {
      children.add(
        Text(
          S.of(context).your_progress,
          textAlign: TextAlign.left,
          style: title16.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ),
      );
    }
    widget.progressItems.forEach((item) {
      children.addAll(_buildProgressRow(item));
    });

    return Padding(
      padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  List<Widget> _buildProgressRow(ProgressItem item) {
    final row = <Widget>[];
    row.add(Container(height: 12));
    row.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item.name,
          textAlign: TextAlign.left,
          style: textRegular16.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ),
        Text(
          "${(item.value * 100).round()} %",
          textAlign: TextAlign.left,
          style: textRegular16.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ),
      ],
    ));
    row.add(Container(height: 8));
    row.add(Container(
      padding: EdgeInsets.only(top: 8, bottom: 8.0, left: 4, right: 4),
      child: CustomLinearProgressIndicator(item.initial,
          color: item.color, value: item.value > 1.0 ? 1.0 : item.value, animationController: _animationController),
      width: double.infinity,
    ));
    return row;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _completer.operation.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomLinearProgressIndicator extends StatefulWidget {
  final Color color;
  final Color idleColor;
  final double value;
  final double initial;
  final AnimationController animationController;

  CustomLinearProgressIndicator(this.initial,
      {@required this.color,
      this.idleColor = AppColorScheme.colorBlack4,
      @required this.value,
      @required this.animationController});

  @override
  _CustomLinearProgressIndicatorState createState() => _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState extends State<CustomLinearProgressIndicator> {
  Animation _animation;

  @override
  void initState() {
    _animation = CurvedAnimation(parent: widget.animationController, curve: Curves.easeOut);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: LinearProgressPainter(
            initialValue: widget.initial,
            idleColor: widget.idleColor,
            color: widget.color,
            value: (widget.value - widget.initial) * _animation.value));
  }
}

class LinearProgressPainter extends CustomPainter {
  final Color color;
  final Color idleColor;
  final double value;
  final double initialValue;

  LinearProgressPainter({
    @required this.color,
    @required this.idleColor,
    @required this.value,
    @required this.initialValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint idleLine = new Paint()
      ..color = idleColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    Paint line = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), idleLine);
    canvas.drawLine(
        Offset(0, size.height / 2), Offset((size.width * initialValue) + size.width * value, size.height / 2), line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ProgressItem {
  final String name;
  final double initial;
  final double value;
  final Color color;

  ProgressItem(this.initial, {@required this.name, @required this.value, @required this.color});
}

class StaticCustomLinearProgressIndicator extends StatelessWidget {
  final Color color;
  final Color idleColor;
  final double value;
  final double initialValue;

  StaticCustomLinearProgressIndicator(
    this.initialValue, {
    @required this.color,
    this.idleColor = AppColorScheme.colorBlack4,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinearProgressPainter(
        initialValue: initialValue,
        idleColor: idleColor,
        color: color,
        value: value,
      ),
    );
  }
}
