part of 'mood_bloc.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();
}

class FetchMoodData extends MoodEvent {
  @override
  List<Object?> get props => [];
}

class ChangeFeelingsGroupId extends MoodEvent {
  final MoodState moodState;
  final int id;

  const ChangeFeelingsGroupId({required this.id, required this.moodState});

  @override
  List<Object?> get props => [id, moodState];
}

class ChangeFeelingId extends MoodEvent {
  final MoodState moodState;
  final int id;

  const ChangeFeelingId({required this.id, required this.moodState});

  @override
  List<Object?> get props => [id, moodState];
}

class ChangeMoodReasonsIds extends MoodEvent {
  final MoodState moodState;
  final List<int>? ids;

  const ChangeMoodReasonsIds({required this.ids, required this.moodState});

  @override
  List<Object?> get props => [ids, moodState];
}

class ChangeReason extends MoodEvent {
  final int id;
  final MoodState moodState;

  const ChangeReason({required this.id, required this.moodState});

  @override
  List<Object?> get props => [id, moodState];
}