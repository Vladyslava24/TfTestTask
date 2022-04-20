import 'dart:ffi';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/domain/bloc/entry_bloc/entry_bloc.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/sign_up_type.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/form.dart';
import 'package:totalfit/ui/utils/web.dart';
import 'package:totalfit/ui/widgets/auth_type_selector.dart';
import 'package:totalfit/ui/widgets/base_checkbox_rounded_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final TapGestureRecognizer _termsConditionsTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyPolicyTapRecognizer = TapGestureRecognizer();

  double opacityLevel = 1.0;
  static const int titleAnimationDuration = 300;
  EntryBloc _bloc;

  @override
  void initState() {
    _bloc = EntryBloc(userRepository: DependencyProvider.get<UserRepository>());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }

  Future<void> _handleError(TfException error) async {
    final attrs = TfDialogAttributes(
      description: error.getMessage(context),
      positiveText: S.of(context).all__OK,
    );
    await TfDialog.show(context, attrs);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      onDispose: (_) => _bloc.close(),
      onWillChange: (oldVm, newVm) async {
        if (!oldVm.isUserLoggedIn && newVm.isUserLoggedIn) {
          if (newVm.user.wasOnboarded) {
            newVm.navigateToMainScreen();
          } else {
            newVm.navigateToOnboardingScreen();
          }
          return;
        }

        if (!oldVm.isUserSignedIn && newVm.isUserSignedIn) {
          if (newVm.user.wasOnboarded) {
            newVm.navigateToMainScreen();
          } else {
            newVm.navigateToOnboardingScreen();
          }
        }
      },
      builder: (context, vm) => _buildEntryLayout(vm),
    );
  }

  _progressIndicator(EntryState state) {
    return Visibility(
      child: DimmedCircularLoadingIndicator(),
      visible: state.formStatus == FormStatus.submissionInProgress,
      replacement: SizedBox.shrink(),
    );
  }

  Widget _buildEntryLayout(_ViewModel vm) {
    return BlocProvider.value(
        value: _bloc,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(signUpBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.light,
                    child: WillPopScope(
                      onWillPop: () => _onBackPressed(vm),
                      child: Stack(
                        children: [
                          _buildEntryLayoutTitle(),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BaseElevatedButton(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  text: S.of(context).entry_screen_btn_to_sign_up,
                                  icon: Icons.mail,
                                  onPressed: () => vm.navigateToSignUpScreen(),
                                ),
                                // LinesWithText(
                                //   text: S.of(context).entry_screen_sign_with,
                                //   padding: EdgeInsets.only(bottom: 16),
                                // ),
                                AuthTypeSelector(
                                  googleBtnText: S.of(context).sign_up_with_google_btn,
                                  appleBtnText: S.of(context).sign_up_with_apple_btn,
                                  onGoogleTap: () {
                                    _buildSocialPrivacyDialog(
                                      GoogleSignUp(),
                                    );
                                  },
                                  // onFacebookTap: () {
                                  //   _buildSocialPrivacyDialog(
                                  //     FacebookSignUp(),
                                  //   );
                                  // },
                                  onAppleTap: () {
                                    _buildSocialPrivacyDialog(
                                      AppleSignUp(),
                                    );
                                  },
                                ),
                                SizedBox(height: 16.0),
                                _buildSignInButton(vm),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocProvider.value(
              value: _bloc,
              child: BlocConsumer<EntryBloc, EntryState>(
                listener: (BuildContext context, EntryState state) {
                  if (state.formStatus == FormStatus.submissionInProgress) {
                    Navigator.of(context).pop();
                  }

                  if (state.formStatus == FormStatus.submissionSuccess &&
                      state.user is User &&
                      state.type is SignUpType) {
                    vm.onUserSignUpAction(state.user, state.type);
                  }

                  if (state.formStatus == FormStatus.submissionFailure) {
                    _handleError(state.error);
                    vm.reportError(state.error);
                  }
                },
                builder: (BuildContext context, EntryState state) {
                  return _progressIndicator(state);
                },
              ),
            )
          ],
        ));
  }

  Widget _buildSignInButton(_ViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          S.of(context).entry_screen_already_have,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColorScheme.colorBlack7,
          ),
        ),
        Container(width: 2.0),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => vm.onLogin(),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              S.of(context).entry_screen_btn_sign_in,
              textAlign: TextAlign.center,
              style: title16.copyWith(
                color: AppColorScheme.colorYellow,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEntryLayoutTitle() {
    return Positioned(
      left: 0.0,
      top: 16.0,
      child: AnimatedOpacity(
        opacity: opacityLevel,
        duration: const Duration(milliseconds: titleAnimationDuration),
        child: Text(S.of(context).entry_screen_title, style: title30),
      ),
    );
  }

  void _buildSocialPrivacyDialog(SignUpType type) {
    _changeOpacity();
    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      barrierColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColorScheme.colorBlack,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              topLeft: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(S.of(context).entry_screen_terms_title, style: title30),
              SizedBox(height: 16.0),
              Text(S.of(context).entry_screen_terms_text,
                  style: textRegular16.copyWith(color: AppColorScheme.colorBlack9)),
              _termsAndPolicy(_bloc.state),
              _emailNotification(),
              BaseElevatedButton(
                onPressed: () => _bloc.add(SignUpWithSocial(type)),
                text: S.of(context).entry_screen_terms_button,
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      _changeOpacity();
      _bloc.add(ChangeShowTooltip(false));
      _bloc.add(ChangePrivacyChecked(false));
      _bloc.add(ChangeEmailNotificationAllowance(false));
    });
  }

  Widget _termsAndPolicy(EntryState state) => Container(
        padding: EdgeInsets.only(top: 16.0, bottom: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BaseCheckBoxRoundedWidget(
                value: state.privacyChecked,
                margin: const EdgeInsets.only(right: 12.0, top: 2.0),
                onChanged: (value) => _bloc.add(
                  ChangePrivacyChecked(value),
                ),
              ),
              Expanded(
                child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text: S.of(context).sign_up_i_agree_to,
                    style: textRegular16.copyWith(color: AppColorScheme.colorBlack9),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: _termsConditionsTapRecognizer..onTap = () => launchURL(TERMS_OF_USE),
                        text: S.of(context).sign_up_i_agree_terms,
                        style: textRegular16.copyWith(
                          color: AppColorScheme.colorYellow,
                        ),
                      ),
                      TextSpan(text: S.of(context).sign_up_i_agree_and),
                      TextSpan(
                        recognizer: _privacyPolicyTapRecognizer..onTap = () => launchURL(PRIVACY_POLICY),
                        text: S.of(context).sign_up_i_agree_privacy,
                        style: textRegular16.copyWith(
                          color: AppColorScheme.colorYellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _emailNotification() => Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BaseCheckBoxRoundedWidget(
              value: _bloc.state.emailNotificationAllowed,
              margin: const EdgeInsets.only(right: 12.0, top: 2.0),
              onChanged: (value) => _bloc.add(
                ChangeEmailNotificationAllowance(value),
              ),
            ),
            Expanded(
                child: Text(S.of(context).sign_up_email_allowance,
                    style: textRegular16.copyWith(color: AppColorScheme.colorBlack9))),
          ],
        ),
      );
}

class _ViewModel {
  final Function navigateToMainScreen;
  final Function navigateToSignUpScreen;
  final Function onUserSignUpAction;
  final bool isUserLoggedIn;
  final bool isUserSignedIn;
  final VoidCallback onLogin;
  final User user;
  final Function navigateToOnboardingScreen;
  final Function(TfException) reportError;

  _ViewModel({
    @required this.onLogin,
    @required this.isUserLoggedIn,
    @required this.isUserSignedIn,
    @required this.navigateToMainScreen,
    @required this.navigateToSignUpScreen,
    @required this.navigateToOnboardingScreen,
    @required this.reportError,
    @required this.user,
    @required this.onUserSignUpAction,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      navigateToSignUpScreen: () => store.dispatch(NavigateToSignUpAction()),
      navigateToMainScreen: () => store.dispatch(NavigateToMainScreenAction()),
      navigateToOnboardingScreen: () => store.dispatch(NavigateToOnboardingScreenAction()),
      onUserSignUpAction: (User user, SignUpType type) => store.dispatch(OnUserSignUpAction(user, type)),
      isUserSignedIn: store.state.signUpState.isLoggedIn(),
      user: store.state.loginState.user,
      isUserLoggedIn: store.state.loginState.isLoggedIn(),
      reportError: (e) =>
          store.dispatch(ErrorReportAction(where: 'Entry Screen', trigger: Void, errorMessage: e.toString())),
      onLogin: () => store.dispatch(NavigateToLoginAction()),
    );
  }
}
