import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/program_progress_dto.dart';
import 'package:totalfit/model/profile/list_items.dart';

class ProgramProgressHeaderItem implements FeedItem {
  final String programName;
  final String level;
  final int weeks;
  final int daysOfWeek;
  final ProgramProgressDto programProgress;
  final String programProgressText;

  ProgramProgressHeaderItem({
    @required this.programName,
    @required this.level,
    @required this.weeks,
    @required this.daysOfWeek,
    @required this.programProgress,
    @required this.programProgressText,
  });

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramProgressHeaderItem &&
          runtimeType == other.runtimeType &&
          programName == other.programName &&
          level == other.level &&
          weeks == other.weeks &&
          daysOfWeek == other.daysOfWeek &&
          programProgressText == other.programProgressText &&
          programProgress == other.programProgress;

  @override
  int get hashCode =>
      programProgress.hashCode ^ level.hashCode ^ weeks.hashCode ^ daysOfWeek.hashCode ^ programProgressText.hashCode;
}
