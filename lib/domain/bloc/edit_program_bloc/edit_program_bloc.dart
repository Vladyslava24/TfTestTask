import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';

part 'edit_program_event.dart';
part 'edit_program_state.dart';

class EditProgramBloc extends Bloc<EditProgramEvent, EditProgramState> {
  final RemoteStorage remoteStorage;

  EditProgramBloc({ @required this.remoteStorage }) :
    super(EditProgramState.initial());

  @override
  Stream<EditProgramState> mapEventToState(
    EditProgramEvent event,
  ) async* {
    if (event is QuitProgramAction) {
      print('event');
      yield EditProgramState.loading();
      try {
        final code = await remoteStorage.interruptProgram();
        if (code == 200) {
          yield EditProgramState.done();
        }
      } on FormatException catch (e) {
        print('in bloc FormatException $e');
        yield EditProgramState.error(TfException(ErrorCode.ERROR_PROGRAM_NOT_RUNNING, e.message));
      } on ApiException catch (e) {
        print('in bloc ApiException $e');
        if (e.serverErrorCode == 409) {
          yield EditProgramState.error(TfException(ErrorCode.ERROR_PROGRAM_NOT_RUNNING, e.serverErrorMessage));
        }
        yield EditProgramState.error(TfException(ErrorCode.ERROR_INTERRUPT_PROGRAM, e.serverErrorMessage));
      } on TfException catch (e) {
        print('in bloc TfException $e');
        yield EditProgramState.error(TfException(e.errorCode, e.message));
      } catch (e) {
        print('in bloc $e');
        yield EditProgramState.error(
          TfException(ErrorCode.ERROR_INTERRUPT_PROGRAM, e.toString()));
      }
    }
  }
}
