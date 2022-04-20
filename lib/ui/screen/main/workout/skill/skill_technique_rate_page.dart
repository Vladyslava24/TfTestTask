// import 'package:core/core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import 'package:totalfit/data/workout_phase.dart';
// import 'package:totalfit/domain/audio_controllers.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:totalfit/model/workout_voice_message.dart';
// import 'package:totalfit/redux/actions/audio_actions.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/ui/widgets/rate_picker.dart';
// import 'package:totalfit/utils/locales_service.dart';
// import 'package:ui_kit/ui_kit.dart';
//
// final LocalesService _localesService = DependencyProvider.get<LocalesService>();
//
// class SkillTechniqueRatePage extends StatefulWidget {
//   final bool isEditMode;
//
//   SkillTechniqueRatePage({this.isEditMode = false});
//
//   @override
//   _SkillTechniqueRatePageState createState() => _SkillTechniqueRatePageState();
// }
//
// List<String> skillRateText = [
//   _localesService.locales.skill_tate_text_1,
//   _localesService.locales.skill_tate_text_2,
//   _localesService.locales.skill_tate_text_3,
//   _localesService.locales.skill_tate_text_4,
//   _localesService.locales.skill_tate_text_5
// ];
//
// class _SkillTechniqueRatePageState extends State<SkillTechniqueRatePage> {
//   double _selectedRate = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         distinct: true,
//         converter: (store) => _ViewModel.fromStore(store, widget.isEditMode),
//         onInitialBuild: (vm) => vm.setVoiceAudio(),
//         builder: (context, vm) => _buildContent(vm));
//   }
//
//   Widget _buildContent(_ViewModel vm) {
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(vm),
//       child: Scaffold(
//         backgroundColor: AppColorScheme.colorBlack,
//         body: AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle.light,
//           child: SafeArea(
//             child: Material(
//               color: AppColorScheme.colorBlack,
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.all(32),
//                       child: Text(
//                         S.of(context).assess_your_technique,
//                         style: title20.copyWith(
//                           color: AppColorScheme.colorPrimaryWhite,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(left: 24.0, right: 24.0),
//                           child: Text(
//                             getByRate(_selectedRate),
//                             textAlign: TextAlign.center,
//                             style: textRegular16.copyWith(
//                               color: AppColorScheme.colorBlack10,
//                             ),
//                           ),
//                         ),
//                         Container(height: 24),
//                         RatePicker(
//                           initialRate: vm.initialRate,
//                           width: MediaQuery.of(context).size.width - 48,
//                           onRateSelected: (rate) {
//                             setState(() {
//                               print("${(_selectedRate * 10).round().toInt()}");
//                               _selectedRate = rate;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             Expanded(
//                               child: ActionButton(
//                                 padding: EdgeInsets.only(bottom: 16, left: 16, right: 8),
//                                 textColor: AppColorScheme.colorPrimaryWhite,
//                                 icon: Icon(Icons.replay, color: AppColorScheme.colorPrimaryWhite),
//                                 text: S.of(context).repeat.toUpperCase(),
//                                 color: AppColorScheme.colorBlack4,
//                                 onPressed: () => vm.repeat(),
//                               ),
//                             ),
//                             Expanded(
//                               child: ActionButton(
//                                 padding: EdgeInsets.only(bottom: 16, left: 8, right: 16),
//                                 text: S.of(context).all__continue.toUpperCase(),
//                                 color: AppColorScheme.colorYellow,
//                                 onPressed: () {
//                                   vm.navigateToSkillSummaryPage((_selectedRate * 10).round().toInt());
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
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
//   Function(int) navigateToSkillSummaryPage;
//   Function quitWorkout;
//   Function repeat;
//   double initialRate;
//
//   _ViewModel({
//     @required this.navigateToSkillSummaryPage,
//     @required this.repeat,
//     @required this.quitWorkout,
//     @required this.initialRate,
//     @required store,
//     @required audioMode,
//   }) : super(store: store, audioMode: audioMode);
//
//   static _ViewModel fromStore(Store<AppState> store, bool isEditMode) {
//     return _ViewModel(
//         store: store,
//         initialRate: isEditMode ? store.state.workoutState.skillState.skillTechniqueRate : 0.0,
//         audioMode: store.state.preferenceState.audioMode,
//         repeat: () {
//           store.dispatch(MusicStoppedAction());
//           store.dispatch(RepeatSkillExerciseAction(store.state.workoutState.workout.skill.name));
//         },
//         quitWorkout: () => store.dispatch(QuitWorkoutAction(WorkoutPhase.WARMUP)),
//         navigateToSkillSummaryPage: (rate) {
//           store.dispatch(VoiceStoppedAction());
//           store.dispatch(NavigateToSkillSummaryPageAction(techniqueRate: rate));
//         });
//   }
//
//   @override
//   WorkoutVoiceMessage getVoiceMessage() => WorkoutVoiceMessage.SKILL_ASSESS;
// }
//
// String getByRate(double rate) {
//   int index = 0;
//   if (0 <= rate && rate <= 0.2) {
//     index = 0;
//   } else if (0.2 < rate && rate <= 0.4) {
//     index = 1;
//   } else if (0.4 < rate && rate <= 0.6) {
//     index = 2;
//   } else if (0.6 < rate && rate <= 0.8) {
//     index = 3;
//   } else if (0.8 < rate) {
//     index = 4;
//   }
//
//   return skillRateText[index];
// }
