import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress/program_progress_header_item.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/summary_progress_indicator.dart';
import 'package:totalfit/utils/string_extensions.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramProgressHeaderWidget extends StatelessWidget {
  final ProgramProgressHeaderItem item;

  ProgramProgressHeaderWidget({
    @required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.programName.toUpperCase(),
            style: title20.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                width: 177,
                child: StaticCustomLinearProgressIndicator(
                  0.0,
                  value: item.programProgress.workoutsDone /
                      item.programProgress.workoutsQuantity,
                  color: AppColorScheme.colorYellow,
                  idleColor: AppColorScheme.colorBlack4,
                ),
              ),
              Text(
                item.programProgressText,
                style: textRegular12.copyWith(
                  color: AppColorScheme.colorBlack7,
                ),
              ),
            ],
          ),
          const SizedBox(width: 0, height: 18.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildPointItem(
                  item.level, S.of(context).program_setup_summary__level),
              const SizedBox(width: 8.0, height: 0),
              _buildPointItem(
                  item.weeks.toString(),
                  S
                      .of(context)
                      .choose_program_number_of_weeks_screen__weeks
                      .capitalize()),
              const SizedBox(width: 8.0, height: 0),
              _buildPointItem(item.daysOfWeek.toString(),
                  S.of(context).programs_progress__days_a_week),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointItem(String value, String title) => Expanded(
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(cardBorderRadius)),
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        color: AppColorScheme.colorBlack2,
        child: Column(
          children: [
            Text(
              value,
              style: title14.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
            const SizedBox(width: 0, height: 2.0),
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
}
