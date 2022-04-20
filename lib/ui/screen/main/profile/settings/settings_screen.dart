import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/settings_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/paywall_screen.dart';
import 'package:totalfit/ui/utils/web.dart';
import 'package:totalfit/ui/widgets/app_version_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      onInit: (store) {
        _controller = ScrollController();
        store.dispatch(FetchVideoStorageSizeAction());
      },
      onDispose: (store) {
        _controller.dispose();
      },
      builder: (context, vm) => _buildContent(vm),
    );
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        appBar: SimpleAppBar(
          title: S.of(context).settings,
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.pop(context),
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: vm.item.user == null ? Container() : _buildItemList(vm),
        ),
      );

  Widget _buildItemList(_ViewModel vm) => Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
                controller: _controller,
                key: ValueKey("settings_list"),
                itemCount: 1,
                itemBuilder: (context, index) => _buildSingleScrollableListItem(vm)),
          ),
        ],
      );

  Widget _buildSingleScrollableListItem(_ViewModel vm) {
    return Column(
      children: [
        CupertinoButton(
            child: _buildItem(S.of(context).edit_profile),
            padding: EdgeInsets.zero,
            onPressed: vm.navigateToEditProfile),
        Container(color: AppColorScheme.colorBlack, height: 1),
        CupertinoButton(
            child: _buildItem(S.of(context).notifications_settings),
            padding: EdgeInsets.zero,
            onPressed: vm.navigateToNotificationsSettings),
        _buildCategoryHeaderItem(S.of(context).security.toUpperCase()),
        Container(color: AppColorScheme.colorBlack, height: 1),
        _buildEmailItem(vm.item.user.email),
        Container(color: AppColorScheme.colorBlack, height: 1),
        GestureDetector(child: _buildPasswordItem() /*, onTap: vm.navigateToResetPassword*/
            ),
        Container(color: AppColorScheme.colorBlack, height: 24),
        CupertinoButton(
            child: StorageItemWidget(videoCacheSize: vm.videoCacheSize),
            padding: EdgeInsets.zero,
            onPressed: vm.navigateToStorageSetting),
        _buildCategoryHeaderItem(S.of(context).help_and_support.toUpperCase()),
        CupertinoButton(
            child: _buildItem(S.of(context).entry_screen_terms_title),
            padding: EdgeInsets.zero,
            onPressed: () {
              launchURL(TERMS_OF_USE);
              vm.onPressedTermsOfUse();
            }),
        Container(color: AppColorScheme.colorBlack, height: 1),
        CupertinoButton(
            child: _buildItem(S.of(context).entry_screen_i_agree_privacy),
            padding: EdgeInsets.zero,
            onPressed: () {
              launchURL(PRIVACY_POLICY);
              vm.onPressedPrivacyPolicy();
            }),
        Container(color: AppColorScheme.colorBlack, height: 1),
        CupertinoButton(
            child: _buildItem(S.of(context).support_and_feedback),
            padding: EdgeInsets.zero,
            onPressed: () {
              _sendEmailToSupport();
              vm.onPressedSendEmail();
            }),
        Container(color: AppColorScheme.colorBlack, height: 24),
        _buildLogoutItem(vm),
        _buildAppVersion()
      ],
    );
  }

  Widget _buildItem(String item) => Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        color: AppColorScheme.colorBlack2,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_right, color: AppColorScheme.colorPrimaryWhite)
          ],
        ),
      );

  Widget _buildPremiumItem(_ViewModel vm) => Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        color: AppColorScheme.colorBlack2,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: '${S.of(context).totalfit} ',
                    style: title16.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: S.of(context).premium,
                        style: title16.copyWith(
                          color: AppColorScheme.colorYellow,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            vm.isPremiumUser
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorScheme.colorYellow,
                    ),
                    child: Icon(
                      Icons.done,
                      color: AppColorScheme.colorPrimaryBlack,
                      size: 20,
                    ),
                  )
                : Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColorScheme.colorYellow,
                  ),
          ],
        ),
      );

  Widget _buildLogoutItem(_ViewModel vm) => CupertinoButton(
        onPressed: vm.logout,
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
          color: AppColorScheme.colorBlack2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).log_out,
                    textAlign: TextAlign.center,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildEmailItem(String email) => Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        color: AppColorScheme.colorBlack2,
        child: Row(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).reset_password_screen_input_email,
                textAlign: TextAlign.center,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  email,
                  textAlign: TextAlign.center,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorBlack7,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildPasswordItem() => Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        color: AppColorScheme.colorBlack2,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).sign_in_screen_input_password,
                  textAlign: TextAlign.center,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '••••••••••',
                  textAlign: TextAlign.center,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorBlack7,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildCategoryHeaderItem(String title) => Container(
        height: 48,
        padding: EdgeInsets.only(left: 16, right: 16, top: 24),
        color: AppColorScheme.colorBlack,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: textRegular12.copyWith(
              color: AppColorScheme.colorBlack7,
            ),
          ),
        ),
      );

  Widget _buildAppVersion() => Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      color: AppColorScheme.colorBlack,
      child: AppVersionWidget());

  _sendEmailToSupport() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@totalfit.app',
    );
    launchURL(_emailLaunchUri.toString());
  }
}

class _ViewModel {
  final SingleListItem item;
  final Function(User) updateProfile;
  final Function logout;
  final Function navigateToEditProfile;
  final Function navigateToSoundSetting;
  final Function navigateToResetPassword;
  final Function navigateToStorageSetting;
  final Function onPressedTermsOfUse;
  final Function onPressedPrivacyPolicy;
  final Function onPressedSendEmail;
  final Function navigateToNotificationsSettings;
  final String videoCacheSize;
  final bool isPremiumUser;

  _ViewModel({
    @required this.item,
    @required this.videoCacheSize,
    @required this.updateProfile,
    @required this.logout,
    @required this.navigateToEditProfile,
    @required this.navigateToSoundSetting,
    @required this.navigateToStorageSetting,
    @required this.navigateToResetPassword,
    @required this.navigateToNotificationsSettings,
    @required this.onPressedTermsOfUse,
    @required this.onPressedPrivacyPolicy,
    @required this.onPressedSendEmail,
    @required this.isPremiumUser,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      videoCacheSize: store.state.settingsScreenState.videoCacheSize,
      item: SingleListItem(user: store.state.loginState.user),
      logout: () => store.dispatch(LogoutAction()),
      navigateToStorageSetting: () => store.dispatch(NavigateToStorageSetting()),
      navigateToEditProfile: () => store.dispatch(NavigateToProfileEdit()),
      navigateToSoundSetting: () => store.dispatch(NavigateToSoundSetting()),
      navigateToResetPassword: () => store.dispatch(NavigateToResetPasswordAction()),
      updateProfile: (user) => store.dispatch(UpdateProfileAction(user: user)),
      onPressedTermsOfUse: () => store.dispatch(OnPressedTermsOfUseFromSettingsAction()),
      onPressedPrivacyPolicy: () => store.dispatch(OnPressedPrivacyPolicyFromSettingsAction()),
      isPremiumUser: store.state.isPremiumUser(),
      onPressedSendEmail: () => store.dispatch(OnPressedSendEmailAction()),
      navigateToNotificationsSettings: () => store.dispatch(NavigateToNotificationsSettingsAction()));
}

class SingleListItem {
  final User user;

  SingleListItem({@required this.user});
}

class StorageItemWidget extends StatelessWidget {
  final String videoCacheSize;

  StorageItemWidget({
    @required this.videoCacheSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
      color: AppColorScheme.colorBlack2,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: "${S.of(context).storage} ",
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: videoCacheSize,
                      style: textRegular16.copyWith(
                        color: AppColorScheme.colorBlack7,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            S.of(context).clear,
            style: textRegular16.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ],
      ),
    );
  }
}
