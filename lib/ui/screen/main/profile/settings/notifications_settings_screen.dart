import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/grant_model.dart';
import 'package:totalfit/redux/actions/push_notifications_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/states/push_notifications_state.dart';
import 'package:totalfit/ui/widgets/settings/notifications_permission_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  @override
  _NotificationsSettingsScreenState createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }

  Future<void> _handleError(TfException error) async {
    final attrs = TfDialogAttributes(description: error.getMessage(context), positiveText: S.of(context).all__OK);
    await TfDialog.show(context, attrs);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          store.dispatch(GetPushNotificationsConfig());
          bool allValue = false;
          if (store.state.pushNotificationsState.wod &&
              store.state.pushNotificationsState.dailyReading &&
              store.state.pushNotificationsState.updatesAndNews) {
            allValue = true;
          }
          _settingsGrant = [
            GrantModel(
                type: GrantType.all, key: 'all', value: allValue, title: S.of(context).push_notifications_title_all),
            GrantModel(
                type: GrantType.wod,
                key: 'wod',
                value: store.state.pushNotificationsState.wod,
                title: S.of(context).push_notifications_title_wod),
            GrantModel(
                type: GrantType.dailyReading,
                key: 'dailyReading',
                value: store.state.pushNotificationsState.dailyReading,
                title: S.of(context).push_notifications_title_daily_reading),
            GrantModel(
                type: GrantType.updatesAndNews,
                key: 'updatesAndNews',
                value: store.state.pushNotificationsState.updatesAndNews,
                title: S.of(context).push_notifications_title_updates_and_news),
          ];
        },
        onWillChange: (oldVm, newVm) {
          if (oldVm.pushNotificationsState.errorMessage != newVm.pushNotificationsState.errorMessage &&
              newVm.pushNotificationsState.errorMessage.isNotEmpty) {
            _handleError(
                    TfException(ErrorCode.ERROR_PUSH_NOTIFICATIONS_CONFIG, newVm.pushNotificationsState.errorMessage))
                .then((_) => newVm.clearError());
          }

          if (newVm.pushNotificationsState.wod &&
              newVm.pushNotificationsState.dailyReading &&
              newVm.pushNotificationsState.updatesAndNews) {
            setState(() {
              _settingsGrant.map((el) => el.type == GrantType.all ? el.value = true : el).toList();
            });
          } else {
            setState(() {
              _settingsGrant.map((el) => el.type == GrantType.all ? el.value = false : el).toList();
            });
          }

          if (oldVm.pushNotificationsState.wod != newVm.pushNotificationsState.wod) {
            setState(() {
              _settingsGrant
                  .map((el) => el.type == GrantType.wod ? el.value = newVm.pushNotificationsState.wod : el)
                  .toList();
            });
          }

          if (oldVm.pushNotificationsState.dailyReading != newVm.pushNotificationsState.dailyReading) {
            setState(() {
              _settingsGrant
                  .map((el) =>
                      el.type == GrantType.dailyReading ? el.value = newVm.pushNotificationsState.dailyReading : el)
                  .toList();
            });
          }

          if (oldVm.pushNotificationsState.updatesAndNews != newVm.pushNotificationsState.updatesAndNews) {
            setState(() {
              _settingsGrant
                  .map((el) =>
                      el.type == GrantType.updatesAndNews ? el.value = newVm.pushNotificationsState.updatesAndNews : el)
                  .toList();
            });
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  List<GrantModel> _settingsGrant = [];

  void _changeAllGrant(GrantType type, bool value, _ViewModel vm) {
    if (type == GrantType.all) {
      setState(() {
        _settingsGrant.map((element) => element.value = value).toList();
      });
    } else {
      setState(() {
        _settingsGrant.map((element) => element.type == type ? element.value = value : element).toList();
      });
    }

    final subGrantList = _settingsGrant.sublist(1);
    subGrantList.every((element) => element.value == false)
        ? setState(() {
            _settingsGrant.first.value = false;
          })
        : setState(() {
            _settingsGrant.first.value = true;
          });

    subGrantList.every((element) => element.value == true)
        ? setState(() {
            _settingsGrant.first.value = true;
          })
        : setState(() {
            _settingsGrant.first.value = false;
          });

    final wodValue = _settingsGrant.firstWhere((element) => element.type == GrantType.wod).value ?? true;
    final dailyReadingValue =
        _settingsGrant.firstWhere((element) => element.type == GrantType.dailyReading).value ?? true;
    final updatesAndNewsValue =
        _settingsGrant.firstWhere((element) => element.type == GrantType.updatesAndNews).value ?? true;

    vm.setupPushNotifications(wodValue, dailyReadingValue, updatesAndNewsValue);
  }

  Widget _buildContent(_ViewModel vm) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: WillPopScope(
          onWillPop: () => _onBackPressed(vm),
          child: Scaffold(
            appBar: SimpleAppBar(
              leadingType: LeadingType.back,
              leadingAction: () => Navigator.of(context).pop(),
              title: S.of(context).notifications,
            ),
            backgroundColor: AppColorScheme.colorBlack,
            body: vm.pushNotificationsState.isLoading
                ? Center(child: CircularLoadingIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: List<Widget>.of(
                            _settingsGrant.map((element) {
                              return Column(
                                children: [
                                  Container(
                                      color: AppColorScheme.colorBlack,
                                      height: element.type == GrantType.all
                                          ? 0.0
                                          : element.type == GrantType.wod
                                              ? 16.0
                                              : 1.0),
                                  NotificationsPermissionWidget(
                                    title: element.title,
                                    value: element.value,
                                    onChanged: (value) => _changeAllGrant(element.type, value, vm),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(20.0),
                        //     child: IconButton(
                        //       onPressed: () async {
                        //         FlutterSecureStorage prefs = FlutterSecureStorage();
                        //         final String fcm = await prefs.read(key: 'fieldTokenFCM');
                        //
                        //         await Clipboard.setData(ClipboardData(text: fcm)).then((_){
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //             const SnackBar(
                        //               content: Text('Copied'),
                        //             ),
                        //           );
                        //         });
                        //       },
                        //       icon: Icon(Icons.copy, color: Colors.white),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
          ),
        ),
      );
}

class _ViewModel {
  final Function setupPushNotifications;
  final Function getPushNotificationsConfig;
  final Function clearError;
  final PushNotificationsState pushNotificationsState;

  _ViewModel(
      {@required this.setupPushNotifications,
      @required this.getPushNotificationsConfig,
      @required this.clearError,
      @required this.pushNotificationsState});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      setupPushNotifications: (wod, dailyReading, updatesAndNews) => store.dispatch(
          SetupPushNotificationsSettingsAction(wod: wod, dailyReading: dailyReading, updatesAndNews: updatesAndNews)),
      getPushNotificationsConfig: () => store.dispatch(GetPushNotificationsConfig()),
      clearError: () => store.dispatch(ClearConfigErrorAction()),
      pushNotificationsState: store.state.pushNotificationsState);
}
