// import 'package:workout_data_legacy/data.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import 'package:totalfit/data/workout_phase.dart';
// import 'package:totalfit/domain/audio_controllers.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:totalfit/model/tutorial_page.dart';
// import 'package:ui_kit/ui_kit.dart';
// import 'package:totalfit/model/workout_voice_message.dart';
// import 'package:totalfit/redux/actions/audio_actions.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/ui/screen/main/workout/widgets/network_video_widget.dart';
//
// class SkillStartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         distinct: true,
//         converter: _ViewModel.fromStore,
//         onInitialBuild: (vm) => vm.setVoiceAudio(),
//         builder: (context, vm) => _buildContent(vm, context));
//   }
//
//   Widget _buildContent(_ViewModel vm, BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(vm, context),
//       child: Material(
//         child: Stack(
//           children: <Widget>[
//             Positioned.fill(
//               child: Container(
//                 color: AppColorScheme.colorBlack,
//                 foregroundDecoration: new BoxDecoration(
//                     color: AppColorScheme.colorBlack.withOpacity(0.5),
//                     shape: BoxShape.rectangle),
//                 child: CachedNetworkVideoWidget(
//                   exercise: vm.exercise,
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   looping: true,
//                   onReady: () {},
//                   scrollToNextPage: () {},
//                   scrollToPreviousPage: () {},
//                 ),
//               ),
//             ),
//             Positioned.fill(
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 32.0, left: 16, right: 16, bottom: 16),
//                       child: Text(
//                         vm.skillName,
//                         textAlign: TextAlign.left,
//                         style: title30.copyWith(
//                           color: AppColorScheme.colorPrimaryWhite,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16.0),
//                       child: Text(
//                         S.of(context).watch_tutorial_exercise,
//                         textAlign: TextAlign.left,
//                         style: textRegular16.copyWith(
//                           color: AppColorScheme.colorPrimaryWhite,
//                         ),
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     ActionButton(
//                       text: S.of(context).watch_tutorial.toUpperCase(),
//                       padding: EdgeInsets.all(16),
//                       color: AppColorScheme.colorYellow,
//                       onPressed: () => vm.goToSkillVideoPage(),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _onBackPressed(_ViewModel vm, BuildContext context) async {
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
// class _ViewModel extends VoiceController {
//   Function goToSkillVideoPage;
//   Function quitWorkout;
//   String skillName;
//   Exercise exercise;
//
//   _ViewModel({
//     this.skillName,
//     this.goToSkillVideoPage,
//     this.quitWorkout,
//     this.exercise,
//     @required store,
//     @required audioMode,
//   }) : super(store: store, audioMode: audioMode);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//       store: store,
//       audioMode: store.state.preferenceState.audioMode,
//       skillName: store.state.workoutState.workout.skill.name.toUpperCase(),
//       exercise: store.state.workoutState.workout.skill,
//       quitWorkout: () => store.dispatch(QuitWorkoutAction(WorkoutPhase.WARMUP)),
//       goToSkillVideoPage: () {
//         store.dispatch(VoiceStoppedAction());
//         store.dispatch(
//           OnShowTutorialAction(
//             page: TutorialPage(
//               exercise: store.state.workoutState.workout.skill,
//               parent: TutorialPageParent.SkillPage,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   WorkoutVoiceMessage getVoiceMessage() => WorkoutVoiceMessage.SKILL_START;
// }
