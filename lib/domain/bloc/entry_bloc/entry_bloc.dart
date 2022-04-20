import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/domain/sign_up_request_runner.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/sign_up_type.dart';
import 'package:totalfit/ui/utils/form.dart';

part 'entry_event.dart';

part 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final UserRepository userRepository;

  EntryBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(EntryState.initial());

  @override
  Stream<EntryState> mapEventToState(
    EntryEvent event,
  ) async* {
    if (event is ChangePrivacyChecked) {
      yield state.copyWith(privacyChecked: event.checked, showTooltip: event.checked ? false : state.showTooltip);
    }
    if (event is ChangeEmailNotificationAllowance) {
      yield state.copyWith(
          emailNotificationAllowed: event.checked, showTooltip: event.checked ? false : state.showTooltip);
    } else if (event is ChangeShowTooltip) {
      yield state.copyWith(showTooltip: event.value);
    } else if (event is SignUpWithSocial) {
      if (state.privacyChecked) {
        yield state.copyWith(formStatus: FormStatus.submissionInProgress);
        try {
          final user = await SignUpRequestRunner(event.type, userRepository).signUp();
          if (user != null) {
            if (user.wasOnboarded) {
              await userRepository.insertUser(user);
            }
            yield state.copyWith(formStatus: FormStatus.submissionSuccess, user: user, type: event.type);
          } else {
            final error = TfException(ErrorCode.ERROR_AUTH_SOCIAL_FAILED, '');
            yield state.copyWith(formStatus: FormStatus.submissionFailure, error: error);
          }
        } on TfException catch (e) {
          if(e.errorCode != ErrorCode.ERROR_AUTH_CANCELED) {
            yield state.copyWith(formStatus: FormStatus.submissionFailure, error: e);
          }
        } catch (e) {
          final error = TfException(ErrorCode.ERROR_AUTH_FAILED, '$e');
          yield state.copyWith(formStatus: FormStatus.submissionFailure, error: error);
        }
        yield state.copyWith(formStatus: FormStatus.pure, error: null);
      } else {
        yield state.copyWith(showTooltip: true);
      }
    }
  }
}
