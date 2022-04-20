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
// import 'package:totalfit/exception/idle_exception.dart';
// import 'package:totalfit/exception/tf_exception.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:totalfit/model/profile_share_workout_results_bundle.dart';
// import 'package:totalfit/model/workout_preview_list_items.dart';
// import 'package:totalfit/redux/actions/navigation_actions.dart';
// import 'package:totalfit/redux/actions/profile_share_workout_results_actions.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:totalfit/redux/states/app_state.dart';
// import 'package:totalfit/ui/screen/main/workout/share/widgets.dart';
// import 'package:totalfit/ui/widgets/grid_items.dart';
// import 'package:ui_kit/ui_kit.dart';
//
// class ProfileShareWorkoutResultsScreen extends StatefulWidget {
//   final ProfileShareWorkoutResultsScreenBundle bundle;
//
//   ProfileShareWorkoutResultsScreen({@required this.bundle});
//
//   @override
//   _ProfileShareWorkoutResultsScreenState createState() => _ProfileShareWorkoutResultsScreenState();
// }
//
// class _ProfileShareWorkoutResultsScreenState extends State<ProfileShareWorkoutResultsScreen> {
//   GlobalKey _shareContentKey = GlobalKey();
//   bool _hasShared = false;
//   bool _isLoading = false;
//
//   final _picker = ImagePicker();
//
//   static const IOS_METHOD_CHANNEL = 'channel:com.totalfit.mobile/share';
//   static const ANDROID_METHOD_CHANNEL = 'channel:com.totalfit.mobile.android/share';
//
//   Future _getImage(ImageSource source, _ViewModel vm) async {
//     final pickedFile = await _picker.getImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         vm.setImage(ImageItem(url: pickedFile.path));
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
//       onInit: (store) {
//         store.dispatch(BuildShareScreenStateAction(bundle: widget.bundle));
//       },
//       onWillChange: (oldVm, newVm) {
//         if (Platform.isAndroid) {
//           if (oldVm.lifecycleState != AppLifecycleState.resumed && newVm.lifecycleState == AppLifecycleState.resumed) {
//             if (_hasShared) {
//               _isLoading = true;
//               newVm.onComplete(_hasShared);
//             }
//           }
//         }
//         if (newVm.error is! IdleException) {
//           _handleError(newVm);
//         }
//       },
//       builder: (context, vm) => Stack(
//         children: [
//           Positioned.fill(
//             child: vm.isBuildingState
//                 ? Container(
//                     color: AppColorScheme.colorBlack,
//                     child: CircularLoadingIndicator(),
//                   )
//                 : _buildContent(vm),
//           ),
//           _isLoading ? CircularLoadingIndicator() : Container(),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _handleError(_ViewModel vm) async {
//     _isLoading = false;
//     vm.clearShareResultError();
//
//     final attrs = TfDialogAttributes(
//       title: "Request Failed",
//       description: vm.error.getMessage(context),
//       negativeText: S.of(context).dialog_error_recoverable_negative_text,
//       positiveText: S.of(context).all__retry,
//     );
//     final result = await TfDialog.show(context, attrs);
//     if (result is Cancel) {
//       vm.quitWorkout();
//     } else {
//       setState(() {
//         _isLoading = true;
//       });
//       vm.onComplete(_hasShared);
//     }
//   }
//
//   Widget _buildContent(_ViewModel vm) {
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(vm),
//       child: Material(
//         color: AppColorScheme.colorBlack,
//         child: SafeArea(
//           child: Column(
//             children: <Widget>[
//               _buildControllers(onCancel: () {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 vm.onComplete(_hasShared);
//               }, onShare: () {
//                 _captureShareContent().then((bytes) => _shareResults(bytes, vm)).then((value) {
//                   print("Shared successfully");
//                 }).catchError((e) {
//                   final attrs = TfDialogAttributes(title: S.of(context).share_result_error, description: e.toString());
//                   return TfDialog.show(context, attrs);
//                 });
//               }),
//               ResultWidget(
//                   workoutDuration: vm.workoutDuration,
//                   wod: vm.wodItem,
//                   wodType: vm.wodType,
//                   workoutName: vm.workoutName,
//                   totalExercises: vm.totalExercises,
//                   wodResult: vm.wodResult,
//                   roundCount: vm.roundCount,
//                   shareContentKey: _shareContentKey,
//                   imageUrl: vm.selectedImageItem.url),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                   child: StaggeredGridView.count(
//                     addAutomaticKeepAlives: false,
//                     mainAxisSpacing: 12.0,
//                     crossAxisSpacing: 12.0,
//                     padding: const EdgeInsets.only(top: 12.0),
//                     crossAxisCount: COLUMN_COUNT,
//                     staggeredTiles: vm.items.map((item) {
//                       if (item is HeaderItem) {
//                         return StaggeredTile.count(3, 0.3);
//                       } else {
//                         return StaggeredTile.count(1, 1);
//                       }
//                     }).toList(),
//                     children: vm.items.map((item) => _buildListItem(item, vm)).toList(),
//                   ),
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
//     vm.onComplete(_hasShared);
//     return Future.sync(() => false);
//   }
//
//   Widget _buildControllers({@required VoidCallback onCancel, @required VoidCallback onShare}) => Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: CupertinoButton(
//                   onPressed: onCancel,
//                   child: Text(
//                     S.of(context).not_now,
//                     style: textRegular16.copyWith(color: AppColorScheme.colorYellow),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: Text(
//                   S.of(context).exercises,
//                   style: title16.copyWith(
//                     color: AppColorScheme.colorPrimaryWhite,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//                 child: Align(
//               alignment: Alignment.centerRight,
//               child: CupertinoButton(
//                 onPressed: onShare,
//                 child: Text(
//                   S.of(context).share,
//                   style: textRegular16.copyWith(
//                     color: AppColorScheme.colorYellow,
//                   ),
//                 ),
//               ),
//             ))
//           ],
//         ),
//       );
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
//               vm.setImage(item);
//             });
//           },
//           isSelected: item == vm.selectedImageItem);
//     }
//   }
//
//   Widget _buildImagePicker(_ViewModel vm) => Material(
//         color: Colors.transparent,
//         child: ClipRRect(
//           key: ObjectKey("GALLERY_PICKER"),
//           borderRadius: BorderRadius.circular(8),
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: AppColorScheme.colorBlack2,
//                 child: Icon(
//                   Icons.add_a_photo,
//                   size: 35,
//                   color: AppColorScheme.colorBlack6,
//                 ),
//               ),
//               ClipRRect(
//                 borderRadius: new BorderRadius.circular(10),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () async {
//                       final imageSource = await showCupertinoModalPopup(
//                         context: context,
//                         builder: (context) => CupertinoActionSheet(
//                           actions: [
//                             CupertinoActionSheetAction(
//                               onPressed: () {
//                                 Navigator.of(context).pop(ImageSource.gallery);
//                               },
//                               child: Text(
//                                 S.of(context).gallery,
//                                 style: textRegular16.copyWith(
//                                   color: AppColorScheme.colorPrimaryBlack,
//                                 ),
//                               ),
//                             ),
//                             CupertinoActionSheetAction(
//                               onPressed: () {
//                                 Navigator.of(context).pop(ImageSource.camera);
//                               },
//                               child: Text(
//                                 S.of(context).camera,
//                                 style: textRegular16.copyWith(
//                                   color: AppColorScheme.colorPrimaryBlack,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                       if (imageSource != null) {
//                         _getImage(imageSource, vm);
//                       }
//                     },
//                     splashColor: AppColorScheme.colorPrimaryWhite.withOpacity(0.3),
//                     highlightColor: AppColorScheme.colorPrimaryWhite.withOpacity(0.1),
//                     child: Container(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
//
// class _ViewModel {
//   final ExerciseCategoryItem wodItem;
//   final Function(bool) onComplete;
//   final Function(ImageItem) setImage;
//   final List<dynamic> items;
//   final AppLifecycleState lifecycleState;
//   final int workoutDuration;
//   final String wodType;
//   final String workoutName;
//   final int totalExercises;
//   final int wodResult;
//   final int roundCount;
//   final Function clearShareResultError;
//   final TfException error;
//   final bool isBuildingState;
//   final ImageItem selectedImageItem;
//   final Function quitWorkout;
//
//   _ViewModel(
//       {@required this.workoutDuration,
//       @required this.setImage,
//       @required this.wodType,
//       @required this.workoutName,
//       @required this.totalExercises,
//       @required this.wodResult,
//       @required this.roundCount,
//       @required this.wodItem,
//       @required this.items,
//       @required this.clearShareResultError,
//       @required this.lifecycleState,
//       @required this.error,
//       @required this.isBuildingState,
//       @required this.selectedImageItem,
//       @required this.quitWorkout,
//       @required this.onComplete});
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//       selectedImageItem: store.state.profileShareWorkoutResultsScreenState.selectedImageItem,
//       isBuildingState: store.state.profileShareWorkoutResultsScreenState.isBuildingState,
//       workoutDuration: store.state.profileShareWorkoutResultsScreenState.workoutDuration,
//       wodType: store.state.profileShareWorkoutResultsScreenState.wodType,
//       workoutName: store.state.profileShareWorkoutResultsScreenState.workoutName,
//       totalExercises: store.state.profileShareWorkoutResultsScreenState.totalExercises,
//       wodResult: store.state.profileShareWorkoutResultsScreenState.wodResult ?? -1,
//       roundCount: store.state.profileShareWorkoutResultsScreenState.roundCount ?? -1,
//       wodItem: store.state.profileShareWorkoutResultsScreenState.wodItem,
//       items: store.state.profileShareWorkoutResultsScreenState.listItems,
//       error: store.state.profileShareWorkoutResultsScreenState.error,
//       quitWorkout: () => store.dispatch(PopScreenAction()),
//       clearShareResultError: () => store.dispatch(ClearShareErrorAction()),
//       lifecycleState: store.state.appLifecycleState,
//       setImage: (selectedImageItem) => store.dispatch(OnImageItemSelectedAction(selectedImage: selectedImageItem)),
//       onComplete: (hasShared) => store.dispatch(PopScreenAction()),
//     );
//   }
// }
//
// const COLUMN_COUNT = 3;
