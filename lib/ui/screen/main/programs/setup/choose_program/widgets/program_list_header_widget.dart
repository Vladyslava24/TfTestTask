import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/choose_program/feed_program_header_list_item.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramListHeaderWidget extends StatelessWidget {
  final FeedProgramHeaderListItem item;

  ProgramListHeaderWidget({@required this.item});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S
                      .of(context)
                      .programs__choose_the_program_title
                      .toUpperCase(),
                  textAlign: TextAlign.left,
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).programs__choose_the_program_subtitle,
                  textAlign: TextAlign.left,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
