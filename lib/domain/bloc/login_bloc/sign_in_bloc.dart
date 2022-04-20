import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/domain/login_request_runner.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/log_in_type.dart';
import 'package:totalfit/ui/utils/errors.dart';
import 'package:totalfit/ui/utils/form.dart';
import 'package:totalfit/ui/utils/mixins/validation.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInLocalState>
    with ValidationMixin {
  final UserRepository userRepository;

  SignInBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(SignInLocalState.initial());

  @override
  Stream<SignInLocalState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is ChangeEmail) {
      yield state.copyWith(email: event.value.trim(), emailError: '');
    } else if (event is ValidateEmail) {
      yield state.copyWith(
          email: state.email,
          emailError: !this.isValidEmailAddress(state.email)
              ? generateErrorText(FieldError.InvalidEmail)
              : '');
    } else if (event is ChangePassword) {
      yield state.copyWith(password: event.value.trim(), passwordError: '');
    } else if (event is ValidatePassword) {
      yield state.copyWith(
          password: state.password,
          passwordError: this.isHasEnoughLength(state.password)
              ? generateErrorText(FieldError.InvalidPassword)
              : '');
    } else if (event is ChangeObscureText) {
      yield state.copyWith(obscureText: event.value);
    } else if (event is SubmitForm) {
      yield state.copyWith(formStatus: FormStatus.pure);
      final emailError = !this.isValidEmailAddress(event.email)
          ? generateErrorText(FieldError.InvalidEmail)
          : '';
      final passwordError = this.isHasEnoughLength(event.password)
          ? generateErrorText(FieldError.InvalidPassword)
          : '';

      if (emailError.isNotEmpty || passwordError.isNotEmpty) {
        yield state.copyWith(
            emailError: emailError, passwordError: passwordError);
      } else {
        yield state.copyWith(formStatus: FormStatus.submissionInProgress);
        final request =
            LogInRequest(email: state.email, password: state.password);
        try {
          final user =
              await LoginRequestRunner(request, userRepository).login();

          if (user.wasOnboarded) {
            await userRepository.insertUser(user);
          }
          yield state.copyWith(
              formStatus: FormStatus.submissionSuccess,
              signInSocialType: request,
              user: user);
        } on TfException catch (e) {
          if (e.errorCode != ErrorCode.ERROR_AUTH_CANCELED) {
            yield state.copyWith(
                formStatus: FormStatus.submissionFailure, error: e);
          }
        } catch (e) {
          final error = TfException(ErrorCode.ERROR_AUTH_FAILED, '$e');
          yield state.copyWith(
              formStatus: FormStatus.submissionFailure, error: error);
        }
        yield state.copyWith(error: null, formStatus: FormStatus.pure);
      }
    } else if (event is SignInWithSocial) {
      yield state.copyWith(formStatus: FormStatus.submissionInProgress);
      try {
        final user =
            await LoginRequestRunner(event.type, userRepository).login();
        await userRepository.insertUser(user);
        yield state.copyWith(
            formStatus: FormStatus.submissionSuccess,
            user: user,
            signInSocialType: event.type);
      } on TfException catch (e) {
        if (e.errorCode != ErrorCode.ERROR_AUTH_CANCELED) {
          yield state.copyWith(
              formStatus: FormStatus.submissionFailure, error: e);
        }
      } catch (e) {
        final error = TfException(ErrorCode.ERROR_AUTH_FAILED, '$e');
        yield state.copyWith(
            formStatus: FormStatus.submissionFailure, error: error);
      }
      yield state.copyWith(error: null, formStatus: FormStatus.pure);
    }
  }
}
