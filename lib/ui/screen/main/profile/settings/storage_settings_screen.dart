import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/settings_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class StorageSettingsScreen extends StatefulWidget {
  @override
  _StorageSettingsScreenState createState() => _StorageSettingsScreenState();
}

class _StorageSettingsScreenState extends State<StorageSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      onInit: (store) {
        store.dispatch(FetchVideoStorageSizeAction());
      },
      builder: (context, vm) => _buildContent(vm)
    );
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
    appBar: SimpleAppBar(
      leadingType: LeadingType.back,
      leadingAction: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      title: S.of(context).storage,
    ),
    backgroundColor: AppColorScheme.colorBlack,
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: WillPopScope(
        onWillPop: () => _onBackPressed(vm),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 33.0, right: 33.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: S.of(context).tap_clear_storage,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: vm.videoCacheSize,
                        style: title16.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                      TextSpan(text: S.of(context).clear_storage_device),
                    ],
                  ),
                ),
              ),
              _clearButton(vm),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _clearButton(_ViewModel vm) => Flexible(
    fit: FlexFit.loose,
    child: ActionButton(
      text: S.of(context).clear_storage,
      color: AppColorScheme.colorRed,
      textColor: AppColorScheme.colorPrimaryWhite,
      padding: EdgeInsets.only(
        top: 16.0,
        bottom: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      onPressed: () {
        vm.clearStorage();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    ),
  );
}

class _ViewModel {
  final Function clearStorage;
  final String videoCacheSize;

  _ViewModel({
    @required this.clearStorage,
    @required this.videoCacheSize,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
    videoCacheSize: store.state.settingsScreenState.videoCacheSize,
    clearStorage: () => store.dispatch(ClearStorageAction()),
  );
}
