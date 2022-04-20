import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';
import 'package:totalfit/ui/widgets/hexagon/rive_hexagon.dart';
import 'package:totalfit/ui/widgets/measure_size.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgressHeaderWidget extends StatefulWidget {
  final ProgressHeaderListItem item;
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final bool previousArrowVisible;
  final bool nextArrowVisible;
  final Function(bool) onHexagonExpansionChanged;

  ProgressHeaderWidget(
      {@required this.item,
      @required this.nextPage,
      @required this.previousPage,
      @required this.previousArrowVisible,
      @required this.nextArrowVisible,
      @required this.onHexagonExpansionChanged,
      Key key})
      : super(key: key);

  @override
  _ProgressHeaderWidgetState createState() => _ProgressHeaderWidgetState();
}

class _ProgressHeaderWidgetState extends State<ProgressHeaderWidget>
    with AutomaticKeepAliveClientMixin {
  double _measuredHeight;

  @override
  bool get wantKeepAlive => true;

  void _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) return;

    if (details.primaryVelocity.compareTo(0) == -1) {
      if (widget.nextArrowVisible) {
        widget.nextPage();
      }
    } else {
      if (widget.previousArrowVisible) {
        widget.previousPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final hexSize = MediaQuery.of(context).size.width * 0.7;
    return Stack(
      children: <Widget>[
        MeasureSize(
          onChange: (size) async {
            if (_measuredHeight == null) {
              setState(() {
                _measuredHeight = size.height;
              });
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: widget.item.date == null
                        ? TextSpan(
                            text: '',
                            style: title20.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          )
                        : TextSpan(
                            text: S.of(context).progress_header_item_title,
                            style: title20.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: _getDate(),
                                style: TextStyle(
                                  color: AppColorScheme.colorYellow,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              Container(height: 16.0),
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) =>
                    _onHorizontalDrag(details),
                child: RiveHexagon(
                  params: toRiveHexagonParam(widget.item.rateMap),
                  animationDelayMillis: 1500,
                  width: hexSize,
                  height: hexSize,
                  initialy: false,
                  key: ValueKey(widget.item.date),
                ),
              ),
            ],
          ),
        ),
        _measuredHeight == null ? Container() : _buildLeftArrow(),
        _measuredHeight == null ? Container() : _buildRightArrow()
      ],
    );
  }

  String _getDate() {
    int date = DateTime.parse(widget.item.date).millisecondsSinceEpoch;
    if (isTodayDate(date)) {
      return S.of(context).all__today;
    } else {
      return workoutTitleFormatted(date);
    }
  }

  Widget _buildLeftArrow() {
    return Positioned(
      top: (_measuredHeight - 32) / 2,
      left: 0,
      child: GestureDetector(
        onTap: () {
          if (widget.previousArrowVisible) {
            widget.previousPage();
          }
        },
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: widget.previousArrowVisible ? 1.0 : 0.0,
          child: Container(
            height: 56,
            width: 56,
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: AppColorScheme.colorYellow,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightArrow() {
    return Positioned(
      top: (_measuredHeight - 32) / 2,
      right: 0,
      child: GestureDetector(
        onTap: () {
          if (widget.nextArrowVisible) {
            widget.nextPage();
          }
        },
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: widget.nextArrowVisible ? 1.0 : 0.0,
          child: Container(
            height: 56,
            width: 56,
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: AppColorScheme.colorYellow,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
