import 'package:flutter/material.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/profile/pagination_data.dart';

@immutable
class ChooseProgramScreenState {
  final PaginationData paginationData;
  final TfException error;
  final bool showLoadingIndicator;
  final List<FeedItem> listItems;
  final bool clearPaginationController;
  final bool setNewList;
  final bool isNeedToRefresh;

  ChooseProgramScreenState({
    @required this.paginationData,
    @required this.error,
    @required this.showLoadingIndicator,
    @required this.listItems,
    @required this.clearPaginationController,
    @required this.setNewList,
    @required this.isNeedToRefresh,
  });

  factory ChooseProgramScreenState.initial() {
    return ChooseProgramScreenState(
      paginationData: PaginationData.initial(),
      error: IdleException(),
      listItems: [],
      showLoadingIndicator: false,
      clearPaginationController: false,
      setNewList: false,
      isNeedToRefresh: false,
    );
  }

  ChooseProgramScreenState copyWith({
    PaginationData paginationData,
    TfException error,
    List<FeedItem> listItems,
    bool showLoadingIndicator,
    bool clearPaginationController,
    bool setNewList,
    bool isNeedToRefresh,
  }) {
    return ChooseProgramScreenState(
      paginationData: paginationData ?? this.paginationData,
      listItems: listItems ?? this.listItems,
      isNeedToRefresh: isNeedToRefresh ?? this.isNeedToRefresh,
      error: error ?? this.error,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
      clearPaginationController: clearPaginationController ?? this.clearPaginationController,
      setNewList: setNewList ?? this.setNewList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChooseProgramScreenState &&
          runtimeType == other.runtimeType &&
          paginationData == other.paginationData &&
          listItems == other.listItems &&
          showLoadingIndicator == other.showLoadingIndicator &&
          clearPaginationController == other.clearPaginationController &&
          setNewList == other.setNewList &&
          isNeedToRefresh == other.isNeedToRefresh &&
          error == other.error;

  @override
  int get hashCode =>
      paginationData.hashCode ^
      error.hashCode ^
      listItems.hashCode ^
      clearPaginationController.hashCode ^
      setNewList.hashCode ^
      isNeedToRefresh.hashCode ^
      showLoadingIndicator.hashCode;
}
