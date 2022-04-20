import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/choose_program/feed_program_header_list_item.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/redux/actions/choose_program_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/programs/setup/choose_program/widgets/program_list_header_widget.dart';
import 'package:totalfit/ui/widgets/pagination/first_page_error_indicator.dart';
import 'package:totalfit/ui/widgets/pagination/first_page_progress_indicator.dart';
import 'package:totalfit/ui/widgets/pagination/new_page_error_indicator.dart';
import 'package:totalfit/ui/widgets/pagination/new_page_progress_indicator.dart';
import 'package:ui_kit/ui_kit.dart';

import 'widgets/program_item_widget.dart';

class ChooseProgramScreen extends StatefulWidget {
  const ChooseProgramScreen({Key key}) : super(key: key);

  @override
  _ChooseProgramScreenState createState() => _ChooseProgramScreenState();
}

class _ChooseProgramScreenState extends State<ChooseProgramScreen>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller;

  final PagingController<int, FeedItem> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          _controller = ScrollController();
          _pagingController.addPageRequestListener((pageKey) {
            store.dispatch(LoadChooseProgramFeedAction(pageKey));
          });
        },
        onDispose: (store) {
          _controller.dispose();
          _pagingController.dispose();
        },
        onWillChange: (oldVm, newVm) async {
          if (newVm.error is! IdleException) {
            _pagingController.error = newVm.error;
            newVm.clearError();
          }

          if (newVm.clearPaginationController) {
            if (_pagingController.itemList != null) {
              _pagingController.itemList.clear();
            }
            newVm.onClearPaginationController();
          }

          if (newVm.setNewList) {
            _pagingController.itemList = newVm.listItems;
            newVm.onClearSetNewListFlag();
          }

          if (newVm.isNeedToRefresh) {
            _pagingController.refresh();
            newVm.onClearRefreshFlag();
          }

          if (newVm.paginationData.appendItems.isNotEmpty) {
            if (newVm.paginationData.isLastPage) {
              _pagingController
                  .appendLastPage(newVm.paginationData.appendItems);
            } else {
              _pagingController.appendPage(newVm.paginationData.appendItems,
                  newVm.paginationData.pageOffset);
            }
            newVm.onItemAppended();
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light, child: _buildItemList(vm)));

  Widget _buildItemList(_ViewModel vm) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          child: PagedListView<int, FeedItem>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<FeedItem>(
              firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                  errorTitle: S.of(context).dialog_error_title,
                  errorMessage:
                      (_pagingController.error as TfException).getMessage(context),
                  onTryAgain: () => _pagingController.refresh()),
              newPageErrorIndicatorBuilder: (_) => NewPageErrorIndicator(
                  errorTitle: S.of(context).dialog_error_title,
                  errorMessage:
                      (_pagingController.error as TfException).getMessage(context),
                  onTap: () => _pagingController.retryLastFailedRequest()),
              firstPageProgressIndicatorBuilder: (_) =>
                  const FirstPageProgressIndicator(),
              newPageProgressIndicatorBuilder: (_) =>
                  const NewPageProgressIndicator(),
              itemBuilder: (context, item, index) {
                if (item is FeedProgramHeaderListItem) {
                  return ProgramListHeaderWidget(
                    item: item,
                  );
                }
                if (item is FeedProgramListItem) {
                  return ProgramListItemWidget(
                      item: item,
                      onProgramClick: (item) {
                        if (item.isActive) {
                          vm.showActiveProgram();
                        } else {
                          vm.onProgramClick(item);
                          vm.showProgramDescription();
                        }
                      });
                }

                if (item is SpaceItem) {
                  return const SizedBox(height: 68);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        _progressIndicator(vm),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  _progressIndicator(_ViewModel vm) {
    return Visibility(
      child: Container(
          color: AppColorScheme.colorPrimaryBlack,
          child: const CircularLoadingIndicator()),
      visible: vm.showLoadingIndicator,
      replacement: const SizedBox.shrink(),
    );
  }
}

class _ViewModel {
  final List<FeedItem> listItems;
  final TfException error;
  final Function clearError;
  final Function onItemAppended;
  final Function onClearPaginationController;
  final Function onClearSetNewListFlag;
  final Function onClearRefreshFlag;
  final Function(int) loadChooseProgramFeedAction;
  final Function(FeedProgramListItem) onProgramClick;
  final bool showLoadingIndicator;
  final bool clearPaginationController;
  final bool setNewList;
  final bool isNeedToRefresh;
  final PaginationData paginationData;
  final Function showActiveProgram;
  final Function showProgramDescription;

  _ViewModel({
    @required this.listItems,
    @required this.error,
    @required this.clearError,
    @required this.showLoadingIndicator,
    @required this.clearPaginationController,
    @required this.loadChooseProgramFeedAction,
    @required this.paginationData,
    @required this.onItemAppended,
    @required this.onClearPaginationController,
    @required this.setNewList,
    @required this.onClearSetNewListFlag,
    @required this.onProgramClick,
    @required this.isNeedToRefresh,
    @required this.onClearRefreshFlag,
    @required this.showActiveProgram,
    @required this.showProgramDescription,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isNeedToRefresh: store.state.chooseProgramScreenState.isNeedToRefresh,
      setNewList: store.state.chooseProgramScreenState.setNewList,
      clearPaginationController:
          store.state.chooseProgramScreenState.clearPaginationController,
      paginationData: store.state.chooseProgramScreenState.paginationData,
      showLoadingIndicator:
          store.state.chooseProgramScreenState.showLoadingIndicator,
      error: store.state.chooseProgramScreenState.error,
      listItems: store.state.chooseProgramScreenState.listItems,
      loadChooseProgramFeedAction: (pageKey) =>
          store.dispatch(LoadChooseProgramFeedAction(pageKey)),
      clearError: () => store.dispatch(ClearChooseProgramExceptionAction()),
      onItemAppended: () =>
          store.dispatch(ClearAppendedChooseProgramItemsAction()),
      onClearPaginationController: () =>
          store.dispatch(ClearChooseProgramPaginationControllerAction(false)),
      onClearRefreshFlag: () =>
          store.dispatch(RefreshProgramOnListAction(isNeedToRefresh: false)),
      onClearSetNewListFlag: () =>
          store.dispatch(ClearSetNewListChooseProgramFlagAction()),
      onProgramClick: (program) =>
          store.dispatch(SetProgramAction(program: program)),
      showActiveProgram: () =>
          store.dispatch(SwitchProgramTabAction(showActiveProgram: true)),
      showProgramDescription: () =>
          store.dispatch(ShowProgramDescriptionPageAction()),
    );
  }
}
