part of 'edit_program_bloc.dart';

@immutable
class EditProgramState extends Equatable {
  final bool isLoading;
  final TfException exception;
  final InterruptStatus status;

  const EditProgramState._({
    this.isLoading,
    this.exception,
    this.status
  });

  EditProgramState copyWith({
    bool isLoading,
    TfException exception,
    InterruptStatus status
  }) {
    return EditProgramState._(
      isLoading: isLoading ?? this.isLoading,
      exception: this.exception,
      status: status ?? this.status
    );
  }

  factory EditProgramState.initial() => EditProgramState._(
    isLoading: false,
    exception: null,
    status: InterruptStatus.unknown
  );

  factory EditProgramState.loading() => EditProgramState._(
    isLoading: true,
    exception: null
  );

  factory EditProgramState.done() => EditProgramState._(
    isLoading: false,
    exception: null,
    status: InterruptStatus.done
  );

  factory EditProgramState.error(TfException e) => EditProgramState._(
    isLoading: false,
    exception: e,
    status: InterruptStatus.unknown
  );

  @override
  List<Object> get props => [isLoading, exception, status];
}

enum InterruptStatus { unknown, done }