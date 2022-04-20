part of 'mood_bloc.dart';

class MoodState extends Equatable {

  final MoodDataUI? moodData;
  final MoodLoadingStatus statusMoodData;
  final String? error;

  final int? feelingsGroupId;
  final int? feelingId;
  final List<int>? moodReasonsIds;

  final SendStatus sendStatus;
  final String? sendError;
  final MoodResponse? moodResponse;

  const MoodState._({
    this.moodData,
    this.statusMoodData = MoodLoadingStatus.idle,
    this.error,
    this.feelingId,
    this.feelingsGroupId,
    this.moodReasonsIds,
    this.sendStatus = SendStatus.idle,
    this.sendError,
    this.moodResponse
  });

  factory MoodState.initial() => const MoodState._();

  factory MoodState.loading() =>
    const MoodState._(statusMoodData: MoodLoadingStatus.loading);

  factory MoodState.sendLoading() =>
    const MoodState._(sendStatus: SendStatus.sending);

  factory MoodState.loaded(MoodDataUI data) =>
    MoodState._(statusMoodData: MoodLoadingStatus.loaded, moodData: data);

  factory MoodState.changeFeelingsGroupId(int id, MoodState moodState) =>
    MoodState._(
      feelingsGroupId: id,
      statusMoodData: moodState.statusMoodData,
      moodData: moodState.moodData
    );

  factory MoodState.changeFeelingId(int id, MoodState moodState) =>
    MoodState._(
      feelingsGroupId: moodState.feelingsGroupId,
      statusMoodData: moodState.statusMoodData,
      moodData: moodState.moodData,
      feelingId: id
    );

  factory MoodState.changeMoodReasonsIds(List<int>? ids, MoodState moodState) =>
    MoodState._(
      feelingsGroupId: moodState.feelingsGroupId,
      statusMoodData: moodState.statusMoodData,
      moodData: moodState.moodData,
      feelingId: moodState.feelingId,
      moodReasonsIds: ids
    );

  factory MoodState.changeReason(int id, MoodState moodState) {
    final moodData = MoodDataUI(
      feelingsGroups: moodState.moodData!.feelingsGroups,
      reasons: moodState.moodData!.reasons,
    );
    moodData.reasons.map((e) {
    if (e.id == id) return e.selected = !e.selected;
    return e;
    }).toList();
    return MoodState._(
      feelingsGroupId: moodState.feelingsGroupId,
      statusMoodData: moodState.statusMoodData,
      moodData: moodData,
      feelingId: moodState.feelingId,
      moodReasonsIds: moodState.moodReasonsIds
    );
  }

  factory MoodState.error(e) =>
    MoodState._(error: e, statusMoodData: MoodLoadingStatus.notLoaded);

  factory MoodState.sendSuccessfully(MoodResponse response) => MoodState._(
    sendStatus: SendStatus.success,
    moodResponse: response
  );

  factory MoodState.sendUnsuccessfully(String error, List<int> ids, MoodState state) =>
    MoodState._(
      sendStatus: SendStatus.failure,
      sendError: error,
      moodReasonsIds: ids,
      feelingsGroupId: state.feelingsGroupId,
      statusMoodData: state.statusMoodData,
      moodData: state.moodData,
      feelingId: state.feelingId,
    );

  @override
  List<Object?> get props =>
    [moodData, statusMoodData, error, feelingsGroupId, feelingId,
     moodReasonsIds, sendStatus, sendError];
}

enum MoodLoadingStatus { loading, loaded, notLoaded, idle }
enum SendStatus { sending, success, failure, idle }
