import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/redux/request_state.dart';
import 'package:totalfit/redux/states/app_state.dart';

class RequestLoadingHandler extends StatelessWidget {
  final Widget child;
  final VoidCallback showProgress;
  final VoidCallback hideProgress;

  RequestLoadingHandler({@required this.child, @required this.showProgress, @required this.hideProgress});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _RequestAwareViewModel>(
        distinct: true,
        converter: _RequestAwareViewModel.fromStore,
        onWillChange: (oldVm, newVm) {
          if (!oldVm.requestState.isRunning() && newVm.requestState.isRunning() && newVm.requestState.showLoader()) {
            showProgress();
          }
          if (oldVm.requestState.isRunning() && !newVm.requestState.isRunning()) {
            hideProgress();
          }
        },
        builder: (context, vm) => RequestDispatcher(vm, child));
  }
}

class RequestErrorListener<T extends TfException> extends StatelessWidget {
  final Widget child;
  final Function(T) onError;

  RequestErrorListener({@required this.child, @required this.onError});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ErrorAwareViewModel>(
        distinct: true,
        converter: _ErrorAwareViewModel.fromStore,
        onWillChange: (oldVm, newVm) {
          if (!oldVm.requestState.isError() && newVm.requestState.isError() && newVm.requestState.getError() is T) {
            onError(newVm.requestState.getError());
          }
        },
        builder: (context, vm) => child);
  }
}

class RequestDispatcher extends InheritedWidget {
  final _RequestAwareViewModel _vm;
  final Widget child;

  RequestDispatcher(this._vm, this.child) : super(child: child);

  void sendRequest(Function call, {showLoader = true}) {
    _vm.sendRequest(RequestAction._(call, showLoader));
  }

  static RequestDispatcher of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RequestDispatcher>();
  }

  @override
  bool updateShouldNotify(covariant RequestDispatcher oldWidget) => false;
}

class _ErrorAwareViewModel {
  final RequestState requestState;

  _ErrorAwareViewModel({@required this.requestState});

  static _ErrorAwareViewModel fromStore(Store<AppState> store) {
    return _ErrorAwareViewModel(requestState: store.state.requestState);
  }
}

class _RequestAwareViewModel {
  final RequestState requestState;
  final Function(RequestAction) sendRequest;

  _RequestAwareViewModel({@required this.requestState, @required this.sendRequest});

  static _RequestAwareViewModel fromStore(Store<AppState> store) {
    return _RequestAwareViewModel(
        requestState: store.state.requestState, sendRequest: (action) => store.dispatch(action));
  }
}

class RequestAction {
  final Function call;
  final bool showLoader;

  RequestAction._(this.call, this.showLoader);
}

class OnRequestErrorAction {
  final TfException error;

  OnRequestErrorAction(this.error);
}

class RequestResultAction {}

class CancelRequestAction implements RequestResultAction {}
