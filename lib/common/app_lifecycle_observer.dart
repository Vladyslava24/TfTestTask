import 'package:adjust_sdk/adjust.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/redux/actions/app_state_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxAppLifecycleObserver extends StatelessWidget {
  final Widget child;

  ReduxAppLifecycleObserver({@required this.child});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return AppLifecycleObserver(child: child, onChanged: (state) => vm.onAppStateChanged(state));
        });
  }
}

class _ViewModel {
  final Function(AppLifecycleState) onAppStateChanged;

  _ViewModel({@required this.onAppStateChanged});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(onAppStateChanged: (state) => store.dispatch(OnAppStateChangedAction(state: state)));
  }
}

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  final Function(AppLifecycleState) onChanged;

  AppLifecycleObserver({@required this.child, @required this.onChanged});

  @override
  _AppLifecycleObserverState createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver> with WidgetsBindingObserver {
  AppLifecycleState _lifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_lifecycleState != state) {
      _lifecycleState = state;
      widget.onChanged(_lifecycleState);
    }
    switch (state) {
      case AppLifecycleState.resumed:
        Adjust.onResume();
        break;
      case AppLifecycleState.paused:
        Adjust.onPause();
        break;
      case AppLifecycleState.inactive:
        //ignore
        break;
      case AppLifecycleState.detached:
        //ignore
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
