import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/domain/bloc/login_bloc/sign_in_bloc.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/log_in_type.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/form.dart';
import 'package:totalfit/ui/utils/screen_size.dart';
import 'package:totalfit/ui/widgets/auth/alternate_auth_widget.dart';
import 'package:totalfit/ui/widgets/auth/subtitle_widget.dart';
import 'package:totalfit/ui/widgets/auth/title_widget.dart';
import 'package:totalfit/ui/widgets/auth_type_selector.dart';
import 'package:totalfit/ui/widgets/input_field_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class LoginScreen extends StatefulWidget {
  final LoginLauncher launcher;

  LoginScreen({@required this.launcher});

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginLauncher { SPLASH, LOGOUT }

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  SignInBloc _signInBloc;

  @override
  void initState() {
    _signInBloc =
        SignInBloc(userRepository: DependencyProvider.get<UserRepository>());
    _emailNode.addListener(() {
      if (!_emailNode.hasFocus) {
        _signInBloc.add(ValidateEmail());
      }
    });
    _passNode.addListener(() {
      if (!_passNode.hasFocus) {
        _signInBloc.add(ValidatePassword());
      }
    });
    super.initState();
  }

  Future<void> _handleError(TfException error) async {
    final attrs = TfDialogAttributes(
      description: error.getMessage(context),
      positiveText: S.of(context).all__OK,
    );
    await TfDialog.show(context, attrs);
  }

  @override
  void dispose() {
    _signInBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        onWillChange: (oldVm, newVm) async {
          if (!oldVm.isUserLoggedIn && newVm.isUserLoggedIn) {
            if (newVm.user.wasOnboarded) {
              newVm.navigateToMainScreen();
            } else {
              newVm.navigateToOnboarding();
            }
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => BlocProvider.value(
        value: _signInBloc,
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
                      Column(
                        children: [
                          BlocConsumer<SignInBloc, SignInLocalState>(listener:
                              (BuildContext context, SignInLocalState state) {
                            if (state.formStatus ==
                                    FormStatus.submissionSuccess &&
                                state.user is User &&
                                state.signInSocialType is LoginType) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _passController.clear();
                              _emailController.clear();
                              vm.onUserLoginAction(
                                  state.user, state.signInSocialType);
                            }

                            if (state.formStatus ==
                                FormStatus.submissionFailure) {
                              _handleError(state.error);
                            }
                          }, builder:
                              (BuildContext context, SignInLocalState state) {
                            return Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TitleWidget(
                                        title:
                                            S.of(context).sign_in_screen_title,
                                        padding: EdgeInsets.only(
                                            top: !isScreenSmall(
                                                    MediaQuery.of(context).size)
                                                ? 48.0
                                                : 16.0),
                                      ),
                                      SubTitleWidget(
                                        text: S
                                            .of(context)
                                            .sign_in_screen_description,
                                        padding: EdgeInsets.only(
                                          bottom: !isScreenSmall(
                                                  MediaQuery.of(context).size)
                                              ? 32.0
                                              : 20.0,
                                        ),
                                      ),
                                      _emailInput(state),
                                      _passwordInput(state),
                                      _forgotPassword(state, vm),
                                      _logInButton(state),
                                      AuthTypeSelector(
                                        googleBtnText: S
                                            .of(context)
                                            .sign_in_with_google_btn,
                                        appleBtnText: S
                                            .of(context)
                                            .sign_in_with_apple_btn,
                                        onGoogleTap: () {
                                          _signInBloc.add(
                                            SignInWithSocial(
                                              type: GoogleLogIn(),
                                            ),
                                          );
                                        },
                                        onAppleTap: () {
                                          _signInBloc.add(
                                            SignInWithSocial(
                                              type: AppleLogIn(),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      AlternateAuthWidget(
                                        text: S
                                            .of(context)
                                            .sign_in_screen_alt_auth_title,
                                        actionText: S
                                            .of(context)
                                            .sign_in_screen_alt_auth_action,
                                        onPressed: () => vm.navigateToSignUp(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      _progressIndicator()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _forgotPassword(SignInLocalState state, _ViewModel vm) => Padding(
        padding: EdgeInsets.only(
          bottom: !isScreenSmall(MediaQuery.of(context).size) ? 40.0 : 28.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text(
                S.of(context).sign_in_screen_forgot_password,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorYellow,
                ),
                textAlign: TextAlign.end,
              ),
              onTap: () => vm.navigateToResetPassword(),
            ),
          ],
        ),
      );

  Future<bool> _onBackPressed(_ViewModel vm) {
    vm.navigateToEntryScreen();
    return Future.sync(() => widget.launcher == LoginLauncher.LOGOUT);
  }

  Widget _emailInput(SignInLocalState state) => InputField(
        padding: const EdgeInsets.only(bottom: 24.0),
        errorMessage: state.emailError,
        focusNode: _emailNode,
        nextFocusNode: _passNode,
        textEditingController: _emailController,
        onChanged: (email) => _signInBloc.add(ChangeEmail(email)),
        onEditingCompleted: () => _signInBloc.add(ValidateEmail()),
        onClearError: () {},
        label: S.of(context).sign_in_screen_input_email,
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(
          color: AppColorScheme.colorBlack7,
        ),
        keyboardType: TextInputType.emailAddress,
      );

  Widget _passwordInput(SignInLocalState state) => InputField(
        padding: EdgeInsets.only(
          bottom: !isScreenSmall(MediaQuery.of(context).size) ? 24.0 : 20.0,
        ),
        errorMessage: state.passwordError,
        focusNode: _passNode,
        nextFocusNode: null,
        textEditingController: _passController,
        onClearError: () {},
        label: S.of(context).sign_in_screen_input_password,
        dynamicLabel: true,
        labelStyle: textRegular16.copyWith(
          color: AppColorScheme.colorBlack7,
        ),
        onChanged: (password) => _signInBloc.add(ChangePassword(password)),
        onEditingCompleted: () {
          _signInBloc.add(ValidatePassword());
          _passNode.unfocus();
        },
        obscureText: state.obscureText,
        keyboardType: TextInputType.visiblePassword,
        suffixIcon: IconButton(
          icon: Icon(
            state.obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColorScheme.colorBlack7,
          ),
          onPressed: () =>
              _signInBloc.add(ChangeObscureText(!state.obscureText)),
        ),
      );

  Widget _logInButton(SignInLocalState state) => Flexible(
        fit: FlexFit.loose,
        child: BaseElevatedButton(
          padding: EdgeInsets.only(
            bottom: !isScreenSmall(MediaQuery.of(context).size) ? 40.0 : 28.0,
          ),
          text: S.of(context).sign_in_screen_button,
          onPressed: () => _signInBloc
              .add(SubmitForm(email: state.email, password: state.password)),
        ),
      );

  _progressIndicator() {
    return BlocBuilder<SignInBloc, SignInLocalState>(
      builder: (BuildContext context, SignInLocalState state) {
        return Visibility(
          child: DimmedCircularLoadingIndicator(),
          visible: state.formStatus == FormStatus.submissionInProgress,
          replacement: SizedBox.shrink(),
        );
      },
    );
  }
}

class _ViewModel {
  final Function navigateToSignUp;
  final Function navigateToResetPassword;
  final Function navigateToEntryScreen;
  final Function navigateToMainScreen;
  final Function onUserLoginAction;
  final Function navigateToOnboarding;
  final User user;
  final bool isUserLoggedIn;
  final Function navigateToSplash;

  _ViewModel(
      {@required this.navigateToSignUp,
      @required this.navigateToResetPassword,
      @required this.navigateToEntryScreen,
      @required this.navigateToMainScreen,
      @required this.isUserLoggedIn,
      @required this.navigateToOnboarding,
      @required this.user,
      @required this.onUserLoginAction,
      @required this.navigateToSplash});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        isUserLoggedIn: store.state.loginState.isLoggedIn(),
        user: store.state.loginState.user,
        navigateToSignUp: () => store.dispatch(NavigateToSignUpAction()),
        navigateToEntryScreen: () =>
            store.dispatch(NavigateToEntryScreenAction()),
        navigateToMainScreen: () =>
            store.dispatch(NavigateToMainScreenAction()),
        navigateToResetPassword: () =>
            store.dispatch(NavigateToResetPasswordAction(deepLink: null)),
        navigateToOnboarding: () =>
            store.dispatch(NavigateToOnboardingScreenAction()),
        onUserLoginAction: (User user, LoginType type) =>
            store.dispatch(OnUserLoginAction(user, type)),
        navigateToSplash: () =>
            store.dispatch(NavigateBackToSplashScreenAction()));
  }
}
