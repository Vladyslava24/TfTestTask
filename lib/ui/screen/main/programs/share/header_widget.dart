import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramShareResultHeaderWidget extends StatelessWidget {
  final String image;
  final int workoutCount;
  final int totalExerciseCount;
  final int totalMinutes;
  final GlobalKey shareContentKey;

  ProgramShareResultHeaderWidget(
      {@required this.shareContentKey,
      @required this.image,
      @required this.workoutCount,
      @required this.totalExerciseCount,
      @required this.totalMinutes});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width;
    return RepaintBoundary(
      key: shareContentKey,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: <Widget>[
            Container(
              child: TfImage(
                url: image,
                width: imageSize,
                height: imageSize,
              ),
            ),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    S.of(context).program_finished.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: title20.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    S.of(context).become_stronger_with_more_weight.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: textRegular12.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildPointsRow(context)
                ],
              ),
            ),
            Positioned(
              top: 14,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() => SizedBox(
        width: 58,
        height: 58,
        child: Image.asset(
          imLogo,
          fit: BoxFit.cover,
        ),
      );

  Widget _buildPointsRow(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        _buildPointItem(workoutCount.toString(), S.of(context).bottom_menu__workouts, '🏅'),
        SizedBox(width: 14),
        _buildPointItem(totalExerciseCount.toString(), S.of(context).exercises, '💪'),
        SizedBox(width: 14),
        _buildPointItem((totalMinutes / 1000 ~/ 60).toString(), S.of(context).minutes, '⏱️'),
      ]);

  Widget _buildPointItem(String count, String title, String emodji) => Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
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
      );
}
