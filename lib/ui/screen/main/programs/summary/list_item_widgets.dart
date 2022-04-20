import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';
import 'program_summary_screen.dart';

class ProgramSummaryHeaderWidget extends StatefulWidget {
  final HeaderItem item;

  ProgramSummaryHeaderWidget({@required this.item, Key key}) : super(key: key);

  @override
  _ProgramSummaryHeaderWidgetState createState() => _ProgramSummaryHeaderWidgetState();
}

class _ProgramSummaryHeaderWidgetState extends State<ProgramSummaryHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: <Widget>[
          TfImage(url: widget.item.image, width: double.infinity, height: 242),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    AppColorScheme.colorBlack,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  S.of(context).programs_progress__fantastic_youve_finished_program,
                  textAlign: TextAlign.left,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  S.of(context).become_stronger_with_more_weight.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticItemWidget extends StatelessWidget {
  final StatisticItem item;

  StatisticItemWidget({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).programs_progress__you_reached,
            style: title20.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
          SizedBox(height: 12),
          _buildItem(item.points.toString(), '🏆', context),
          SizedBox(height: 12),
          _buildPointsRow(context)
        ],
      ),
    );
  }

  Widget _buildPointsRow(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        _buildPointItem(item.workoutCount.toString(), S.of(context).bottom_menu__workouts, '🏅'),
        SizedBox(width: 14),
        _buildPointItem(item.totalExerciseCount.toString(), S.of(context).exercises, '💪'),
        SizedBox(width: 14),
        _buildPointItem((item.totalMinutes / 1000 ~/ 60).toString(), S.of(context).minutes, '⏱️'),
      ]);

  Widget _buildPointItem(String count, String title, String emodji) => Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          child: Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
            color: AppColorScheme.colorBlack2,
            child: Column(
              children: [
                Text(
                  emodji,
                  textAlign: TextAlign.center,
                  style: title30,
                ),
                SizedBox(height: 4),
                Text(
                  count.toString(),
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                SizedBox(height: 4),
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
      );

  Widget _buildItem(String count, String emodji, BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: Container(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
          color: AppColorScheme.colorBlack2,
          child: Row(
            children: [
              Text(
                emodji,
                textAlign: TextAlign.center,
                style: title30,
              ),
              SizedBox(width: 12),
              Text(
                '$count ${S.of(context).points}'.toUpperCase(),
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ],
          ),
        ),
      );
}

class ProgramSummarySkillItemWidget extends StatelessWidget {
  final ProgramSummarySkillItem item;

  ProgramSummarySkillItemWidget({@required this.item});

  @override
  Widget build(BuildContext context) {
    return _buildItem(item.name, item.image);
  }

  Widget _buildItem(String name, String imageUrl) => Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(borderRadius: new BorderRadius.circular(4), child: TfImage(url: imageUrl, width: 75, height: 54)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.left,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
          ],
        ),
      );
}

class ProgramSummarySkillHeaderItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12, bottom: 4),
          child: Text(
            S.of(context).skill_learned,
            textAlign: TextAlign.left,
            style: title20.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ),
      ],
    );
  }
}
