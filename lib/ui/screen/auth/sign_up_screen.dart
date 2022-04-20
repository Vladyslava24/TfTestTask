import 'dart:io' show Platform;

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/domain/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/sign_up_type.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/form.dart';
import 'package:totalfit/ui/utils/screen_size.dart';
import 'package:totalfit/ui/utils/web.dart';
import 'package:totalfit/ui/widgets/auth/alternate_auth_widget.dart';
import 'package:totalfit/ui/widgets/auth/subtitle_widget.dart';
import 'package:totalfit/ui/widgets/auth/title_widget.dart';
import 'package:totalfit/ui/widgets/auth_type_selector.dart';
import 'package:totalfit/ui/widgets/base_checkbox_rounded_widget.dart';
import 'package:totalfit/ui/widgets/input_field_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TapGestureRecognizer _termsConditionsTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyPolicyTapRecognizer = TapGestureRecognizer();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  SignUpBloc _signUpBloc;

  @override
  void initState() {
    _signUpBloc = SignUpBloc(userRepository: DependencyProvider.get<UserRepository>());
    _emailNode.addListener(() {
      if (!_emailNode.hasFocus) {
        _signUpBloc.add(ValidateEmail());
      }
    });
    _passNode.addListener(() {
      if (!_passNode.hasFocus) {
        _signUpBloc.add(ValidatePassword());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passNode.dispose();
    _privacyPolicyTapRecognizer.dispose();
    _termsConditionsTapRecognizer.dispose();
    _signUpBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onWillChange: (oldVm, newVm) async {
          if (!oldVm.isUserLoggedIn && newVm.isUserLoggedIn) {
            if (newVm.user.wasOnboarded) {
              newVm.navigateToMainScreen();
            } else {
              newVm.navigateToOnboardingScreen();
            }
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Future<void> _handleError(Exception error) async {
    final attrs = TfDialogAttributes(description: error.toString(), positiveText: S.of(context).all__OK);
    await TfDialog.show(context, attrs);
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    vm.navigateToEntryScreen();
    return Future.sync(() => true);
  }

  Widget _buildContent(_ViewModel vm) => BlocProvider.value(
        value: _signUpBloc,
        child: Container(
          color: AppColorScheme.colorBlack,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: WillPopScope(
                  onWillPop: () => _onBackPressed(vm),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: BlocConsumer<SignUpBloc, SignUpLocalState>(
                          listener: (BuildContext context, SignUpLocalState state) {
                            if (state.formStatus == FormStatus.submissionSuccess &&
                                state.user is User &&
                                state.signUpType is SignUpType) {
                              _passController.clear();
                              _emailController.clear();
                              vm.onUserSignUpAction(state.user, state.signUpType, state.emailNotificationAllowed);
                            }

                            if (state.formStatus == FormStatus.submissionFailure) {
                              _handleError(state.error);
                            }
                          },
                          builder: (BuildContext context, SignUpLocalState state) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TitleWidget(
                                      title: S.of(context).sign_up_screen_title,
                                      padding: EdgeInsets.only(
                                        top: !isScreenSmall(MediaQuery.of(context).size) ? 32.0 : 24.0,
                                      ),
                                    ),
                                    SubTitleWidget(
                                      text: S.of(context).sign_up_screen_description,
                                      padding: EdgeInsets.only(
                                          bottom: !isScreenSmall(MediaQuery.of(context).size) ? 32.0 : 16.0),
                                    ),
                                    _emailInput(state),
                                    _passwordInput(state),
                                    _buildTermsAndPolicyWidget(state),
                                    _emailNotification(state),
                                    _signUpButton(state),
                                    // LinesWithText(
                                    //   text: S.of(context).sign_up_screen_sign_up_with,
                                    //   padding: EdgeInsets.only(bottom: 16),
                                    // ),
                                    AuthTypeSelector(
                                      googleBtnText: S.of(context).sign_up_with_google_btn,
                                      appleBtnText: S.of(context).sign_up_with_apple_btn,
                                      onGoogleTap: () {
                                        _signUpBloc.add(
                                          SignUpWithSocial(
                                            privacyAccepted: state.privacyAccepted,
                                            type: GoogleSignUp(),
                                          ),
                                        );
                                      },
                                      // onFacebookTap: () {
                                      //   _signUpBloc.add(
                                      //     SignUpWithSocial(
                                      //         privacyAccepted: state.privacyAccepted, type: FacebookSignUp()),
                                      //   );
                                      // },
                                      onAppleTap: () {
                                        _signUpBloc.add(
                                          SignUpWithSocial(privacyAccepted: state.privacyAccepted, type: AppleSignUp()),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 16.0),
                                    AlternateAuthWidget(
                                      text: S.of(context).sign_up_screen_already_have,
                                      actionText: S.of(context).sign_up_screen_btn_sign_in,
                                      onPressed: () => vm.onLogin(),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      _progressIndicator(vm)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _emailInput(SignUpLocalState state) => InputField(
        padding: EdgeInsets.only(bottom: !isScreenSmall(MediaQuery.of(context).size) ? 24.0 : 8.0),
        errorMessage: state.emailError,
        focusNode: _emailNode,
        nextFocusNode: _passNode,
        textEditingController: _emailController,
        onChanged: (email) => _signUpBloc.add(ChangeEmail(email)),
        onEditingCompleted: () => _signUpBloc.add(ValidateEmail()),
        onClearError: () {},
        label: S.of(context).sign_in_screen_input_email,
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(color: AppColorScheme.colorBlack7),
        keyboardType: TextInputType.emailAddress,
      );

  Widget _passwordInput(SignUpLocalState state) => InputField(
        padding: EdgeInsets.only(bottom: !isScreenSmall(MediaQuery.of(context).size) ? 24.0 : 16.0),
        errorMessage: state.passwordError,
        focusNode: _passNode,
        nextFocusNode: null,
        textEditingController: _passController,
        onClearError: () {},
        onChanged: (password) => _signUpBloc.add(ChangePassword(password)),
        onEditingCompleted: () {
          _signUpBloc.add(ValidatePassword());
          _passNode.unfocus();
        },
        label: S.of(context).sign_in_screen_input_password,
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(color: AppColorScheme.colorBlack7),
        obscureText: state.obscureText,
        keyboardType: TextInputType.visiblePassword,
        suffixIcon: IconButton(
          icon: Icon(
            state.obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColorScheme.colorBlack7,
          ),
          onPressed: () => _signUpBloc.add(ChangeObscureText(!state.obscureText)),
        ),
      );

  Widget _signUpButton(SignUpLocalState state) => Flexible(
        fit: FlexFit.loose,
        child: BaseElevatedButton(
            padding: EdgeInsets.only(bottom: 16.0),
            text: S.of(context).sign_up_screen_button,
            onPressed: () => _signUpBloc.add(
                  SubmitForm(
                    email: state.email,
                    password: state.password,
                    privacyAccepted: state.privacyAccepted,
                  ),
                )),
      );

  Widget _buildTermsAndPolicyWidget(SignUpLocalState state) {
    return SimpleTooltip(
      tooltipTap: () => _signUpBloc.add(ChangeShowTooltip(false)),
      animationDuration: Duration.zero,
      tooltipDirection: TooltipDirection.up,
      borderColor: Colors.transparent,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
      backgroundColor: AppColorScheme.colorBlack3,
      arrowTipDistance: 0.0,
      arrowLength: 12,
      minimumOutSidePadding: 0,
      ballonPadding: const EdgeInsets.all(8.0),
      content: Material(
        color: Colors.transparent,
        child: Text(
          S.of(context).sign_up_terms_agree,
          textAlign: TextAlign.left,
          style: textRegular12,
        ),
      ),
      show: state.showTooltip,
      child: _termsAndPolicy(state),
    );
  }

  Widget _termsAndPolicy(SignUpLocalState state) => Container(
        padding: EdgeInsets.only(bottom: !isScreenSmall(MediaQuery.of(context).size) ? 32.0 : 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BaseCheckBoxRoundedWidget(
              value: state.privacyAccepted,
              margin: const EdgeInsets.only(right: 12.0, top: 2.0),
              onChanged: (value) => _signUpBloc.add(
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
      );

  Widget _emailNotification(SignUpLocalState state) => Container(
        padding: EdgeInsets.only(bottom: !isScreenSmall(MediaQuery.of(context).size) ? 32.0 : 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BaseCheckBoxRoundedWidget(
              value: state.emailNotificationAllowed,
              margin: const EdgeInsets.only(right: 12.0, top: 2.0),
              onChanged: (value) => _signUpBloc.add(
                ChangeEmailNotificationAllowance(value),
              ),
            ),
            Expanded(
                child: Text(S.of(context).sign_up_email_allowance,
                    style: textRegular16.copyWith(color: AppColorScheme.colorBlack9))),
          ],
        ),
      );

  _progressIndicator(_ViewModel vm) {
    return BlocBuilder<SignUpBloc, SignUpLocalState>(
      builder: (BuildContext context, SignUpLocalState state) {
        return Visibility(
            child: DimmedCircularLoadingIndicator(),
            visible: state.formStatus == FormStatus.submissionInProgress, //vm.isLoading,
            replacement: SizedBox.shrink());
      },
    );
  }
}

class _ViewModel {
  final Function navigateToOnboardingScreen;
  final Function navigateToMainScreen;
  final Function navigateToEntryScreen;
  final Function(User user, SignUpType type, bool emailNotificationAllowed) onUserSignUpAction;
  final bool isUserLoggedIn;
  final User user;
  final VoidCallback onLogin;

  _ViewModel(
      {@required this.onLogin,
      @required this.isUserLoggedIn,
      @required this.navigateToOnboardingScreen,
      @required this.navigateToMainScreen,
      @required this.navigateToEntryScreen,
      @required this.user,
      @required this.onUserSignUpAction});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        navigateToOnboardingScreen: () => store.dispatch(NavigateToOnboardingScreenAction()),
        navigateToMainScreen: () => store.dispatch(NavigateToMainScreenAction()),
        navigateToEntryScreen: () => store.dispatch(NavigateToEntryScreenAction()),
        isUserLoggedIn: store.state.signUpState.isLoggedIn(),
        user: store.state.signUpState.user,
        onUserSignUpAction: (User user, SignUpType type, bool emailNotificationAllowed) =>
            store.dispatch(OnUserSignUpAction(
              user,
              type,
              emailSubscription: emailNotificationAllowed,
            )),
        onLogin: () => store.dispatch(NavigateToLoginAction()));
  }
}
