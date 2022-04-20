import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/link/app_links.dart';
import 'package:totalfit/model/reset_stage.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/reset_password_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/states/reset_password_state.dart';
import 'package:totalfit/ui/widgets/auth/subtitle_widget.dart';
import 'package:totalfit/ui/widgets/auth/title_widget.dart';
import 'package:totalfit/ui/widgets/input_field_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordLink deepLink;

  ResetPasswordScreen({@required this.deepLink});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _newPasswordNode = FocusNode();
  FocusNode _confirmNewPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          store.dispatch(UpdateResetPasswordStateAction(widget.deepLink));
        },
        onWillChange: (oldVm, newVm) {
          if (newVm.resetPasswordState.error is! IdleException) {
            _handleError(newVm);
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Future<void> _handleError(_ViewModel vm) async {
    vm.clearResetPasswordException();
    _emailNode.unfocus();
    final attrs = TfDialogAttributes(
      title: S.of(context).all__error,
      description: vm.resetPasswordState.error.toString(),
      negativeText: S.of(context).dialog_error_recoverable_negative_text,
      positiveText: S.of(context).all__retry,
    );
    final result = await TfDialog.show(context, attrs);
    if (result is Confirm) {
      _resetPassword(vm);
    }
  }

  Future<void> _resetPassword(_ViewModel vm) async {
    FocusScope.of(context).requestFocus(FocusNode());
    vm.resetPassword(_emailController.text);
    FocusScope.of(context).unfocus();
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        appBar: _appBar(vm),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: WillPopScope(
            onWillPop: () => _onBackPressed(vm),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[_buildStageContent(vm), _progressIndicator(vm)],
            ),
          ),
        ),
      );

  // ignore: missing_return
  Widget _buildStageContent(_ViewModel vm) {
    switch (vm.resetPasswordState.stage) {
      case ResetStage.Request:
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(title: S.of(context).reset_password_screen_title),
                  SubTitleWidget(text: S.of(context).reset_password_screen_description),
                  _emailInput(vm),
                ],
              ),
              _resetPasswordButton(vm)
            ],
          ),
        );
      case ResetStage.BackToLogin:
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          //color: colorBlack,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(passwordRecoveryIcon),
                  _backToLoginInfoText(),
                ]),
              ),
              _backToLoginButton(),
            ],
          ),
        );
      case ResetStage.Update:
        return Container(
          width: double.infinity,
          height: double.infinity,
          //color: colorBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _newPasswordInput(vm),
                    _confirmNewPasswordInput(vm),
                  ],
                ),
              ),
              Container(height: 16.0),
              _setNewPasswordButton(vm),
            ],
          ),
        );
    }
  }

  Widget _appBar(_ViewModel vm) => AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColorScheme.colorBlack,
        title: Padding(
          padding: const EdgeInsets.only(right: 56.0),
          child: Center(
            child: Text(
              vm.resetPasswordState.stage == ResetStage.Update
                  ? S.of(context).reset_password_screen_app_bar
                  : S.of(context).reset_password_screen_app_bar_alt,
              textAlign: TextAlign.center,
              style: title16.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ),
        ),
        leading: Visibility(
            child: InkWell(
              child: const Icon(Icons.west),
              onTap: () {
                vm.clearEmailError();
                vm.resetPasswordState.stage != ResetStage.Update ? Navigator.of(context).pop() : vm.navigateToLogin();
              },
            ),
            replacement: const SizedBox.shrink()),
        iconTheme: IconThemeData(
          color: AppColorScheme.colorPrimaryWhite,
        ),
        elevation: 0.0,
      );

  Widget _emailInput(_ViewModel vm) => InputField(
        padding: const EdgeInsets.only(bottom: 24.0),
        errorMessage: vm.resetPasswordState.emailError,
        focusNode: _emailNode,
        nextFocusNode: null,
        textEditingController: _emailController,
        onEditingCompleted: () =>
          FocusScope.of(context).unfocus(),
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(
          color: AppColorScheme.colorBlack7,
        ),
        onClearError: () {
          vm.clearEmailError();
        },
        label: S.of(context).reset_password_screen_input_email,
        keyboardType: TextInputType.emailAddress,
      );

  Widget _newPasswordInput(_ViewModel vm) => InputField(
        padding: const EdgeInsets.only(bottom: 24.0),
        errorMessage: vm.resetPasswordState.newPasswordError,
        focusNode: _newPasswordNode,
        nextFocusNode: _confirmNewPasswordNode,
        obscureText: true,
        textEditingController: _newPasswordController,
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(
          color: AppColorScheme.colorBlack7,
        ),
        onClearError: () {
          vm.clearNewPasswordError();
        },
        label: S.of(context).reset_password_screen_new_password,
        keyboardType: TextInputType.visiblePassword,
      );

  Widget _confirmNewPasswordInput(_ViewModel vm) => InputField(
        padding: const EdgeInsets.only(bottom: 24.0),
        errorMessage: vm.resetPasswordState.confirmNewPasswordError,
        focusNode: _confirmNewPasswordNode,
        nextFocusNode: null,
        obscureText: true,
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(
          color: AppColorScheme.colorBlack7,
        ),
        textEditingController: _confirmNewPasswordController,
        onClearError: () {
          vm.clearConfirmNewCodeError();
        },
        label: S.of(context).reset_password_screen_confirm_password,
        keyboardType: TextInputType.visiblePassword,
      );

  Widget _resetPasswordButton(_ViewModel vm) => Flexible(
        fit: FlexFit.loose,
        child: BaseElevatedButton(
            text: S.of(context).reset_password_screen_button,
            onPressed: () async {
              await _resetPassword(vm);
            }),
      );

  Widget _backToLoginButton() => BaseElevatedButton(
      text: S.of(context).reset_password_screen_back,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).pop();
      });

  Widget _setNewPasswordButton(_ViewModel vm) => BaseElevatedButton(
      padding: const EdgeInsets.only(bottom: 16.0),
      text: S.of(context).reset_password_screen_create_new_password,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        vm.setNewPassword(_newPasswordController.text, _confirmNewPasswordController.text, widget.deepLink);
      });

  Widget _backToLoginInfoText() => Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          top: 24.0,
          right: 16.0,
          bottom: 12.0,
        ),
        child: Center(
          child: Text(
            S.of(context).reset_password_screen_back_to_login_info,
            textAlign: TextAlign.center,
            style: textRegular16.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ),
      );

  Future<bool> _onBackPressed(_ViewModel vm) {
    vm.clearEmailError();
    return Future.sync(() => true);
  }

  _progressIndicator(_ViewModel vm) {
    return Visibility(
      child: Container(color: Colors.transparent, child: CircularLoadingIndicator()),
      visible: vm.isLoading,
      replacement: SizedBox.shrink(),
    );
  }
}

class _ViewModel {
  final Function(String email) resetPassword;
  final Function clearEmailError;
  final bool isLoading;
  final Function navigateToLogin;
  final Function clearResetPasswordException;
  final Function clearNewPasswordError;
  final Function clearConfirmNewCodeError;
  final Function(String, String, ResetPasswordLink) setNewPassword;
  final ResetPasswordState resetPasswordState;

  _ViewModel(
      {@required this.resetPassword,
      @required this.clearEmailError,
      @required this.isLoading,
      @required this.navigateToLogin,
      @required this.clearResetPasswordException,
      @required this.setNewPassword,
      @required this.clearNewPasswordError,
      @required this.clearConfirmNewCodeError,
      @required this.resetPasswordState});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      resetPasswordState: store.state.resetPasswordState,
      resetPassword: (email) {
        store.dispatch(ValidateEmailForResetPasswordAction(email));
      },
      clearEmailError: () => store.dispatch(ClearEmailForResetPasswordErrorAction()),
      navigateToLogin: () => store.dispatch(NavigateToLoginAction()),
      setNewPassword: (password, confirmPassword, link) =>
          store.dispatch(ValidateNewPasswordAction(password, confirmPassword, link)),
      clearResetPasswordException: () => store.dispatch(ClearResetPasswordExceptionAction()),
      clearNewPasswordError: () => store.dispatch(ClearNewPasswordErrorAction()),
      clearConfirmNewCodeError: () => store.dispatch(ClearConfirmNewPasswordErrorAction()),
      isLoading: store.state.resetPasswordState.isLoading,
    );
  }
}
