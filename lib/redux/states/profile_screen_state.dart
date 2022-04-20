import 'package:flutter/material.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/model/profile/profile_error_type.dart';

import '../../model/profile/list_items.dart';


@immutable
class ProfileScreenState {
  final PaginationData paginationData;
  final ProfileError error;
  final bool showLoadingIndicator;
  final List<FeedItem> listItems;
  final bool clearPaginationController;
  final bool setNewList;
  final bool markRequireUpdate;

  ProfileScreenState({
    @required this.paginationData,
    @required this.error,
    @required this.showLoadingIndicator,
    @required this.listItems,
    @required this.clearPaginationController,
    @required this.markRequireUpdate,
    @required this.setNewList,
  });

  factory ProfileScreenState.initial() {
    return ProfileScreenState(
      markRequireUpdate: false,
      paginationData: PaginationData.initial(),
      error: EmptyProfileError(),
      listItems: [],
      showLoadingIndicator: false,
      clearPaginationController: false,
      setNewList: false,
    );
  }

  ProfileScreenState copyWith({
    PaginationData paginationData,
    ProfileError error,
    List<FeedItem> listItems,
    bool showLoadingIndicator,
    bool clearPaginationController,
    bool setNewList,
    bool markRequireUpdate,
  }) {
    return ProfileScreenState(
      markRequireUpdate: markRequireUpdate ?? this.markRequireUpdate,
      paginationData: paginationData ?? this.paginationData,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
      clearPaginationController: clearPaginationController ?? this.clearPaginationController,
      setNewList: setNewList ?? this.setNewList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileScreenState &&
          runtimeType == other.runtimeType &&
          markRequireUpdate == other.markRequireUpdate &&
          paginationData == other.paginationData &&
          listItems == other.listItems &&
          showLoadingIndicator == other.showLoadingIndicator &&
          clearPaginationController == other.clearPaginationController &&
          setNewList == other.setNewList &&
          error == other.error;

  @override
  int get hashCode =>
      paginationData.hashCode ^
      markRequireUpdate.hashCode ^
      error.hashCode ^
      listItems.hashCode ^
      clearPaginationController.hashCode ^
      setNewList.hashCode ^
      showLoadingIndicator.hashCode;
}
