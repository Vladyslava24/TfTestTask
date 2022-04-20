import 'package:flutter/material.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/ui/utils/utils.dart';

@immutable
class ProgramFullScheduleState {
  final List<FeedItem> listItems;

  ProgramFullScheduleState({
    @required this.listItems,
  });

  factory ProgramFullScheduleState.initial() {
    return ProgramFullScheduleState(
      listItems: [],
    );
  }

  ProgramFullScheduleState copyWith({
    List<FeedItem> listItems,
  }) {
    return ProgramFullScheduleState(
      listItems: listItems ?? this.listItems,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramFullScheduleState && runtimeType == other.runtimeType && deepEquals(listItems, other.listItems);

  @override
  int get hashCode => deepHash(listItems);
}
