import 'package:flutter/widgets.dart';
import 'package:totalfit/model/profile/list_items.dart';

class PaginationData {
  final List<FeedItem> appendItems;
  final bool isLastPage;
  final int pageOffset;

  PaginationData({
    @required this.appendItems,
    @required this.isLastPage,
    @required this.pageOffset,
  });

  factory PaginationData.initial() {
    return PaginationData(
      appendItems: [],
      isLastPage: false,
      pageOffset: 0,
    );
  }

  PaginationData copyWith({
    List<FeedItem> appendItems,
    bool lastPage,
    int offset,
  }) {
    return PaginationData(
      appendItems: appendItems ?? this.appendItems,
      isLastPage: lastPage ?? this.isLastPage,
      pageOffset: offset ?? this.pageOffset,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationData &&
          runtimeType == other.runtimeType &&
          appendItems == other.appendItems &&
          pageOffset == other.pageOffset &&
          isLastPage == other.isLastPage;

  @override
  int get hashCode =>
      pageOffset.hashCode ^
      appendItems.hashCode ^
      isLastPage.hashCode;
}
