// import 'package:totalfit/ui/screen/main/workout/widgets/pause_page.dart';
// import 'package:workout_data_legacy/data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import 'package:totalfit/data/workout_phase.dart';
// import 'package:totalfit/domain/audio_controllers.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:ui_kit/ui_kit.dart';
// import 'package:core/src/audio/model/preference.dart';
// import 'package:totalfit/model/workout_page_type.dart';
// import 'package:totalfit/model/workout_voice_message.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/ui/screen/main/workout/utils/workout_utils.dart';
// import 'package:totalfit/ui/screen/main/workout/widgets/exercise_page.dart';
// import 'package:totalfit/ui/screen/main/workout/widgets/time_indicator.dart';
// import 'package:wakelock/always_on.dart';
//
// class SkillExercisePage extends StatefulWidget {
//   @override
//   _SkillExercisePageState createState() => _SkillExercisePageState();
// }
//
// class _SkillExercisePageState extends State<SkillExercisePage> {
//   bool _isPaused = false;
//   int startPlayTime = -1;
//
//   //to stop video playback
//   bool _isShowControllers = false;
//   bool _isCountdownFinished = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//       distinct: true,
//       converter: _ViewModel.fromStore,
//       onInit: (store) {
//         Wakelock.enable();
//       },
//       onWillChange: (oldVm, newVm) {
//         if (oldVm.appLifecycleState != newVm.appLifecycleState && newVm.appLifecycleState == AppLifecycleState.paused) {
//           newVm.onPausePressed(newVm.exercise);
//           if (newVm.audioMode == AudioMode.MUTE) {
//             newVm.disposeAudio();
//           } else {
//             newVm.resumeAudio();
//           }
//           setState(() {
//             _isPaused = true;
//           });
//         }
//       },
//       onDispose: (store) {
//         Wakelock.disable();
//       },
//       builder: (context, vm) => _buildContent(vm, context),
//     );
//   }
//
//   Widget _buildContent(_ViewModel vm, BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(vm),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             _buildExerciseWidget(vm),
//             _buildControllers(vm),
//             Visibility(
//               child: _buildPauseScreen(vm, context),
//               visible: _isPaused,
//               replacement: SizedBox.shrink(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPauseScreen(_ViewModel vm, BuildContext context) => PausePage(
//         title: getPausePageTitle(WorkoutPhase.SKILL, context),
//         showTutorial: false,
//         onPlayTap: () {
//           setState(() {
//             _isPaused = false;
//             vm.onPausePressed(Exercise.clearStateStub());
//             if (vm.audioMode == AudioMode.MUTE) {
//               vm.disposeAudio();
//             } else {
//               vm.resumeAudio();
//             }
//           });
//         },
//         onQuitWorkout: () {
//           vm.quitWorkout();
//         },
//       );
//
//   Widget _buildControllers(_ViewModel vm) {
//     return SafeArea(
//       child: AnimatedOpacity(
//         opacity: !_isPaused && _isShowControllers ? 1.0 : 0.0,
//         duration: Duration(milliseconds: 200),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(left: 4, top: 4),
//                     child: Container(
//                       child: Row(
//                         children: [
//                           Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               customBorder: CircleBorder(),
//                               splashColor: AppColorScheme.colorBlack10.withOpacity(0.1),
//                               highlightColor: Colors.transparent,
//                               onTap: () {
//                                 setState(() {
//                                   _isPaused = true;
//                                   vm.onPausePressed(vm.exercise);
//                                   vm.pauseAudio();
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.all(8.0),
//                                 child: Icon(
//                                   Icons.pause,
//                                   color: AppColorScheme.colorPrimaryWhite,
//                                   size: 24,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(width: 8),
//                           TimeIndicator(
//                             isPaused: _isPaused,
//                             key: ValueKey("_time_indicator"),
//                           ),
//                           _buildNextExerciseIndicator(vm)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNextExerciseIndicator(_ViewModel vm) => Expanded(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             height: 40,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: InkWell(
//                 onTap: () {
//                   setState(() {});
//                   vm.stopVoice();
//                   vm.navigateToTechniqueRatePage();
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(S.of(context).done,
//                         style: textRegular16.copyWith(
//                           color: AppColorScheme.colorPrimaryWhite,
//                         )),
//                     Container(width: 6),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       color: AppColorScheme.colorPrimaryWhite,
//                       size: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//
//   Widget _buildExerciseWidget(_ViewModel vm) => ExercisePage(
//       onPaused: _isPaused,
//       useCache: true,
//       waitForCountdown: !_isCountdownFinished,
//       showControllers: _isShowControllers,
//       // onShowTutorialClick: (e) {
//       //   vm.showTutorial(e);
//       //   setState(() {
//       //     _isPaused = true;
//       //   });
//       //   vm.pauseAudio();
//       // },
//       onStartCountdown: () {
//         vm.playCountdownVoice();
//       },
//       onCountdownCompleted: () {
//         _isPaused = false;
//         _isShowControllers = true;
//         _isCountdownFinished = true;
//         vm.playAudio();
//         vm.onPausePressed(Exercise.clearStateStub());
//       },
//       exercise: vm.exercise,
//       scrollToNextPage: (isScrolledByUser) {
//         setState(() {});
//         vm.stopVoice();
//
//         vm.navigateToTechniqueRatePage();
//       },
//       page: WorkoutPageType.SKILL);
//
//   Future<bool> _onBackPressed(_ViewModel vm) async {
//     final attrs = TfDialogAttributes(
//       title: S.of(context).dialog_quit_workout_title,
//       description: S.of(context).dialog_quit_workout_description,
//       negativeText: S.of(context).dialog_quit_workout_negative_text,
//       positiveText: S.of(context).all__continue,
//     );
//     final result = await TfDialog.show(context, attrs);
//     if (result is Cancel) {
//       vm.quitWorkout();
//     }
//     return Future.sync(() => false);
//   }
// }
//
// class _ViewModel extends AudioController {
//   final Exercise exercise;
//   final Function navigateToTechniqueRatePage;
//   final Function(Exercise) onPausePressed;
//   final Function quitWorkout;
//   final AppLifecycleState appLifecycleState;
//
//   _ViewModel({
//     this.exercise,
//     this.onPausePressed,
//     this.navigateToTechniqueRatePage,
//     //  this.showTutorial,
//     this.quitWorkout,
//     this.appLifecycleState,
//     @required store,
//     @required audioMode,
//   }) : super(store: store, mode: audioMode);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//       store: store,
//       audioMode: store.state.preferenceState.audioMode,
//       appLifecycleState: store.state.appLifecycleState,
//       exercise: store.state.workoutState.workout.skill,
//       // showTutorial: (e) => store
//       //     .dispatch(OnShowTutorialAction(page: TutorialPage(exercise: e, parent: TutorialPageParent.ExercisePage))),
//       quitWorkout: () => store.dispatch(QuitWorkoutAction(WorkoutPhase.WARMUP)),
//       onPausePressed: (e) => store.dispatch(OnExercisePausePressedAction(e, WorkoutPhase.WARMUP)),
//       navigateToTechniqueRatePage: () => store.dispatch(
//         NavigateToTechniqueRatePageAction(),
//       ),
//     );
//   }
//
//   @override
//   WorkoutVoiceMessage getVoiceMessage() => WorkoutVoiceMessage.SKILL_EXERCISES;
//
//   @override
//   WorkoutPageType getWorkoutPage() => WorkoutPageType.SKILL;
// }
