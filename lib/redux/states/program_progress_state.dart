import 'package:flutter/material.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/ui/utils/utils.dart';

@immutable
class ProgramProgressState {
  final ActiveProgram activeProgram;
  final TfException error;
  final bool showLoading;
  final List<FeedItem> listItems;

  ProgramProgressState({
    @required this.activeProgram,
    @required this.error,
    @required this.showLoading,
    @required this.listItems,
  });

  factory ProgramProgressState.initial() {
    return ProgramProgressState(
      activeProgram: null,
      showLoading: false,
      error: IdleException(),
      listItems: [],
    );
  }

  ProgramProgressState copyWith({
    ActiveProgram program,
    TfException error,
    bool showLoading,
    List<FeedItem> listItems,
  }) {
    return ProgramProgressState(
      activeProgram: program ?? this.activeProgram,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      showLoading: showLoading ?? this.showLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramProgressState &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          showLoading == other.showLoading &&
          deepEquals(listItems, other.listItems) &&
          activeProgram == other.activeProgram;

  @override
  int get hashCode => error.hashCode ^ showLoading.hashCode ^ activeProgram.hashCode ^ deepHash(listItems);
}
