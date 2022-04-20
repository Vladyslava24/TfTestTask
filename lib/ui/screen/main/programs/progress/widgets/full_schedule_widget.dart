import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress/program_full_schedule_item.dart';
import 'package:ui_kit/ui_kit.dart';

class FullScheduleWidget extends StatelessWidget {
  final FullScheduleItem item;
  final VoidCallback onFullScheduleClick;

  FullScheduleWidget({
    @required this.item,
    @required this.onFullScheduleClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
      child: Row(
        children: <Widget>[
          Text(
            S.of(context).programs_progress__this_week,
            textAlign: TextAlign.left,
            style: title20.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
          const Expanded(child: const SizedBox.shrink()),
          CupertinoButton(
            padding: const EdgeInsets.only(right: 0.0),
            onPressed: onFullScheduleClick,
            child: Row(children: <Widget>[
              Text(
                S.of(context).programs_progress__full_schedule,
                textAlign: TextAlign.left,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorYellow,
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppColorScheme.colorYellow),
            ]),
          )
        ],
      ),
    );
  }
}
