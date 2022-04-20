import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/workout/share/widgets.dart';
import 'package:totalfit/ui/widgets/grid_items.dart';
import 'package:ui_kit/ui_kit.dart';

import 'header_widget.dart';

class ProgramShareResultScreen extends StatefulWidget {
  final FinishProgramResponse response;

  ProgramShareResultScreen(this.response);

  @override
  _ProgramShareResultScreenState createState() =>
      _ProgramShareResultScreenState();
}

class _ProgramShareResultScreenState extends State<ProgramShareResultScreen> {
  GlobalKey _shareContentKey = GlobalKey();
  ImageItem _selectedItem;
  bool _hasShared = false;

  final _picker = ImagePicker();

  static const IOS_METHOD_CHANNEL = 'channel:com.totalfit.mobile/share';
  static const ANDROID_METHOD_CHANNEL =
      'channel:com.totalfit.mobile.android/share';
  final _items = <GridItem>[];

  Future _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedItem = ImageItem(url: pickedFile.path);
      });
    }
  }

  Future<ByteData> _captureShareContent() async {
    RenderRepaintBoundary boundary =
        _shareContentKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(
        pixelRatio: MediaQuery.of(context).devicePixelRatio);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData;
  }

  Future<void> _shareResults(ByteData byteData, _ViewModel vm) async {
    final Uint8List list = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/program_results.jpg').create();
    file.writeAsBytesSync(list);

    final channel = MethodChannel(
        Platform.isIOS ? IOS_METHOD_CHANNEL : ANDROID_METHOD_CHANNEL);
    _hasShared = await channel.invokeMethod('shareFile', file.path);
    if (Platform.isIOS) {
      vm.onProgramFinished();
    }
  }

  @override
  void initState() {
    _items.addAll(_buildGridItemList());
    _selectedItem = ImageItem(url: widget.response.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store),
        onWillChange: (oldVm, newVm) {
          if (Platform.isAndroid) {
            if (oldVm.lifecycleState != AppLifecycleState.resumed &&
                newVm.lifecycleState == AppLifecycleState.resumed) {
              if (_hasShared) {
                newVm.onProgramFinished();
              }
            }
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    return Material(
      color: AppColorScheme.colorBlack,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildControllers(
              onCancel: () {
                vm.onProgramFinished();
              },
              onShare: () {
                _captureShareContent()
                    .then((bytes) => _shareResults(bytes, vm))
                    .then((value) {
                  print("Shared successfully");
                }).catchError(
                  (e) {
                    final attrs = TfDialogAttributes(
                      title: S.of(context).share_result_error,
                      description: e.toString(),
                      positiveText: S.of(context).all__OK,
                    );
                    return TfDialog.show(context, attrs);
                  },
                );
              },
            ),
            ProgramShareResultHeaderWidget(
              shareContentKey: _shareContentKey,
              image: _selectedItem.url,
              workoutCount: widget.response.workoutsDone,
              totalExerciseCount: widget.response.exercisesDone,
              totalMinutes: widget.response.workoutsDuration,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: StaggeredGridView.count(
                  addAutomaticKeepAlives: false,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  padding: const EdgeInsets.only(top: 12.0),
                  crossAxisCount: COLUMN_COUNT,
                  staggeredTiles: _items.map((item) {
                    if (item is HeaderItem) {
                      return StaggeredTile.count(3, 0.3);
                    } else {
                      return StaggeredTile.count(1, 1);
                    }
                  }).toList(),
                  children:
                      _items.map((item) => _buildListItem(item, vm)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(GridItem item, _ViewModel vm) {
    if (item is HeaderItem) {
      return Text(
        item.getTitle(),
        style: title20.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
      );
    } else if (item is GalleryPickerItem) {
      return _buildImagePicker(vm);
    } else {
      return ImageItemWidget(
          key: ObjectKey(item),
          item: item,
          onSelected: (item) {
            setState(() {
              _selectedItem = item;
            });
          },
          isSelected: item == _selectedItem);
    }
  }

  Widget _buildImagePicker(_ViewModel vm) => Material(
        color: Colors.transparent,
        child: ClipRRect(
          key: ObjectKey("GALLERY_PICKER"),
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColorScheme.colorBlack2,
                child: Icon(Icons.add_a_photo,
                    size: 35, color: AppColorScheme.colorBlack7),
              ),
              ClipRRect(
                borderRadius: new BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final imageSource = await showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop(ImageSource.gallery);
                              },
                              child: Text(
                                S.of(context).gallery,
                                style: textRegular16.copyWith(
                                  color: AppColorScheme.colorPrimaryBlack,
                                ),
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop(ImageSource.camera);
                              },
                              child: Text(
                                S.of(context).camera,
                                style: textRegular16.copyWith(
                                  color: AppColorScheme.colorPrimaryBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      if (imageSource != null) {
                        vm.sendPickedImageEvent(imageSource);
                        _getImage(imageSource);
                      }
                    },
                    splashColor:
                        AppColorScheme.colorPrimaryWhite.withOpacity(0.3),
                    highlightColor:
                        AppColorScheme.colorPrimaryWhite.withOpacity(0.1),
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildControllers(
          {@required VoidCallback onCancel, @required VoidCallback onShare}) =>
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: CupertinoButton(
                  onPressed: onCancel,
                  child: Text(
                    S.of(context).not_now,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorYellow,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  S.of(context).sharing,
                  style: title16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: onShare,
                  child: Text(
                    S.of(context).share,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorYellow,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  List<GridItem> _buildGridItemList() {
    final itemList = <GridItem>[]
      ..add(HeaderItem())
      ..add(GalleryPickerItem())
      ..addAll(_imageList);

    return itemList;
  }
}

class _ViewModel {
  final AppLifecycleState lifecycleState;
  final Function(ImageSource) sendPickedImageEvent;
  final Function onProgramFinished;

  _ViewModel(
      {@required this.lifecycleState,
      @required this.onProgramFinished,
      @required this.sendPickedImageEvent});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        lifecycleState: store.state.appLifecycleState,
        onProgramFinished: () => store.dispatch(OnProgramFinishedAction()),
        sendPickedImageEvent: (source) =>
            store.dispatch(SendPickedImageEventAction(source)));
  }
}

final _imageList = [
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing01.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing02.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing03.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing04.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing05.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing06.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing07.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing08.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing09.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing10.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing11.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing12.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing13.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing14.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing15.jpg"
].map((imageUrl) => ImageItem(url: imageUrl)).toList();

const COLUMN_COUNT = 3;
