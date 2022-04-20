import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/sign_up_type.dart';
import 'package:totalfit/ui/utils/errors.dart';
import 'package:totalfit/ui/utils/form.dart';
import 'package:totalfit/ui/utils/mixins/validation.dart';

import '../../sign_up_request_runner.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpLocalState> with ValidationMixin {
  final UserRepository userRepository;

  SignUpBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(SignUpLocalState.initial());

  @override
  Stream<SignUpLocalState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is ChangePrivacyChecked) {
      yield state.copyWith(privacyAccepted: event.value, showTooltip: event.value ? false : state.showTooltip);
    }
    if (event is ChangeEmailNotificationAllowance) {
      yield state.copyWith(emailNotificationAllowed: event.value, showTooltip: event.value ? false : state.showTooltip);
    } else if (event is ChangeEmail) {
      yield state.copyWith(email: event.value.trim(), emailError: '');
    } else if (event is ValidateEmail) {
      yield state.copyWith(
          email: state.email,
          emailError: !this.isValidEmailAddress(state.email) ? generateErrorText(FieldError.InvalidEmail) : '');
    } else if (event is ChangePassword) {
      yield state.copyWith(password: event.value.trim(), passwordError: '');
    } else if (event is ValidatePassword) {
      yield state.copyWith(
          password: state.password,
          passwordError: this.isHasEnoughLength(state.password) ? generateErrorText(FieldError.InvalidPassword) : '');
    } else if (event is ChangeObscureText) {
      yield state.copyWith(obscureText: event.value);
    } else if (event is ChangeShowTooltip) {
      yield state.copyWith(showTooltip: event.value);
    } else if (event is SubmitForm) {
      yield state.copyWith(formStatus: FormStatus.pure);

      final emailError = !this.isValidEmailAddress(event.email) ? generateErrorText(FieldError.InvalidEmail) : '';
      final passwordError = this.isHasEnoughLength(event.password) ? generateErrorText(FieldError.InvalidPassword) : '';
      final showTooltip = !event.privacyAccepted ? true : false;

      if (!event.privacyAccepted || (emailError.isNotEmpty || passwordError.isNotEmpty)) {
        yield state.copyWith(showTooltip: showTooltip, emailError: emailError, passwordError: passwordError);
      } else {
        yield state.copyWith(formStatus: FormStatus.submissionInProgress);
        final request = SignUpRequest(state.emailNotificationAllowed,
            lastName: '', email: state.email, birthday: '', password: state.password, confirmPassword: '');
        try {
          final user = await SignUpRequestRunner(request, userRepository).signUp();

          if (user.wasOnboarded) {
            await userRepository.insertUser(user);
          }
          yield state.copyWith(
              showTooltip: false,
              privacyAccepted: false,
              emailError: '',
              passwordError: '',
              password: '',
              email: '',
              user: user,
              formStatus: FormStatus.submissionSuccess,
              signUpType: request);
        } catch (e) {
          yield state.copyWith(formStatus: FormStatus.submissionFailure, error: e);
        }
        yield state.copyWith(formStatus: FormStatus.pure, error: null);
      }
    } else if (event is SignUpWithSocial) {
      yield state.copyWith(formStatus: FormStatus.pure);
      if (!event.privacyAccepted) {
        yield state.copyWith(showTooltip: true);
      } else {
        yield state.copyWith(formStatus: FormStatus.submissionInProgress);
        try {
          final user = await SignUpRequestRunner(event.type, userRepository).signUp();
          if (user != null) {
            yield state.copyWith(formStatus: FormStatus.submissionSuccess, user: user, signUpType: event.type);
          } else {
            final error = TfException(ErrorCode.ERROR_AUTH_SOCIAL_FAILED, '');
            yield state.copyWith(formStatus: FormStatus.submissionFailure, error: error);
          }
        } on TfException catch (e) {
          yield state.copyWith(formStatus: FormStatus.submissionFailure, error: e);
        } catch (e) {
          final error = TfException(ErrorCode.ERROR_AUTH_FAILED, '$e');
          yield state.copyWith(formStatus: FormStatus.submissionFailure, error: error);
        }
        yield state.copyWith(formStatus: FormStatus.pure, error: null);
      }
    }
  }
}
