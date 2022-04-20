import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/ui/widgets/measure_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';

class WisdomOnBoardingWidget extends StatefulWidget {

  final WisdomListItem item;

  const WisdomOnBoardingWidget({this.item, Key key}) : super(key: key);

  @override
  _WisdomOnBoardingWidgetState createState() => _WisdomOnBoardingWidgetState();
}

class _WisdomOnBoardingWidgetState extends State<WisdomOnBoardingWidget> {
  double _imageHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppColorScheme.colorPurple2,
                      width: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 2.5,
                  child: Opacity(
                    opacity: widget.item.wisdomModel.isRead ? 1.0 : 0.0,
                    child: SvgPicture.asset(
                      checkIc,
                      width: 12,
                      height: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: MeasureSize(
              onChange: (size) {
                setState(() {
                  _imageHeight = size.height;
                });
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8),
                  child: Stack(
                    children: <Widget>[
                       widget.item.wisdomModel == null
                          ? Container()
                          : Align(
                        alignment: Alignment.centerRight,
                        child: _imageHeight != null
                            ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            widget.item.wisdomModel.isRead
                                ? AppColorScheme.colorPrimaryBlack
                                : Colors.transparent,
                            BlendMode.saturation,
                          ),
                          child: TfImage(
                            url: widget.item.wisdomModel.image,
                            fit: BoxFit.cover,
                            height: _imageHeight,
                            width:
                            MediaQuery.of(context).size.width,
                          ),
                        )
                            : Container(),
                      ),
                      Container(
                        height: 178,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 0),
                            stops: [
                              0.28,
                              1,
                            ],
                            colors: [
                              AppColorScheme.colorBlack2.withOpacity(0),
                              AppColorScheme.colorBlack2.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 178,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.item.wisdomModel == null
                                        ? ""
                                        : "${S.of(context).wisdom} • ${widget.item.wisdomModel.estimatedReadingTime} ${S.of(context).min_read}"
                                        .toUpperCase(),
                                    textAlign: TextAlign.left,
                                    style: textRegular10.copyWith(
                                      color: AppColorScheme.colorPrimaryWhite,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.item.wisdomModel == null
                                        ? ""
                                        : widget.item.wisdomModel.name,
                                    textAlign: TextAlign.left,
                                    style: title16.copyWith(
                                      color: AppColorScheme.colorPrimaryWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
