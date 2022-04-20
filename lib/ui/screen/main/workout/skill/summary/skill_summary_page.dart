// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import 'package:totalfit/data/dto/request/update_progress_request.dart';
// import 'package:totalfit/data/workout_phase.dart';
// import 'package:totalfit/domain/audio_controllers.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:totalfit/model/skill_summary/skill_summary_header_list_item.dart';
// import 'package:totalfit/model/skill_summary/skill_technique_rate_item.dart';
// import 'package:totalfit/model/skill_summary/skill_total_time_item.dart';
// import 'package:totalfit/model/workout_voice_message.dart';
// import 'package:totalfit/redux/actions/audio_actions.dart';
// import 'package:totalfit/redux/actions/progress_actions.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/selectors/progress_selectors.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/ui/screen/main/workout/summary/list_item_widgets.dart';
// import 'package:ui_kit/ui_kit.dart';
//
// class SkillSummaryPage extends StatefulWidget {
//   @override
//   _SkillSummaryPageState createState() => _SkillSummaryPageState();
// }
//
// class _SkillSummaryPageState extends State<SkillSummaryPage> {
//   UpdateProgressRequest _progressRequest;
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         distinct: true,
//         converter: _ViewModel.fromStore,
//         onInitialBuild: (vm) {
//           if (vm.workoutPhase != WorkoutPhase.SKILL) {
//             vm.setVoiceAudio();
//           }
//         },
//         onInit: (store) async {
//           final workoutPhase = selectWorkoutStage(store);
//
//           if (workoutPhase == WorkoutPhase.SKILL) {
//             store.dispatch(BuildSkillSummaryListItemsAction());
//           } else {
//             final workoutId = store.state.workoutState.workout.id.toString();
//             final workoutPhase = WorkoutPhase.SKILL;
//             final String zoneId = await FlutterNativeTimezone.getLocalTimezone();
//
//             final skillTechniqueRate = store.state.workoutState.skillState.skillTechniqueRate;
//             final duration = store.state.workoutState.skillState.getStageDuration();
//             final exerciseDurations = store.state.workoutState.skillState.toExerciseDurationDto(workoutPhase);
//             final workoutProgressId = store.state.workoutState.workoutProgressId;
//
//             _progressRequest = UpdateProgressRequest(
//                 workoutId: workoutId,
//                 workoutPhase: workoutPhase,
//                 zoneId: zoneId,
//                 skillTechniqueRate: skillTechniqueRate,
//                 exerciseDurations: exerciseDurations,
//                 workoutProgressId: workoutProgressId,
//                 skillStageDuration: duration);
//             store.dispatch(UpdateProgressForSkillSummaryAction(request: _progressRequest));
//           }
//         },
//         onWillChange: (oldVm, newVm) {
//           if (newVm.errorMessage.isNotEmpty && oldVm.errorMessage.isEmpty) {
//             final attrs = TfDialogAttributes(
//               title: S.of(context).filed_update_state,
//               description: newVm.errorMessage,
//               negativeText: S.of(context).dialog_error_recoverable_negative_text,
//               positiveText: S.of(context).all__retry,
//             );
//             TfDialog.show(context, attrs).then((r) {
//               newVm.clearSkillError();
//               if (r is Cancel) {
//                 newVm.quitWorkout();
//               } else {
//                 newVm.updateProgress(_progressRequest);
//               }
//             });
//           }
//         },
//         builder: (context, vm) => _buildContent(vm));
//   }
//
//   Widget _buildContent(_ViewModel vm) {
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(vm),
//       child: Material(
//         color: AppColorScheme.colorBlack,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: vm.listItems != null
//                     ? ListView.builder(
//                         itemCount: vm.listItems.length,
//                         itemBuilder: (context, index) {
//                           final item = vm.listItems[index];
//                           if (item is SkillSummaryHeaderItem) {
//                             return SummaryHeaderWidget(item: item, key: ValueKey(item.headerTitle));
//                           }
//
//                           if (item is SkillTimeListItem) {
//                             return SkillTimeItemWidget(item: item);
//                           }
//
//                           if (item is SkillTechniqueItem) {
//                             return SkillTechniqueItemWidget(item: item, onEdit: vm.onEdit);
//                           }
//
//                           if (item is SkillListBottomPaddingItem) {
//                             return ListBottomPadding();
//                           }
//
//                           return Container();
//                         },
//                       )
//                     : CircularLoadingIndicator(),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: ActionButton(
//                   padding: EdgeInsets.all(16),
//                   text: S.of(context).workout_preview_wod_button_text.toUpperCase(),
//                   color: AppColorScheme.colorYellow,
//                   onPressed: () => vm.goToWOD(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
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
// class _ViewModel extends VoiceController {
//   final List<dynamic> listItems;
//   final Function goToWOD;
//   final Function quitWorkout;
//   final Function onEdit;
//   final Function(UpdateProgressRequest) updateProgress;
//   final Function clearSkillError;
//   final String errorMessage;
//   final WorkoutPhase workoutPhase;
//
//   _ViewModel(
//       {@required this.listItems,
//       @required this.goToWOD,
//       @required this.quitWorkout,
//       @required this.onEdit,
//       @required this.updateProgress,
//       @required this.clearSkillError,
//       @required this.errorMessage,
//       @required this.workoutPhase,
//       @required store,
//       @required audioMode})
//       : super(store: store, audioMode: audioMode);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//         store: store,
//         audioMode: store.state.preferenceState.audioMode,
//         listItems: store.state.workoutState.skillState.listItems,
//         errorMessage: store.state.workoutState.skillState.errorMessage,
//         workoutPhase: selectWorkoutStage(store),
//         updateProgress: (request) => store.dispatch(UpdateProgressForSkillSummaryAction(request: request)),
//         clearSkillError: () => store.dispatch(ClearSkillErrorAction()),
//         onEdit: () {
//           // store.dispatch(NavigateToTechniqueRatePageInEditModeAction());
//         },
//         quitWorkout: () => store.dispatch(QuitWorkoutAction(WorkoutPhase.SKILL)),
//         goToWOD: () {
//           store.dispatch(MusicStoppedAction());
//           store.dispatch(VoiceStoppedAction());
//           store.dispatch(NavigateToWODExercisePageAction());
//         });
//   }
//
//   @override
//   WorkoutVoiceMessage getVoiceMessage() => WorkoutVoiceMessage.SKILL_COMPLETE;
// }
//
// class SkillListBottomPaddingItem {}
