import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress/program_progress_workout_item.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/summary_progress_indicator.dart';
import 'package:totalfit/utils/string_extensions.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramProgressWODWidget extends StatelessWidget {
  final ProgramProgressWODItem item;
  final VoidCallback onWorkoutSelected;
  final Key key;

  ProgramProgressWODWidget({
    @required this.item,
    @required this.onWorkoutSelected,
    @required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context).programs_progress__workout_of_the_day,
            textAlign: TextAlign.left,
            style: title20.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
          const SizedBox(height: 12),
          item.workout != null
              ? _buildItem(context)
              : _buildEmptyWorkoutItem(context),
        ],
      ),
    );
  }

  Widget _buildEmptyWorkoutItem(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TfImage(
                  url: imEmptyProgressState,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.2,
                  background: Colors.transparent,
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Text(
            S.of(context).programs_progress__empty_workout,
            textAlign: TextAlign.center,
            style: textRegular16.copyWith(
              color: AppColorScheme.colorBlack7,
            ),
          ),
        ],
      );

  Widget _buildItem(BuildContext context) {
    final workoutProgressPercent =
        item.workoutProgress == null ? 0.0 : _countWorkoutProgressPercent();
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppColorScheme.colorYellow,
                      width: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 2.5,
                  child: Opacity(
                    opacity: 0.0,
                    child: SvgPicture.asset(
                      checkIc,
                      width: 12,
                      height: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: ColorFiltered(
                    colorFilter: !(item.workoutProgress != null &&
                            (item.workoutProgress.finished ?? false))
                        ? const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          )
                        : const ColorFilter.mode(
                            AppColorScheme.colorBlack7,
                            BlendMode.saturation,
                          ),
                    child: TfImage(
                      url: item.workout.image,
                      width: double.infinity,
                      height: 211,
                    ),
                  ),
                ),
                !(item.workoutProgress != null &&
                        (item.workoutProgress.finished ?? false))
                    ? const SizedBox.shrink()
                    : Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColorScheme.colorYellow),
                          width: 32,
                          height: 32,
                          child: const Align(
                            alignment: Alignment.center,
                            child: const Icon(Icons.done),
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          buildBadge(
                              "${item.workout.estimatedTime} ${S.of(context).min}",
                              AppColorScheme.colorBlack5),
                          const SizedBox(width: 4),
                          buildBadge(item.workout.difficultyLevel,
                              AppColorScheme.colorBlack5),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.workout.theme.capitalize(),
                        textAlign: TextAlign.left,
                        style: title20.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.workout.equipment.join(", ").toUpperCase(),
                        textAlign: TextAlign.left,
                        style: textRegular10.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                      workoutProgressPercent == 0.0 ||
                              workoutProgressPercent == 1.0
                          ? Container()
                          : LayoutBuilder(
                              builder: (context, constraints) => Column(
                                children: [
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    width: constraints.biggest.width,
                                    child: StaticCustomLinearProgressIndicator(
                                      0.0,
                                      value: workoutProgressPercent,
                                      color: AppColorScheme.colorYellow,
                                      idleColor: AppColorScheme.colorBlack7
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onWorkoutSelected,
                        splashColor:
                            AppColorScheme.colorYellow.withOpacity(0.3),
                        highlightColor:
                            AppColorScheme.colorYellow.withOpacity(0.1),
                        child: const SizedBox.shrink(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _countWorkoutProgressPercent() {
    return (item.workoutProgress.warmupStageDuration != null ? 0.25 : 0.0) +
        (item.workoutProgress.skillStageDuration != null ? 0.25 : 0.0) +
        (item.workoutProgress.wodStageDuration != null ? 0.25 : 0.0) +
        (item.workoutProgress.cooldownStageDuration != null ? 0.25 : 0.0);
  }
}

buildBadge(String text, Color color) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(const Radius.circular(10)),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 6,
        ),
        color: color,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: textRegular12.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ),
      ),
    ),
  );
}
