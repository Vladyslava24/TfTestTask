import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:totalfit/model/progress/program_schedule_item.dart';
import 'package:ui_kit/ui_kit.dart';
import 'scheduled_workout_item_widget.dart';

class ProgramScheduleItemWidget extends StatelessWidget {
  final ProgramScheduleItem item;
  final Function(bool) onExpansionChanged;
  final Function(ScheduledWorkoutItem) onItemClick;

  ProgramScheduleItemWidget({
    @required this.item,
    @required this.onExpansionChanged,
    @required this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: AppColorScheme.colorPrimaryWhite,
          accentColor: AppColorScheme.colorPrimaryWhite,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          initiallyExpanded: true,
          onExpansionChanged: onExpansionChanged,
          key: PageStorageKey<ProgramScheduleItem>(item),
          title: _buildHeader(context),
          children: buildExpandableChildren(),
        ),
      ),
    );
  }

  List<Widget> buildExpandableChildren() {
    return item.workouts
        .map((e) =>
            ScheduledWorkoutItemWidget(item: e, onItemClick: onItemClick))
        .toList();
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).program_schedule_item_title(item.week),
                textAlign: TextAlign.left,
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                )),
            const SizedBox(height: 4),
            Text(item.dateRange,
                textAlign: TextAlign.left,
                style: textRegular10.copyWith(
                  color: AppColorScheme.colorBlack7,
                )),
            const SizedBox(height: 6),
          ],
        ),
      ],
    );
  }
}
