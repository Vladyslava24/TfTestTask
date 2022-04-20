
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:totalfit/data/dto/onboarding_info_dto.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:rxdart/rxdart.dart';

class CreatePlanBloc extends Bloc<dynamic, CreatePlanBlocEvent> {
  final RemoteStorage _remoteStorage = DependencyProvider.get<RemoteStorage>();
  final UserRepository _userRepository = DependencyProvider.get<UserRepository>();

  CreatePlanBloc() : super(null);

  @override
  Stream<Transition<dynamic, CreatePlanBlocEvent>> transformEvents(
      Stream<dynamic> events,
      TransitionFunction<dynamic, CreatePlanBlocEvent> transitionFn) {
    return events.switchMap(transitionFn);
  }

  @override
  Stream<CreatePlanBlocEvent> mapEventToState(dynamic event) async* {
    if (event is CreatePlanAction) {
      try {
        await _remoteStorage.updateProfile(event.updateProfileRequest);
        final updatedUser = event.currentUser.copyWith(
          height: event.updateProfileRequest.height.toString(),
          weight: event.updateProfileRequest.weight.toString(),
          birthday: event.updateProfileRequest.birthday,
          gender: Gender.fromString(event.updateProfileRequest.gender),
          firstName: event.updateProfileRequest.firstName,
        );
        await _userRepository.insertUser(updatedUser);
        await _remoteStorage.addOnboardingInformation(event.onboardingInfo);
        final programResponse = await _remoteStorage.getBestMatchProgram(
            event.weekCount, event.level, event.equipment);
        yield OnPlanCreatedAction(programResponse, updatedUser);
      } catch (e) {
        print("FAILED Create Plan: $e");
        TfException error;
        if (e is! TfException) {
          error = TfException(ErrorCode.ERROR_UNKNOWN, e.toString());
        } else {
          error = e;
        }
        yield Error(error);
      }
    }
    if (event is CancelRequestByTimeoutAction) {
      yield Error(TfException(ErrorCode.ERROR_TIMEOUT, null));
    }
  }
}

abstract class CreatePlanBlocEvent {
  @override
  String toString() => runtimeType.toString();
}

class OnPlanCreatedAction extends CreatePlanBlocEvent {
  final FeedProgramItemResponse programResponse;
  final User updatedUser;

  OnPlanCreatedAction(this.programResponse, this.updatedUser);
}

class Error extends CreatePlanBlocEvent {
  final TfException exception;

  Error(this.exception);
}

class CancelRequestByTimeoutAction {}

class CreatePlanAction {
  final UpdateProfileRequest updateProfileRequest;
  final User currentUser;
  final int weekCount;
  final String level;
  final List<String> equipment;
  final OnboardingInfoDto onboardingInfo;

  CreatePlanAction({
    @required this.updateProfileRequest,
    @required this.weekCount,
    @required this.currentUser,
    @required this.level,
    @required this.equipment,
    @required this.onboardingInfo,
  });
}
