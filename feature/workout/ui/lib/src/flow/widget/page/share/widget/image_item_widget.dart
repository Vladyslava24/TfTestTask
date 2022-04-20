import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/page/share/share_result_screen.dart';

class ImageItemWidget extends StatefulWidget {
  final ImageItem item;
  final bool isSelected;
  final Function(ImageItem) onSelected;

  const ImageItemWidget(
      {required this.item,
      required this.isSelected,
      required this.onSelected,
      Key? key})
      : super(key: key);

  @override
  _ImageItemWidgetState createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        key: ObjectKey(widget.item.url),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: AppColorScheme.colorBlack2,
          child: Stack(
            children: <Widget>[
              TfImage(url: widget.item.url, dim: Colors.transparent),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onSelected(widget.item),
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
      ),
    );
  }
}
