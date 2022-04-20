import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/model/profile/profile_error_type.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/pagination/first_page_error_indicator.dart';
import 'package:totalfit/ui/widgets/pagination/first_page_progress_indicator.dart';
import 'package:totalfit/ui/widgets/pagination/new_page_error_indicator.dart';
import 'package:totalfit/ui/widgets/pagination/new_page_progress_indicator.dart';
import 'package:ui_kit/ui_kit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  Function _lastCalledActionFunction;

  final PagingController<int, FeedItem> _pagingController = PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          _pagingController.addPageRequestListener((pageKey) {
            if (!store.state.profileScreenState.paginationData.isLastPage) {
              store.dispatch(LoadCompletedWorkoutsHistoryAction(pageKey));
            }
          });
        },
        onDispose: (store) {
          _pagingController.dispose();
        },
        onWillChange: (oldVm, newVm) async {
          if(oldVm.markRequireUpdate == false && newVm.markRequireUpdate == true){
            newVm.onItemAppended();
            _pagingController.refresh();
            newVm.onChangeMarkRequireUpdate();
          }
          if (newVm.error is PaginationError) {
            _pagingController.error = newVm.error.e;
            newVm.clearError(newVm.error);
          } else if (newVm.error is! EmptyProfileError) {
            _handleError(newVm);
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

          if (newVm.paginationData.appendItems.isNotEmpty) {
            if (newVm.paginationData.isLastPage) {
              _pagingController.appendLastPage(newVm.paginationData.appendItems);
            } else {
              _pagingController.itemList = [];
              _pagingController.appendPage(newVm.paginationData.appendItems, newVm.paginationData.pageOffset);
            }

            newVm.onItemAppended();
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Future<void> _handleError(_ViewModel vm) async {
    var error = vm.error;
    var e = vm.error.e;
    vm.clearError(error);

    void _onClick() {
      if (error is ViewItemError || error is ShareItemError || error is DeleteItemError) {
        _lastCalledActionFunction.call();
      }
    }

    final attrs = TfDialogAttributes(
      title: S.of(context).dialog_error_title,
      description: e.getMessage(context),
      negativeText: S.of(context).dialog_error_recoverable_negative_text,
      positiveText: S.of(context).all__retry,
    );
    final result = await TfDialog.show(context, attrs);
    if (result is Confirm) {
      _onClick();
    }
  }

  String _getUserName(_ViewModel vm) {
    return '${vm.user?.firstName}' +
        '${vm.user != null && vm.user.lastName != null && vm.user.lastName.isNotEmpty ? ' ' + vm.user.lastName : ""}';
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        appBar: SimpleAppBar(
          leadingType: LeadingType.settings,
          leadingAction: vm.navigateToSettings,
          title: _getUserName(vm),
          actionType: ActionType.button,
          actionButtonText: S.of(context).edit_profile,
          actionFunction: vm.navigateToEditProfile,
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light, child: vm.isUserLoggedIn() ? _buildItemList(vm) : Container()),
      );

  Widget _buildItemList(_ViewModel vm) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => Future.sync(() {
            vm.onItemAppended();
            _pagingController.refresh();
          }),
          child: PagedListView<int, FeedItem>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<FeedItem>(
                firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                      errorTitle: "${S.of(context).all__error}!",
                      errorMessage: (_pagingController.error as TfException).getMessage(context),
                      onTryAgain: () => _pagingController.refresh(),
                    ),
                newPageErrorIndicatorBuilder: (_) => NewPageErrorIndicator(
                      errorTitle: "${S.of(context).all__error}!",
                      errorMessage: (_pagingController.error as TfException).getMessage(context),
                      onTap: () => _pagingController.retryLastFailedRequest(),
                    ),
                firstPageProgressIndicatorBuilder: (_) => FirstPageProgressIndicator(),
                newPageProgressIndicatorBuilder: (_) => NewPageProgressIndicator(),
                itemBuilder: (context, item, index) {
                  if (item is ProfileHeaderListItem) {
                    return ProfileHeaderWidget(
                      item: item,
                      navigateToEditProfile: vm.navigateToEditProfile,
                      navigateToSettings: vm.navigateToSettings,
                    );
                  }
                  if (item is CompletedWorkoutListItem) {
                    return CompletedWorkoutWidget(
                        item: item,
                        onShare: () {
                          _lastCalledActionFunction = () => vm.onShareResult(item);
                          _lastCalledActionFunction.call();
                        },
                        onView: () {
                          _lastCalledActionFunction = () => vm.onViewResult(item);
                          _lastCalledActionFunction.call();
                        },
                        onDelete: () {
                          _lastCalledActionFunction = () => vm.onDeleteResult(item);
                          _lastCalledActionFunction.call();
                        });
                  }

                  if (item is SpaceItem) {
                    return Container(height: 100);
                  }

                  return Container();
                }),
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
        child: DimmedCircularLoadingIndicator(), visible: vm.showLoadingIndicator, replacement: SizedBox.shrink());
  }
}

class _ViewModel {
  final List<FeedItem> listItems;
  final User user;
  final Function navigateToSettings;
  final Function navigateToEditProfile;
  final Function(CompletedWorkoutListItem) onShareResult;
  final Function(CompletedWorkoutListItem) onViewResult;
  final Function(CompletedWorkoutListItem) onDeleteResult;
  final Function() onChangeMarkRequireUpdate;
  final ProfileError error;
  final Function(ProfileError) clearError;
  final Function onItemAppended;
  final Function onClearPaginationController;
  final Function onClearSetNewListFlag;
  final bool showLoadingIndicator;
  final bool clearPaginationController;
  final bool setNewList;
  final PaginationData paginationData;
  final bool markRequireUpdate;

  bool isUserLoggedIn() {
    return user != null;
  }

  _ViewModel(
      {@required this.user,
      @required this.listItems,
      @required this.markRequireUpdate,
      @required this.navigateToSettings,
      @required this.navigateToEditProfile,
      @required this.onChangeMarkRequireUpdate,
      @required this.onShareResult,
      @required this.onViewResult,
      @required this.onDeleteResult,
      @required this.error,
      @required this.clearError,
      @required this.showLoadingIndicator,
      @required this.clearPaginationController,
      @required this.paginationData,
      @required this.onItemAppended,
      @required this.onClearPaginationController,
      @required this.setNewList,
      @required this.onClearSetNewListFlag});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      setNewList: store.state.profileScreenState.setNewList,
      markRequireUpdate: store.state.profileScreenState.markRequireUpdate,
      clearPaginationController: store.state.profileScreenState.clearPaginationController,
      paginationData: store.state.profileScreenState.paginationData,
      showLoadingIndicator: store.state.profileScreenState.showLoadingIndicator,
      error: store.state.profileScreenState.error,
      listItems: store.state.profileScreenState.listItems,
      clearError: (error) => store.dispatch(ClearProfileExceptionAction(error: error)),
      onChangeMarkRequireUpdate: () => store.dispatch(MarkProfileRequireUpdate(false)),
      onItemAppended: () => store.dispatch(ClearAppendedItemsAction()),
      onClearPaginationController: () => store.dispatch(ClearPaginationControllerAction(false)),
      onClearSetNewListFlag: () => store.dispatch(ClearSetNewListFlagAction()),
      navigateToEditProfile: () => store.dispatch(NavigateToProfileEdit()),
      navigateToSettings: () => store.dispatch(NavigateToSettings()),
      onShareResult: (item) => store.dispatch(OnShareProgressAction(item: item)),
      onViewResult: (item) {
        store.dispatch(OnViewProgressAction(item: item));
      },
      onDeleteResult: (item) => store.dispatch(OnDeleteCompletedWorkoutAction(item: item)),
      user: store.state.loginState.user,
    );
  }
}
