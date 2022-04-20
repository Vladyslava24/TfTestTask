import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:mood_ui/src/model/feeling_group_ui.dart';
import 'package:mood_ui/src/model/feeling_item_ui.dart';
import 'package:mood_ui/src/model/mood_data_ui.dart';
import 'package:mood_ui/src/model/mood_response_ui.dart';
import 'package:mood_usecase/model/feeling_group.dart';
import 'package:mood_usecase/model/feeling_item.dart';
import 'package:mood_usecase/mood_usecase.dart';
import 'package:mood_usecase/model/request/send_mood_data_usecase_request.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final MoodUseCase moodUseCase;

  MoodBloc({required this.moodUseCase}) : super(MoodState.initial()) {
    on<FetchMoodData>(_fetchMoodData);
    on<ChangeFeelingsGroupId>(_changeFeelingsGroupId);
    on<ChangeFeelingId>(_changeFeelingId);
    on<ChangeMoodReasonsIds>(_changeMoodReasonsIds);
    on<ChangeReason>(_changeReason);
  }

  void _changeReason(ChangeReason event, Emitter<MoodState> emit) =>
    emit(MoodState.changeReason(event.id, event.moodState));

  Future<void> _changeMoodReasonsIds(ChangeMoodReasonsIds event, Emitter<MoodState> emit) async {
    final ids = event.ids;
    final moodState = event.moodState;

    emit(MoodState.changeMoodReasonsIds(ids, moodState));

    emit(MoodState.sendLoading());

    try {
      final result = await moodUseCase.sendMoodData(
        SendMoodDataUseCaseRequest(
          moodReasonsIds: ids!,
          feelingId: moodState.feelingId!,
          feelingsGroupId: moodState.feelingsGroupId!
        )
      );

      emit(MoodState.sendSuccessfully(
        MoodResponse(
          feelingName: result.feelingName,
          emoji: result.emoji,
          time: result.time
      )));
    } on ApiException catch (e) {
      print(e);
      emit(MoodState.sendUnsuccessfully(e.toString(), ids!, moodState));
    }
  }

  void _changeFeelingId(ChangeFeelingId event, Emitter<MoodState> emit) =>
    emit(MoodState.changeFeelingId(event.id, event.moodState));

  void _changeFeelingsGroupId(ChangeFeelingsGroupId event, Emitter<MoodState> emit) =>
    emit(MoodState.changeFeelingsGroupId(event.id, event.moodState));

  Future<void> _fetchMoodData(FetchMoodData event, Emitter<MoodState> emit) async {
    emit(MoodState.loading());
    try {
      final moodResponse = await moodUseCase.fetchMoodData();
      final moodDataUI = MoodDataUI(
        feelingsGroups: List<FeelingGroupUI>.of(
          moodResponse.feelingsGroups.map((e) {
          return FeelingGroupUI(
            id: e.id,
            name: e.name,
            color: e.color,
            image: e.image,
            feelings: List<FeelingItemUI>.of(e.feelings.map((i) =>
              FeelingItemUI(
                id: i.id,
                name: i.name,
                emoji: i.emoji
            )))
          );
        })),
        reasons: List<FeelingItemUI>.of(moodResponse.reasons.map((e) =>
            FeelingItemUI(
              id: e.id,
              name: e.name,
              emoji: e.emoji
            ),
          ),
        ),
      );
      emit(MoodState.loaded(moodDataUI));
    } on ApiException catch (e) {
      emit(MoodState.error('${e.serverErrorCode} - ${e.message}'));
    }
  }
}
