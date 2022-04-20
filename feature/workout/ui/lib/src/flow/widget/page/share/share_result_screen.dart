import 'dart:typed_data';

import 'package:core/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui_kit.dart';

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_ui/src/flow/widget/page/share/widget/image_item_widget.dart';
import 'package:workout_ui/src/flow/widget/page/share/widget/result_header_item_widget.dart';

import 'package:workout_ui/src/model/share_result_data.dart';

class ShareResultScreen extends StatefulWidget {
  final ShareResultData model;
  final VoidCallback onFinish;

  const ShareResultScreen({
    Key? key,
    required this.model,
    required this.onFinish,
  }) : super(key: key);

  @override
  _ShareResultScreenState createState() => _ShareResultScreenState();
}

class _ShareResultScreenState extends State<ShareResultScreen> {
  final GlobalKey _shareContentKey = GlobalKey();
  late ImageItem _selectedItem;
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

  Future<ByteData?> _captureShareContent() async {
    RenderRepaintBoundary? boundary = _shareContentKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    ui.Image? image = await boundary?.toImage(
        pixelRatio: MediaQuery.of(context).devicePixelRatio);
    ByteData? byteData =
        await image?.toByteData(format: ui.ImageByteFormat.png);
    return byteData;
  }

  Future<void> _shareResults(ByteData byteData) async {
    final Uint8List list = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/workout_results.jpg').create();
    file.writeAsBytesSync(list);

    final channel = MethodChannel(
        Platform.isIOS ? IOS_METHOD_CHANNEL : ANDROID_METHOD_CHANNEL);
    _hasShared = await channel.invokeMethod('shareFile', file.path);

    widget.onFinish();
  }

  @override
  void initState() {
    _items.addAll(_buildGridItemList());
    //_selectedItem = ImageItem(url: widget.model.image);
    _selectedItem = ImageItem(url: _imageList.first.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Material(
      color: AppColorScheme.colorBlack,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildControllers(
              onCancel: () {
                widget.onFinish();
              },
              onShare: () {
                _captureShareContent()
                    .then((bytes) => _shareResults(bytes!))
                    .catchError(
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
            ResultHeaderItemWidget(
              image: _selectedItem.url,
              totalTime: widget.model.totalTime,
              shareContentKey: _shareContentKey,
              amrapRoundCount: widget.model.amrapRoundCount,
              forTimeRoundCount: widget.model.forTimeRoundCount,
              priorityStage: widget.model.priorityStage,
              priorityStageTime: widget.model.priorityStageTime,
              exerciseDurationMap: widget.model.priorityExercisesDurationMap,
              priorityStageType: widget.model.priorityStageType,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: StaggeredGridView.count(
                  addAutomaticKeepAlives: false,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  padding: const EdgeInsets.only(top: 12.0),
                  crossAxisCount: _columnCount,
                  staggeredTiles: _items.map((item) {
                    if (item is HeaderItem) {
                      return const StaggeredTile.count(3, 0.3);
                    } else {
                      return const StaggeredTile.count(1, 1);
                    }
                  }).toList(),
                  children: _items.map((item) => _buildListItem(item)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControllers(
          {required VoidCallback onCancel, required VoidCallback onShare}) =>
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
    final itemList = <GridItem>[
      HeaderItem(),
      GalleryPickerItem(),
      ..._imageList
    ];

    return itemList;
  }

  Widget _buildListItem(GridItem item) {
    if (item is HeaderItem) {
      return Text(
        item.getTitle(),
        style: title20.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
      );
    } else if (item is GalleryPickerItem) {
      return _buildImagePicker();
    } else {
      return ImageItemWidget(
          key: ObjectKey(item),
          item: item as ImageItem,
          onSelected: (item) {
            setState(() {
              _selectedItem = item;
            });
          },
          isSelected: item == _selectedItem);
    }
  }

  Widget _buildImagePicker() => Material(
        color: Colors.transparent,
        child: ClipRRect(
          key: const ObjectKey("GALLERY_PICKER"),
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColorScheme.colorBlack2,
                child: const Icon(
                  Icons.add_a_photo,
                  size: 35,
                  color: AppColorScheme.colorBlack6,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
}

abstract class GridItem {}

class HeaderItem implements GridItem {
  String getTitle() {
    return 'Choose or Take Photo';
  }
}

class GalleryPickerItem implements GridItem {}

class ImageItem implements GridItem {
  final String url;

  ImageItem({required this.url});
}

final List<ImageItem> _imageList = [
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

const _columnCount = 3;
