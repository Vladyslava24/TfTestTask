part of 'edit_program_bloc.dart';

abstract class EditProgramEvent extends Equatable {
  const EditProgramEvent();
}

class QuitProgramAction extends EditProgramEvent {
  @override
  List<Object> get props => [];
}