import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import '../actions/choose_program_actions.dart';
import '../states/choose_program_screen_state.dart';

final chooseProgramScreenReducer = combineReducers<ChooseProgramScreenState>([
  TypedReducer<ChooseProgramScreenState, ShowChooseProgramLoadingIndicatorAction>(
      _showChooseProgramLoadingIndicatorAction),
  TypedReducer<ChooseProgramScreenState, SetChooseProgramsAction>(_setChooseProgramsAction),
  TypedReducer<ChooseProgramScreenState, SetChooseProgramsListAction>(_setChooseProgramsListAction),
  TypedReducer<ChooseProgramScreenState, ClearChooseProgramExceptionAction>(_clearChooseProgramExceptionAction),
  TypedReducer<ChooseProgramScreenState, OnChooseProgramErrorAction>(_onChooseProgramErrorAction),
  TypedReducer<ChooseProgramScreenState, ClearAppendedChooseProgramItemsAction>(_clearAppendedChooseProgramItemsAction),
  TypedReducer<ChooseProgramScreenState, ClearChooseProgramPaginationControllerAction>(
      _clearChooseProgramListItemsAction),
  TypedReducer<ChooseProgramScreenState, ClearSetNewListChooseProgramFlagAction>(_clearSetNewListFlagAction),
  TypedReducer<ChooseProgramScreenState, RefreshProgramOnListAction>(_refreshProgramOnListAction),
  TypedReducer<ChooseProgramScreenState, LogoutAction>(_onLogoutAction),
]);

ChooseProgramScreenState _onLogoutAction(ChooseProgramScreenState state, LogoutAction action) =>
    ChooseProgramScreenState.initial();

ChooseProgramScreenState _clearAppendedChooseProgramItemsAction(
        ChooseProgramScreenState state, ClearAppendedChooseProgramItemsAction action) =>
    state.copyWith(paginationData: PaginationData.initial());

ChooseProgramScreenState _clearChooseProgramListItemsAction(
        ChooseProgramScreenState state, ClearChooseProgramPaginationControllerAction action) =>
    state.copyWith(clearPaginationController: action.clear);

ChooseProgramScreenState _clearSetNewListFlagAction(
        ChooseProgramScreenState state, ClearSetNewListChooseProgramFlagAction action) =>
    state.copyWith(setNewList: false);

ChooseProgramScreenState _refreshProgramOnListAction(
        ChooseProgramScreenState state, RefreshProgramOnListAction action) =>
    state.copyWith(isNeedToRefresh: action.isNeedToRefresh);

ChooseProgramScreenState _showChooseProgramLoadingIndicatorAction(
        ChooseProgramScreenState state, ShowChooseProgramLoadingIndicatorAction action) =>
    state.copyWith(showLoadingIndicator: action.showLoadingIndicator);

ChooseProgramScreenState _setChooseProgramsAction(ChooseProgramScreenState state, SetChooseProgramsAction action) {
  final listItems = List.of(state.listItems);
  print('LIST');
  print(listItems.toString());
  listItems.addAll(action.paginationData.appendItems);
  return state.copyWith(showLoadingIndicator: false, listItems: listItems, paginationData: action.paginationData);
}

ChooseProgramScreenState _setChooseProgramsListAction(
        ChooseProgramScreenState state, SetChooseProgramsListAction action) =>
    state.copyWith(showLoadingIndicator: false, listItems: action.listItems, setNewList: true);

ChooseProgramScreenState _clearChooseProgramExceptionAction(
        ChooseProgramScreenState state, ClearChooseProgramExceptionAction action) =>
    state.copyWith(error: IdleException());

ChooseProgramScreenState _onChooseProgramErrorAction(
        ChooseProgramScreenState state, OnChooseProgramErrorAction action) =>
    state.copyWith(showLoadingIndicator: false, error: action.error);
