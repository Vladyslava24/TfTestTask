import 'package:flutter/cupertino.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/profile/pagination_data.dart';

class ClearAppendedChooseProgramItemsAction {}

class ClearChooseProgramPaginationControllerAction {
  final bool clear;

  ClearChooseProgramPaginationControllerAction(this.clear);
}

class ClearSetNewListChooseProgramFlagAction {}

class ClearChooseProgramExceptionAction {}

class LoadChooseProgramFeedAction {
  int pageOffset;

  LoadChooseProgramFeedAction(this.pageOffset);
}

class SetChooseProgramsAction {
  final PaginationData paginationData;

  SetChooseProgramsAction({@required this.paginationData});
}

class SetChooseProgramsListAction {
  final List<FeedItem> listItems;

  SetChooseProgramsListAction({@required this.listItems});
}

class OnChooseProgramErrorAction {
  final TfException error;

  OnChooseProgramErrorAction(this.error);
}

class ShowChooseProgramLoadingIndicatorAction {
  bool showLoadingIndicator;

  ShowChooseProgramLoadingIndicatorAction(this.showLoadingIndicator);
}

class RefreshProgramOnListAction {
  final bool isNeedToRefresh;

  RefreshProgramOnListAction({@required this.isNeedToRefresh});
}
