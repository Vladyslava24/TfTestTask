// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:redux/redux.dart';
// import 'package:totalfit/data/dto/request/update_progress_request.dart';
// import 'package:totalfit/data/workout_phase.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:totalfit/model/workout_preview_list_items.dart';
// import 'package:totalfit/redux/actions/progress_actions.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/ui/widgets/grid_items.dart';
// import 'package:ui_kit/ui_kit.dart';
//
// import 'widgets.dart';
//
// class ShareResultsPage extends StatefulWidget {
//   @override
//   _ShareResultsPageState createState() => _ShareResultsPageState();
// }
//
// class _ShareResultsPageState extends State<ShareResultsPage> {
//   GlobalKey _shareContentKey = GlobalKey();
//   ImageItem _selectedItem;
//   bool _hasShared = false;
//   bool _isLoading = false;
//
//   final _picker = ImagePicker();
//
//   static const IOS_METHOD_CHANNEL = 'channel:com.totalfit.mobile/share';
//   static const ANDROID_METHOD_CHANNEL = 'channel:com.totalfit.mobile.android/share';
//
//   Future _getImage(ImageSource source) async {
//     final pickedFile = await _picker.getImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedItem = ImageItem(url: pickedFile.path);
//       });
//     }
//   }
//
//   Future<ByteData> _captureShareContent() async {
//     RenderRepaintBoundary boundary = _shareContentKey.currentContext.findRenderObject();
//     ui.Image image = await boundary.toImage(pixelRatio: MediaQuery.of(context).devicePixelRatio);
//     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData;
//   }
//
//   Future<void> _shareResults(ByteData byteData, _ViewModel vm) async {
//     final Uint8List list = byteData.buffer.asUint8List();
//
//     final tempDir = await getTemporaryDirectory();
//     final file = await new File('${tempDir.path}/workout_results.jpg').create();
//     file.writeAsBytesSync(list);
//
//     final channel = MethodChannel(Platform.isIOS ? IOS_METHOD_CHANNEL : ANDROID_METHOD_CHANNEL);
//     _hasShared = await channel.invokeMethod('shareFile', file.path);
//     if (Platform.isIOS) {
//       vm.onComplete(_hasShared);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//       distinct: true,
//       converter: (store) => _ViewModel.fromStore(store),
//       onWillChange: (oldVm, newVm) {
//         if (Platform.isAndroid) {
//           if (oldVm.lifecycleState != AppLifecycleState.resumed && newVm.lifecycleState == AppLifecycleState.resumed) {
//             if (_hasShared) {
//               _isLoading = true;
//               newVm.onComplete(_hasShared);
//             }
//           }
//         }
//         if (newVm.errorMessage.isNotEmpty && oldVm.errorMessage.isEmpty) {
//           _isLoading = false;
//           final attrs = TfDialogAttributes(
//             title: S.of(context).filed_update_state,
//             description: newVm.errorMessage,
//             negativeText: S.of(context).dialog_error_recoverable_negative_text,
//             positiveText: S.of(context).all__retry,
//           );
//           TfDialog.show(context, attrs).then((r) {
//             if (r is Cancel) {
//               newVm.quitWorkout();
//             } else {
//               setState(() {
//                 _isLoading = true;
//               });
//               newVm.onComplete(_hasShared);
//             }
//           });
//           newVm.clearShareResultError();
//         }
//       },
//       builder: (context, vm) => Stack(
//         children: [
//           Positioned.fill(child: _buildContent(vm)),
//           _isLoading ? CircularLoadingIndicator() : Container(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContent(_ViewModel vm) {
//     if (_selectedItem == null) {
//       _selectedItem = vm.getDefaultImageItem();
//     }
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(vm),
//       child: Scaffold(
//         backgroundColor: AppColorScheme.colorBlack,
//         appBar: SimpleAppBar(
//           leadingType: LeadingType.button,
//           leadingText: S.of(context).not_now,
//           title: S.of(context).exercises,
//           leadingAction: () {
//             setState(() {
//               _isLoading = true;
//             });
//             vm.onComplete(_hasShared);
//             print('onCancel');
//           },
//           actionType: ActionType.button,
//           actionButtonText: S.of(context).share,
//           actionFunction: () {
//             _captureShareContent().then((bytes) => _shareResults(bytes, vm)).then((value) {
//               print("Shared successfully");
//             }).catchError(
//                   (e) {
//                 final attrs = TfDialogAttributes(
//                     title: S.of(context).share_result_error,
//                     description: e.toString(),
//                     positiveText: S.of(context).all__OK);
//                 return TfDialog.show(context, attrs);
//               },
//             );
//           },
//         ),
//         body: Column(
//           children: <Widget>[
//             ResultWidget(
//                 workoutDuration: vm.workoutDuration,
//                 wod: vm.wodItem,
//                 wodType: vm.wodType,
//                 workoutName: vm.workoutName,
//                 totalExercises: vm.totalExercises,
//                 wodResult: vm.wodResult,
//                 roundCount: vm.roundCount,
//                 shareContentKey: _shareContentKey,
//                 imageUrl: _selectedItem == null ? null : _selectedItem.url),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                 child: StaggeredGridView.count(
//                   addAutomaticKeepAlives: false,
//                   mainAxisSpacing: 12.0,
//                   crossAxisSpacing: 12.0,
//                   padding: const EdgeInsets.only(top: 12.0),
//                   crossAxisCount: COLUMN_COUNT,
//                   staggeredTiles: vm.items.map((item) {
//                     if (item is HeaderItem) {
//                       return StaggeredTile.count(3, 0.3);
//                     } else {
//                       return StaggeredTile.count(1, 1);
//                     }
//                   }).toList(),
//                   children: vm.items.map((item) => _buildListItem(item, vm)).toList(),
//                 ),
//               ),
//             ),
//           ],
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
//       vm.onComplete(_hasShared);
//     }
//     return Future.sync(() => false);
//   }
//
//   Widget _buildListItem(GridItem item, _ViewModel vm) {
//     if (item is HeaderItem) {
//       return Text(
//         item.getTitle(),
//         style: title20.copyWith(
//           color: AppColorScheme.colorPrimaryWhite,
//         ),
//       );
//     } else if (item is GalleryPickerItem) {
//       return _buildImagePicker(vm);
//     } else {
//       return ImageItemWidget(
//           key: ObjectKey(item),
//           item: item,
//           onSelected: (item) {
//             setState(() {
//               _selectedItem = item;
//             });
//           },
//           isSelected: item == _selectedItem);
//     }
//   }
//
//   Widget _buildImagePicker(_ViewModel vm) => Material(
//     color: Colors.transparent,
//     child: ClipRRect(
//       key: ObjectKey("GALLERY_PICKER"),
//       borderRadius: BorderRadius.circular(8),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: AppColorScheme.colorBlack2,
//             child: Icon(Icons.add_a_photo, size: 35, color: AppColorScheme.colorBlack7),
//           ),
//           ClipRRect(
//             borderRadius: new BorderRadius.circular(10),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () async {
//                   final imageSource = await showCupertinoModalPopup(
//                     context: context,
//                     builder: (context) => CupertinoActionSheet(
//                       actions: [
//                         CupertinoActionSheetAction(
//                           onPressed: () {
//                             Navigator.of(context).pop(ImageSource.gallery);
//                           },
//                           child: Text(
//                             S.of(context).gallery,
//                             style: textRegular16.copyWith(
//                               color: AppColorScheme.colorPrimaryBlack,
//                             ),
//                           ),
//                         ),
//                         CupertinoActionSheetAction(
//                           onPressed: () {
//                             Navigator.of(context).pop(ImageSource.camera);
//                           },
//                           child: Text(
//                             S.of(context).camera,
//                             style: textRegular16.copyWith(
//                               color: AppColorScheme.colorPrimaryBlack,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                   if (imageSource != null) {
//                     vm.sendPickedImageEvent(imageSource);
//                     _getImage(imageSource);
//                   }
//                 },
//                 splashColor: AppColorScheme.colorPrimaryWhite.withOpacity(0.3),
//                 highlightColor: AppColorScheme.colorPrimaryWhite.withOpacity(0.1),
//                 child: Container(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// class _ViewModel {
//   final ExerciseCategoryItem wodItem;
//   final Function(bool) onComplete;
//   final List<GridItem> items;
//   final AppLifecycleState lifecycleState;
//   final int workoutDuration;
//   final String wodType;
//   final String workoutName;
//   final int totalExercises;
//   final int wodResult;
//   final int roundCount;
//   final Function quitWorkout;
//   final Function clearShareResultError;
//   final Function(ImageSource) sendPickedImageEvent;
//   final String errorMessage;
//
//   _ViewModel(
//       {@required this.workoutDuration,
//         @required this.wodType,
//         @required this.workoutName,
//         @required this.totalExercises,
//         @required this.wodResult,
//         @required this.roundCount,
//         @required this.wodItem,
//         @required this.items,
//         @required this.clearShareResultError,
//         @required this.lifecycleState,
//         @required this.quitWorkout,
//         @required this.errorMessage,
//         @required this.sendPickedImageEvent,
//         @required this.onComplete});
//
//   ImageItem getDefaultImageItem() {
//     return items[9];
//   }
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//         workoutDuration: store.state.workoutState.shareResultsState.workoutDuration,
//         wodType: store.state.workoutState.shareResultsState.wodType,
//         workoutName: store.state.workoutState.shareResultsState.workoutName,
//         totalExercises: store.state.workoutState.shareResultsState.totalExercises,
//         wodResult: store.state.workoutState.shareResultsState.wodResult ?? -1,
//         roundCount: store.state.workoutState.shareResultsState.roundCount ?? -1,
//         wodItem: store.state.workoutState.shareResultsState.wodItem,
//         items: store.state.workoutState.shareResultsState.listItems,
//         errorMessage: store.state.workoutState.shareResultsState.errorMessage,
//         clearShareResultError: () => store.dispatch(ClearShareErrorAction()),
//         sendPickedImageEvent: (source) => store.dispatch(SendPickedImageEventAction(source)),
//         lifecycleState: store.state.appLifecycleState,
//         quitWorkout: () => store.dispatch(QuitWorkoutAction(WorkoutPhase.COOLDOWN)),
//         onComplete: (hasShared) async {
//           final workoutId = store.state.workoutState.workout.id.toString();
//           final workoutPhase = WorkoutPhase.FINISHED;
//           final request = UpdateProgressRequest(
//               workoutProgressId: store.state.workoutState.workoutProgressId,
//               shared: hasShared,
//               workoutId: workoutId,
//               workoutPhase: workoutPhase);
//
//           store.dispatch(UpdateProgressForShareResultsAction(request: request));
//         });
//   }
// }
//
// const COLUMN_COUNT = 3;
