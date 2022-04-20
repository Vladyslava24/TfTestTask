void main() {

}
// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:io';
// import 'package:logging/logging.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:redux/redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:core/core.dart';
// import 'package:totalfit/data/answered_question_dto.dart';
// import 'package:totalfit/data/dto/request/update_progress_request.dart';
// import 'package:totalfit/data/dto/response/progress_response.dart';
// import 'package:totalfit/data/dto/response/workout_response.dart';
// import 'package:totalfit/data/dto/workout_dto.dart';
// import 'package:totalfit/data/dto/workout_progress_dto.dart';
// import 'package:totalfit/data/hexagon_state.dart';
// import 'package:totalfit/data/source/local/local_storage.dart';
// import 'package:totalfit/data/source/remote/remote_storage.dart';
// import 'package:totalfit/data/source/repository/user_repository.dart';
// import 'package:totalfit/domain/video_cache_service.dart';
// import 'package:totalfit/data/dto/enviromental_dto.dart';
// import 'package:totalfit/model/exercise_dto.dart';
// import 'package:totalfit/model/progress_page_model.dart';
// import 'package:totalfit/model/question.dart';
// import 'package:totalfit/data/dto/story_dto.dart';
// import 'package:totalfit/data/dto/wisdom_dto.dart';
// import 'package:totalfit/model/skill_summary/skill_summary_header_list_item.dart';
// import 'package:totalfit/model/skill_summary/skill_technique_rate_item.dart';
// import 'package:totalfit/model/skill_summary/skill_total_time_item.dart';
// import 'package:totalfit/model/wod_summary/exercise_list_item.dart';
// import 'package:totalfit/model/wod_summary/summary_header_list_item.dart';
// import 'package:totalfit/model/workout_page_type.dart';
// import 'package:totalfit/data/workout_stage_dto.dart';
// import 'package:totalfit/model/workout_summary/exercise_list_item.dart';
// import 'package:totalfit/model/workout_summary/mood_list_item.dart';
// import 'package:totalfit/model/workout_summary/question_list_item.dart';
// import 'package:totalfit/model/workout_summary/summary_header_list_item.dart';
// import 'package:totalfit/redux/actions/main_page_action.dart';
// import 'package:totalfit/redux/actions/progress_actions.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/middleware/progress_middleware.dart';
// import 'package:totalfit/redux/middleware/skill_middleware.dart';
// import 'package:totalfit/redux/middleware/storage_middleware.dart';
// import 'package:totalfit/redux/middleware/warm_up_middleware.dart';
// import 'package:totalfit/redux/middleware/wod_middleware.dart';
// import 'package:totalfit/redux/middleware/workout_middleware.dart';
// import 'package:totalfit/redux/reducers/app_reducers.dart';
// import 'package:totalfit/redux/selectors/progress_selectors.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/redux/states/warm_up_state.dart';
// import 'package:totalfit/redux/states/workout_phase.dart';
// import 'package:totalfit/ui/screen/main/workout/skill/summary/skill_summary_page.dart';
// import 'package:totalfit/ui/screen/main/workout/warmup/summary/warm_up_summary_page.dart';
// import 'package:totalfit/ui/screen/main/workout/wod/wod_summary_page.dart';
// import 'package:workout_data_legacy/data.dart';
//
// class MockLogger extends Mock implements Logger {}
//
// class MockPrefs extends Mock implements SharedPreferences {}
//
// class MockRemoteStorage extends Mock implements RemoteStorage {}
//
// class MockLocalStorage extends Mock implements LocalStorage {}
//
// bool workoutTestIsRunning = false;
//
// final testReducer =
//     combineReducers<AppState>([TypedReducer<AppState, SetAppStateAction>(_setAppStateReducer), appReducer]);
//
// class SetAppStateAction {
//   final AppState appState;
//
//   SetAppStateAction(this.appState);
// }
//
// AppState _setAppStateReducer(AppState state, SetAppStateAction action) => action.appState;
//
// void main() {
//   workoutTestIsRunning = true;
//   MockLogger mockLogger;
//   MockPrefs mockPrefs;
//   MockRemoteStorage mockRemoteStorage;
//   MockLocalStorage mockLocalStorage;
//
//   AppState lastState;
//   AppState appStateAfterWorkoutStarted;
//   AppState appStateAfterWarmupExercises;
//   AppState appStateAfterMoodSelected;
//   AppState appStateAfterQuestionsAnswering;
//   ProgressResponse warmUpProgressResponse;
//   Store<AppState> store;
//   WorkoutDto selectedWorkout;
//   //TODO: provide [UserRepository]
//   UserRepository userRepository;
//
//   StreamSubscription subscription;
//   final theme = 'ARKANSAS';
//
//   List<int> warmUpExerciseDurations;
//   final expectedSkillDurationResult = <Exercise, int>{};
//   final expectedWodDurationResult = <Exercise, int>{};
//   final expectedCooldownDurationResult = <Exercise, int>{};
//   final expectedMoodRate = 5;
//
//   final List<Answer> userAnswers = [
//     Answer(questionId: 1, answer: '5'),
//     Answer(questionId: 2, answer: 'answer to question: 2'),
//     Answer(questionId: 3, answer: 'answer to question: 3')
//   ];
//   final expectedTechniqueRate = 4;
//   final expectedEditedWodTime = 7007;
//
//   EnvironmentDto envDto;
//   StoryDto storyDto;
//   WisdomDto wisdomDto;
//
//   setUpAll(() async {
//     mockLogger = MockLogger();
//     when(mockLogger.info(any)).thenReturn(Void);
//
//     mockPrefs = MockPrefs();
//     when(mockPrefs.containsKey(any)).thenReturn(true);
//     when(mockPrefs.get(any)).thenReturn(null);
//
//     mockRemoteStorage = MockRemoteStorage();
//
//     mockLocalStorage = MockLocalStorage();
//
//     lastState = AppState.initial(mockPrefs, '');
//
//     final List<Middleware<AppState>> appMiddleware = [];
//     //TODO: provide [UserRepository]
//     appMiddleware.addAll(storageMiddleware(null, null, mockRemoteStorage, mockLogger));
//     appMiddleware.addAll(warmupMiddleware(mockRemoteStorage, mockLogger));
//     appMiddleware.addAll(skillMiddleware(mockRemoteStorage, mockLogger));
//     appMiddleware.addAll(wodMiddleware(mockRemoteStorage, mockLogger));
//     appMiddleware.addAll(progressMiddleware(mockLocalStorage, mockRemoteStorage, mockLogger));
//     store = Store<AppState>(testReducer, initialState: lastState, middleware: appMiddleware, syncStream: true);
//     subscription = store.onChange.listen((state) {
//       lastState = state;
//     });
//
//     final fileWorkoutResponse = new File('test/workout/workout_list.json');
//     final decodedWorkoutResponse = jsonDecode(await fileWorkoutResponse.readAsString());
//     final workoutResponse = WorkoutResponse.fromMap(decodedWorkoutResponse);
//     when(mockRemoteStorage.fetchWorkouts()).thenAnswer((_) async => workoutResponse);
//
//     final fileProgressResponse = new File('test/workout/update_progress_response_initial.json');
//     final decodedProgressResponse = jsonDecode(await fileProgressResponse.readAsString());
//     final progressResponse = ProgressResponse.fromMap(decodedProgressResponse);
//     when(mockRemoteStorage.getProgress(any)).thenAnswer((_) async => progressResponse);
//
//     envDto = progressResponse.environmental;
//     storyDto = progressResponse.story;
//     wisdomDto = progressResponse.wisdom;
//
//     store.dispatch(InitProgressAction());
//     await Future.delayed(Duration(milliseconds: 50), () {
//       selectedWorkout = store.state.mainPageState.workouts.firstWhere((w) => w.theme == theme);
//     });
//
//     ///////////////////////////////////// appStateAfterWorkoutStarted
//
//     List<Question> questions = [
//       Question(id: 1, order: 1, reward: 40, question: 'How are you feeling today?', questionType: 'RATE'),
//       Question(id: 2, order: 2, reward: 30, question: 'What are you thankful for?', questionType: 'TEXT'),
//       Question(id: 3, order: 3, reward: 30, question: 'What is stressing you out?', questionType: 'TEXT'),
//     ];
//
//     WarmUpState warmupStateAfterWorkoutStarted = WarmUpState(
//         exercisesDuration: _buildDurations(selectedWorkout.warmUp, [0, 0, 0, 0]),
//         warmUpRounds: 3,
//         questions: questions,
//         answers: {},
//         restDuration: 0,
//         errorMessage: "");
//     WorkoutState workoutStateAfterWorkoutStarted = WorkoutState(
//         workout: selectedWorkout,
//         warmUpState: warmupStateAfterWorkoutStarted,
//         currentPageType: WorkoutPageType.WARMUP,
//         downloadedExercisePercent: 0);
//     appStateAfterWorkoutStarted =
//         AppState(workoutState: workoutStateAfterWorkoutStarted, mainPageState: store.state.mainPageState);
//     /////////////////////////////////////////// appStateAfterWarmupExercises
//
//     int warmupRounds = selectedWorkout.warmUpRounds;
//     int warmupStageDuration = 0;
//     int stubDuration = 1000;
//     warmUpExerciseDurations = [];
//     selectedWorkout.warmUp.forEach((e) {
//       int d = stubDuration += 1000;
//       warmUpExerciseDurations.add(d);
//       warmupStageDuration += d;
//     });
//
//     WarmUpState warmupStateAfterWarmupExercises = warmupStateAfterWorkoutStarted.copyWith(
//         exercisesDuration: _buildDurations(selectedWorkout.warmUp, warmUpExerciseDurations, rounds: warmupRounds));
//     appStateAfterWarmupExercises = AppState(
//         workoutState: workoutStateAfterWorkoutStarted.copyWith(warmUpState: warmupStateAfterWarmupExercises),
//         mainPageState: appStateAfterWorkoutStarted.mainPageState);
//
//     /////////////////////////////////////////// appStateAfterMoodSelect
//
//     final answersWithSelectedMood = Set.of(warmupStateAfterWarmupExercises.answers);
//     answersWithSelectedMood.add(userAnswers[0]);
//     WarmUpState warmupStateAfterMoodSelect = warmupStateAfterWarmupExercises.copyWith(answers: answersWithSelectedMood);
//     WorkoutState previous0 = appStateAfterWarmupExercises.workoutState;
//     appStateAfterMoodSelected = AppState(
//         workoutState: previous0.copyWith(warmUpState: warmupStateAfterMoodSelect),
//         mainPageState: appStateAfterWarmupExercises.mainPageState);
//
//     ////////////////////////////////////////// appStateAfterAnsweringQuestions
//     final answers = Set.of(warmupStateAfterMoodSelect.answers);
//     answers.add(userAnswers[1]);
//     answers.add(userAnswers[2]);
//
//     WarmUpState warmupStateAfterQuestionsAnswering = warmupStateAfterMoodSelect.copyWith(answers: answers);
//     WorkoutState previous1 = appStateAfterMoodSelected.workoutState;
//
//     appStateAfterQuestionsAnswering = AppState(
//         workoutState: previous1.copyWith(warmUpState: warmupStateAfterQuestionsAnswering),
//         mainPageState: appStateAfterMoodSelected.mainPageState);
//
//     ///////////////////////////////////////////
//
//     WorkoutProgressDto workoutProgress = WorkoutProgressDto();
//     final answeredQuestions = <AnsweredQuestionDto>[];
//     int answeredQuestionId = 2170;
//     questions.forEach((q) {
//       final a0 = AnsweredQuestionDto();
//       Answer a = userAnswers.firstWhere((e) => e.questionId == q.id);
//       a0.id = (answeredQuestionId++).toString();
//       a0.answer = a.answer;
//       a0.question = q.question;
//       a0.questionId = q.id.toString();
//       answeredQuestions.add(a0);
//     });
//
//     workoutProgress.answeredQuestions = answeredQuestions;
//     workoutProgress.warmupExerciseDurations =
//         warmupStateAfterWarmupExercises.toExerciseDurationDto(WorkoutStage.WARMUP);
//     workoutProgress.workoutDuration = warmupStageDuration;
//     workoutProgress.warmupStageDuration = warmupStageDuration;
//     workoutProgress.skillTechniqueRate = expectedTechniqueRate;
//     workoutProgress.workoutPhase = WorkoutStage.WARMUP;
//
//     final workout = WorkoutDto();
//     workout.theme = selectedWorkout.theme;
//     workout.id = selectedWorkout.id;
//     workoutProgress.workout = workout;
//
//     warmUpProgressResponse = ProgressResponse();
//     warmUpProgressResponse.date = today();
//     warmUpProgressResponse.workoutProgress = [workoutProgress];
//     HexagonState hexagonStage = HexagonState(body: 100, mind: 0, spirit: 10);
//     warmUpProgressResponse.hexagonState = hexagonStage;
//
//     warmUpProgressResponse.story = storyDto;
//     warmUpProgressResponse.environmental = envDto;
//     warmUpProgressResponse.wisdom = wisdomDto;
//     warmUpProgressResponse.iWillStatements = [];
//   });
//
//   tearDownAll(() async {
//     if (subscription != null) {
//       subscription.cancel();
//     }
//   });
//
//   group('warmup', () {
//     test('init app state', () async {
//       expect(theme, selectedWorkout.theme);
//     });
//
//     test('start workout', () async {
//       store.dispatch(NavigateToWorkoutPreviewPageAction(selectedWorkout));
//       store.dispatch(StartWorkoutAction(workout: selectedWorkout));
//       final progress = selectProgress(store, store.state.workoutState.workout);
//       expect(progress, null);
//       expect(store.state.workoutState.workout, selectedWorkout);
//       expect(appStateAfterWorkoutStarted.workoutState, lastState.workoutState);
//     });
//
//     test('warmup exercise duration count', () async {
//       store.dispatch(SetAppStateAction(appStateAfterWorkoutStarted));
//
//       for (int i = 0; i < selectedWorkout.warmUpRounds; i++) {
//         for (int j = 0; j < selectedWorkout.warmUp.length; j++) {
//           store.dispatch(AppendExerciseDurationTimeAction(
//               exercise: selectedWorkout.warmUp[j], page: WorkoutPageType.WARMUP, time: warmUpExerciseDurations[j]));
//         }
//       }
//
//       expect(appStateAfterWarmupExercises.workoutState, lastState.workoutState);
//     });
//
//     test('select mood', () async {
//       store.dispatch(SetAppStateAction(appStateAfterWarmupExercises));
//
//       store.dispatch(OnMoodSelectedAction(expectedMoodRate));
//       final answers = store.state.workoutState.warmUpState.answers;
//       expect(answers.length, 1);
//       expect(answers.last.answer, expectedMoodRate.toString());
//       expect(appStateAfterMoodSelected.workoutState, lastState.workoutState);
//     });
//
//     test('answer questions', () async {
//       store.dispatch(SetAppStateAction(appStateAfterMoodSelected));
//       Answer a1 = userAnswers[1];
//       Question q1 = store.state.workoutState.warmUpState.questions.firstWhere((q) => q.id == a1.questionId);
//       store.dispatch(OnQuestionAnsweredAction(questionId: a1.questionId, question: q1.question, answer: a1.answer));
//
//       Answer a2 = userAnswers[2];
//       Question q2 = store.state.workoutState.warmUpState.questions.firstWhere((q) => q.id == a2.questionId);
//       store.dispatch(OnQuestionAnsweredAction(questionId: a2.questionId, question: q2.question, answer: a2.answer));
//
//       final answers = store.state.workoutState.warmUpState.answers;
//
//       store.state.workoutState.warmUpState.answers.forEach((a) {
//         expect(lastState.workoutState.warmUpState.answers.firstWhere((e) => e.answer == a.answer, orElse: () => null),
//             isNotNull);
//       });
//       expect(answers.length, store.state.workoutState.warmUpState.questions.length);
//
//       expect(appStateAfterQuestionsAnswering.workoutState, lastState.workoutState);
//     });
//
//     test('warmup update progress', () async {
//       store.dispatch(SetAppStateAction(appStateAfterQuestionsAnswering));
//
//       final workoutId = store.state.workoutState.workout.id.toString();
//       final workoutPhase = WorkoutStage.WARMUP;
//       final String zoneId = "Europe/Kiev";
//
//       final duration = store.state.workoutState.warmUpState.getStageDuration();
//       final questions = store.state.workoutState.warmUpState.answers.toList();
//       final exerciseDurations = store.state.workoutState.warmUpState.toExerciseDurationDto(workoutPhase);
//
//       final _progressRequest = UpdateProgressRequest(
//           workoutId: workoutId,
//           workoutPhase: workoutPhase,
//           zoneId: zoneId,
//           exerciseDurations: exerciseDurations,
//           warmupStageDuration: duration,
//           questions: questions);
//
//       when(mockRemoteStorage.updateProgress(_progressRequest)).thenAnswer((_) async => warmUpProgressResponse);
//
//       ProgressPageModel last0 = store.state.mainPageState.progressPages.last;
//
//       expect(last0.hexagonState.body, 0);
//       expect(last0.hexagonState.mind, 0);
//       expect(last0.hexagonState.spirit, 0);
//
//       List<WorkoutProgressDto> workoutProgressList0 = last0.workoutProgressList;
//       expect(workoutProgressList0.length, 0);
//
//       store.dispatch(UpdateProgressForWarmUpSummaryAction(request: _progressRequest));
//
//       List<dynamic> listItems;
//       List<ProgressPageModel> progressPages;
//
//       await Future.delayed(Duration(milliseconds: 50), () {
//         listItems = store.state.workoutState.warmUpState.listItems;
//         progressPages = store.state.mainPageState.progressPages;
//       });
//
//       expect(listItems.length, 6);
//       expect(listItems[0] is SummaryHeaderItem, true);
//       final summaryHeaderItem = listItems[0] as SummaryHeaderItem;
//
//       expect(summaryHeaderItem.progressItems[0].initial, 0.0);
//       expect(summaryHeaderItem.progressItems[0].value, 1.0);
//       expect(summaryHeaderItem.progressItems[0].name, 'Emotional');
//
//       expect(summaryHeaderItem.progressItems[1].initial, 0.0);
//       expect(summaryHeaderItem.progressItems[1].value, 0.1);
//       expect(summaryHeaderItem.progressItems[1].name, 'Physical');
//
//       expect(summaryHeaderItem.activeStepIndex, 1);
//
//       expect(listItems[1] is ExerciseListItem, true);
//
//       final exerciseListItem = listItems[1] as ExerciseListItem;
//       expect(exerciseListItem.durations, appStateAfterMoodSelected.workoutState.warmUpState.exercisesDuration);
//       exerciseListItem.exercises.forEach((e) {
//         expect(selectedWorkout.warmUp.contains(e), true);
//       });
//       expect(listItems[2] is MoodListItem, true);
//       final moodListItem = listItems[2] as MoodListItem;
//       expect(moodListItem.emojiItem.rate, expectedMoodRate);
//
//       expect(listItems[3] is QuestionListItem, true);
//       final firstQuestionListItem = listItems[3] as QuestionListItem;
//
//       final answer1 = userAnswers.firstWhere((a) {
//         return a.answer == firstQuestionListItem.answer;
//       }, orElse: () => null);
//       expect(answer1, isNotNull);
//
//       expect(listItems[4] is QuestionListItem, true);
//
//       expect(listItems[4] is QuestionListItem, true);
//       final secondQuestionListItem = listItems[4] as QuestionListItem;
//
//       final answer2 = userAnswers.firstWhere((a) {
//         return a.answer == secondQuestionListItem.answer;
//       }, orElse: () => null);
//       expect(answer2, isNotNull);
//
//       expect(listItems[5] is WarmupListBottomPaddingItem, true);
//
//       ProgressPageModel last1 = store.state.mainPageState.progressPages.last;
//
//       expect(last1.hexagonState.body, 100);
//       expect(last1.hexagonState.mind, 0);
//       expect(last1.hexagonState.spirit, 10);
//
//       List<WorkoutProgressDto> workoutProgressList1 = last1.workoutProgressList;
//       expect(workoutProgressList1.length, 1);
//       expect(workoutProgressList1.last.workout.theme, theme);
//       expect(workoutProgressList1.last.workoutPhase, WorkoutStage.WARMUP);
//
//       AppState toPersist = lastState;
//     });
//
//     test('skill exercise duration count', () async {
//       expect(lastState.workoutState.skillState, isNull);
//       store.dispatch(NavigateToSkillStartPageAction());
//       int duration = 1000;
//       final skillExercise = selectedWorkout.skill;
//       store.dispatch(
//           AppendExerciseDurationTimeAction(exercise: skillExercise, page: WorkoutPageType.SKILL, time: duration));
//       expectedSkillDurationResult.putIfAbsent(skillExercise, () => 0);
//       expectedSkillDurationResult[skillExercise] = duration;
//
//       final storedExerciseDuration = lastState.workoutState.skillState.exercisesDuration;
//
//       expect(storedExerciseDuration, expectedSkillDurationResult);
//     });
//
//     test('skill technique rate', () async {
//       store.dispatch(NavigateToSkillSummaryPageAction(techniqueRate: expectedTechniqueRate));
//       expect(store.state.workoutState.skillState.skillTechniqueRate, expectedTechniqueRate);
//     });
//
//     test('skill progress update', () async {
//       ProgressPageModel last0 = store.state.mainPageState.progressPages.last;
//
//       expect(last0.hexagonState.body, 100);
//       expect(last0.hexagonState.mind, 0);
//       expect(last0.hexagonState.spirit, 10);
//
//       final workoutId = store.state.workoutState.workout.id.toString();
//       final workoutPhase = WorkoutStage.SKILL;
//       final String zoneId = "Europe/Kiev";
//
//       final skillTechniqueRate = store.state.workoutState.skillState.skillTechniqueRate;
//       final duration = store.state.workoutState.skillState.getStageDuration();
//       final exerciseDurations = store.state.workoutState.skillState.toExerciseDurationDto(workoutPhase);
//
//       final _progressRequest = UpdateProgressRequest(
//           workoutId: workoutId,
//           workoutPhase: workoutPhase,
//           zoneId: zoneId,
//           skillTechniqueRate: skillTechniqueRate,
//           exerciseDurations: exerciseDurations,
//           skillStageDuration: duration);
//
//       final fileUpdateProgressSkillResponse = new File('test/workout/update_progress_response_skill.json');
//       final decodedProgressResponse = jsonDecode(await fileUpdateProgressSkillResponse.readAsString());
//       final progressResponse = ProgressResponse.fromMap(decodedProgressResponse);
//       progressResponse.date = today();
//
//       when(mockRemoteStorage.updateProgress(_progressRequest)).thenAnswer((_) async => progressResponse);
//
//       store.dispatch(UpdateProgressForSkillSummaryAction(request: _progressRequest));
//
//       List<dynamic> listItems;
//       List<ProgressPageModel> progressPages;
//
//       await Future.delayed(Duration(milliseconds: 50), () {
//         listItems = store.state.workoutState.skillState.listItems;
//         progressPages = store.state.mainPageState.progressPages;
//       });
//
//       ProgressPageModel last1 = progressPages.last;
//       expect(last1.hexagonState.body, 100);
//       expect(last1.hexagonState.mind, 30);
//       expect(last1.hexagonState.spirit, 20);
//
//       List<WorkoutProgressDto> workoutProgressList1 = last1.workoutProgressList;
//       expect(workoutProgressList1.length, 1);
//       expect(workoutProgressList1.last.workout.theme, theme);
//       expect(workoutProgressList1.last.workoutPhase, WorkoutStage.SKILL);
//
//       expect(listItems.length, 4);
//       expect(listItems[0] is SkillSummaryHeaderItem, true);
//       expect(listItems[1] is SkillTimeListItem, true);
//       expect(listItems[2] is SkillTechniqueItem, true);
//       expect(listItems[3] is SkillListBottomPaddingItem, true);
//
//       final skillSummaryHeaderItem = listItems[0] as SkillSummaryHeaderItem;
//       expect(skillSummaryHeaderItem.activeStepIndex, 2);
//       expect(skillSummaryHeaderItem.progressItems[0].initial, 0.0);
//       expect(skillSummaryHeaderItem.progressItems[0].value, 1.0);
//       expect(skillSummaryHeaderItem.progressItems[0].name, 'Emotional');
//
//       expect(skillSummaryHeaderItem.progressItems[1].initial, 0.0);
//       expect(skillSummaryHeaderItem.progressItems[1].value, 0.2);
//       expect(skillSummaryHeaderItem.progressItems[1].name, 'Physical');
//
//       expect(skillSummaryHeaderItem.progressItems[2].initial, 0.0);
//       expect(skillSummaryHeaderItem.progressItems[2].value, 0.0);
//       expect(skillSummaryHeaderItem.progressItems[2].name, 'Environmental');
//
//       expect(skillSummaryHeaderItem.progressItems[3].initial, 0.0);
//       expect(skillSummaryHeaderItem.progressItems[3].value, 0.3);
//       expect(skillSummaryHeaderItem.progressItems[3].name, 'Intellectual');
//
//       final skillTimeListItem = listItems[1] as SkillTimeListItem;
//
//       expect(skillTimeListItem.totalTime, timeFromMilliseconds(expectedSkillDurationResult[selectedWorkout.skill]));
//
//       final skillTechniqueItem = listItems[2] as SkillTechniqueItem;
//
//       expect(skillTechniqueItem.rate, expectedTechniqueRate / 10);
//     });
//
//     test('wod exercise duration count', () async {
//       expect(lastState.workoutState.wodState, isNull);
//
//       store.dispatch(NavigateToWODExercisePageAction());
//
//       expect(lastState.workoutState.wodState.roundDuration, lastState.workoutState.workout.quantity * 60);
//       expect(lastState.workoutState.wodState.rounds,
//           lastState.workoutState.workout.quantity == 0 ? 1 : lastState.workoutState.workout.quantity);
//
//       int toAppend = 1000;
//       int stageDuration = 0;
//
//       for (int i = 0; i < lastState.workoutState.wodState.rounds; i++) {
//         selectedWorkout.wod.forEach((e) {
//           toAppend += 1000;
//           stageDuration += toAppend;
//           store.dispatch(AppendExerciseDurationTimeAction(exercise: e, page: WorkoutPageType.WOD, time: toAppend));
//           expectedWodDurationResult.putIfAbsent(e, () => 0);
//           expectedWodDurationResult[e] += toAppend;
//         });
//       }
//
//       final storedExerciseDuration = lastState.workoutState.wodState.exercisesDuration;
//
//       expect(storedExerciseDuration, expectedWodDurationResult);
//       expect(lastState.workoutState.wodState.getStageDuration(), stageDuration);
//     });
//
//     test('wod time edit', () async {
//       store.dispatch(UpdateForTimeWodResult(duration: expectedEditedWodTime));
//       expect(lastState.workoutState.wodState.getStageDuration(), expectedEditedWodTime);
//     });
//
//     test('wod for_time progress update', () async {
//       ProgressPageModel last0 = store.state.mainPageState.progressPages.last;
//
//       expect(last0.hexagonState.body, 100);
//       expect(last0.hexagonState.mind, 30);
//       expect(last0.hexagonState.spirit, 20);
//
//       final workoutId = store.state.workoutState.workout.id.toString();
//       final workoutPhase = WorkoutStage.WOD;
//       final String zoneId = "Europe/Kiev";
//       int duration = store.state.workoutState.wodState.getStageDuration();
//       int roundCount = store.state.workoutState.wodState.rounds;
//
//       final exerciseDurations = store.state.workoutState.wodState.toExerciseDurationDto(workoutPhase);
//
//       final progressRequest = UpdateProgressRequest(
//           workoutId: workoutId,
//           workoutPhase: workoutPhase,
//           zoneId: zoneId,
//           exerciseDurations: exerciseDurations,
//           roundCount: roundCount,
//           wodStageDuration: duration);
//
//       store.dispatch(UpdateProgressForWodSummaryAction(request: progressRequest));
//
//       final fileUpdateProgressWodResponse = new File('test/workout/update_progress_response_wOd.json');
//
//       final decodedProgressResponse = jsonDecode(await fileUpdateProgressWodResponse.readAsString());
//       final progressResponse = ProgressResponse.fromMap(decodedProgressResponse);
//       progressResponse.date = today();
//
//       when(mockRemoteStorage.updateProgress(progressRequest)).thenAnswer((_) async => progressResponse);
//
//       store.dispatch(UpdateProgressForWodSummaryAction(request: progressRequest));
//
//       List<dynamic> listItems;
//       List<ProgressPageModel> progressPages;
//
//       await Future.delayed(Duration(milliseconds: 50), () {
//         listItems = store.state.workoutState.wodState.listItems;
//         progressPages = store.state.mainPageState.progressPages;
//       });
//
//       ProgressPageModel last1 = progressPages.last;
//       expect(last1.hexagonState.body, 100);
//       expect(last1.hexagonState.mind, 30);
//       expect(last1.hexagonState.spirit, 90);
//
//       List<WorkoutProgressDto> workoutProgressList1 = last1.workoutProgressList;
//       expect(workoutProgressList1.length, 1);
//       expect(workoutProgressList1.last.workout.theme, theme);
//       expect(workoutProgressList1.last.workoutPhase, WorkoutStage.WOD);
//
//       expect(listItems.length, 3);
//       expect(listItems[0] is WODSummaryHeaderItem, true);
//       expect(listItems[1] is WODExerciseListItem, true);
//       expect(listItems[2] is WodListBottomPaddingItem, true);
//
//       final wodSummaryHeaderItem = listItems[0] as WODSummaryHeaderItem;
//       expect(wodSummaryHeaderItem.activeStepIndex, 3);
//       expect(wodSummaryHeaderItem.progressItems[0].initial, 0.0);
//       expect(wodSummaryHeaderItem.progressItems[0].value, 1.0);
//       expect(wodSummaryHeaderItem.progressItems[0].name, 'Emotional');
//
//       expect(wodSummaryHeaderItem.progressItems[1].initial, 0.0);
//       expect(wodSummaryHeaderItem.progressItems[1].value, 0.9);
//       expect(wodSummaryHeaderItem.progressItems[1].name, 'Physical');
//
//       expect(wodSummaryHeaderItem.progressItems[2].initial, 0.0);
//       expect(wodSummaryHeaderItem.progressItems[2].value, 0.0);
//       expect(wodSummaryHeaderItem.progressItems[2].name, 'Environmental');
//
//       expect(wodSummaryHeaderItem.progressItems[3].initial, 0.0);
//       expect(wodSummaryHeaderItem.progressItems[3].value, 0.3);
//       expect(wodSummaryHeaderItem.progressItems[3].name, 'Intellectual');
//
//       final wodExerciseListItem = listItems[1] as WODExerciseListItem;
//
//       expect(wodExerciseListItem.duration, expectedWodDurationResult);
//       expect(wodExerciseListItem.result, timeFromMilliseconds(progressResponse.workoutProgress.last.wodStageDuration));
//
//       wodExerciseListItem.exercises.forEach((e) {
//         expect(selectedWorkout.wod.contains(e), true);
//       });
//     });
//
//     test('wod exercise cooldown count', () async {
//       expect(lastState.workoutState.cooldownState, isNull);
//
//       store.dispatch(NavigateToCoolDownPageAction());
//
//       int toAppend = 1000;
//       int stageDuration = 0;
//
//       selectedWorkout.wod.forEach((e) {
//         toAppend += 1000;
//         stageDuration += toAppend;
//         store.dispatch(AppendExerciseDurationTimeAction(exercise: e, page: WorkoutPageType.COOLDOWN, time: toAppend));
//         expectedCooldownDurationResult.putIfAbsent(e, () => 0);
//         expectedCooldownDurationResult[e] += toAppend;
//       });
//
//       final storedExerciseDuration = lastState.workoutState.cooldownState.exercisesDuration;
//
//       expect(storedExerciseDuration, expectedCooldownDurationResult);
//       expect(lastState.workoutState.cooldownState.getStageDuration(), stageDuration);
//     });
//   });
// }
//
// Map<Exercise, int> _buildDurations(List<Exercise> exercises, List<int> durations, {int rounds = 1}) {
//   Map<Exercise, int> result = {};
//
//   if (durations.length != exercises.length) {
//     throw 'exercise count must be equal to exercise time durations';
//   }
//
//   ///ensure round count > 0, to return map with 0 durations
//   if (rounds < 1) {
//     rounds = 1;
//   }
//
//   for (int j = 0; j < rounds; j++) {
//     for (int i = 0; i < exercises.length; i++) {
//       result.putIfAbsent(exercises[i], () => 0);
//       result[exercises[i]] += durations[i];
//     }
//   }
//   return result;
// }
