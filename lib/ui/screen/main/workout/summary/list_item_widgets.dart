import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/skill_summary_list_items.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';
import 'package:totalfit/ui/widgets/hexagon/rive_hexagon.dart';
import 'package:ui_kit/ui_kit.dart';

class PageHeaderWorkoutSummaryWidget extends StatefulWidget {
  final PageHeaderWorkoutSummaryListItem item;

  PageHeaderWorkoutSummaryWidget({@required this.item, Key key})
      : super(key: key);

  @override
  _PageHeaderWorkoutSummaryWidgetState createState() =>
      _PageHeaderWorkoutSummaryWidgetState();
}

class _PageHeaderWorkoutSummaryWidgetState
    extends State<PageHeaderWorkoutSummaryWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final hexSize = MediaQuery.of(context).size.width * 0.7;
    return Column(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        widget.item.showBackArrow
            ? Align(
                alignment: Alignment.centerLeft,
                child: _backArrow(),
              )
            : Container(),
        Container(
          padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.item.title.toUpperCase(),
              textAlign: TextAlign.left,
              style: title20.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.item.subTitle,
              textAlign: TextAlign.left,
              style: textRegular16.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        widget.item.finished ? SizedBox.shrink() : Container(height: 16),
        widget.item.finished
            ? SizedBox.shrink()
            : RiveHexagon(
                params: toRiveHexagonParam(widget.item.rateMap),
                animationDelayMillis: 1500,
                width: hexSize,
                height: hexSize,
                initialy: true,
                key: ValueKey('WorkoutSummary${widget.key}'),
              ),
        widget.item.finished ? SizedBox.shrink() : Container(height: 22),
        _buildPointsRow()
      ],
    );
  }

  Widget _backArrow() => SafeArea(
    child: Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 36.0,
          height: 36.0,
          margin: const EdgeInsets.only(left: 12.0, bottom: 12.0),
          child: IconBackCircleWidget(
            action: () => Navigator.of(context).pop(),
          ),
        ),
      )
    ),
  );

  Widget _buildPointsRow() => Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    widget.item.wodType == "AMRAP"
        ? _buildPointItem(
            widget.item.roundCount.toString(),
            widget.item.roundCount == 1
                ? S.of(context).round
                : S.of(context).rounds)
        : _buildPointItem(widget.item.workoutDuration.toString(),
            S.of(context).minutes),
    _buildPointItem(
        widget.item.totalExercises.toString(), S.of(context).exercises),
    _buildPointItem(
        widget.item.totalPoints.toString(), S.of(context).points_upper),
  ]);

  Widget _buildPointItem(String count, String title) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: new BorderRadius.all(Radius.circular(8)),
        child: Container(
          padding: EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
          color: AppColorScheme.colorBlack2,
          child: Column(
            children: [
              Text(
                count.toString(),
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
              Container(height: 4),
              Text(
                title,
                style: textRegular12.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ResultItemWidget extends StatelessWidget {
  final ResultItem item;

  ResultItemWidget({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: new BorderRadius.all(Radius.circular(8)),
        child: Container(
          padding: EdgeInsets.all(12),
          color: AppColorScheme.colorBlack2,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 28,
                    height: 28,
                    decoration: new BoxDecoration(
                      color: AppColorScheme.colorBlack4,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.done,
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                  Container(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: title20,
                      ),
                      Container(height: 4),
                      Text(
                        item.subTitle.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: textRegular10.copyWith(
                          color: AppColorScheme.colorBlack7,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SkillResultItemWidget extends StatelessWidget {
  final SkillItem item;

  SkillResultItemWidget({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: new BorderRadius.all(Radius.circular(8)),
        child: Container(
          padding: EdgeInsets.all(12),
          color: AppColorScheme.colorBlack2,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        color: AppColorScheme.colorBlack4,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.done,
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                  Container(width: 10),
                  Text(
                    S.of(context).exercise_category_title_skill,
                    textAlign: TextAlign.left,
                    style: title20.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                ],
              ),
              Container(
                height: 12,
              ),
              _buildExercise(item.imageUrl)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExercise(String imageUrl) => Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(10),
              child: TfImage(
                url: imageUrl,
                width: 75,
                height: 54,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              item.skillName,
              textAlign: TextAlign.left,
              style: textRegular16.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ],
        ),
      );
}

class ListBottomPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 84,
    child: Text('text'),
    );
  }
}
