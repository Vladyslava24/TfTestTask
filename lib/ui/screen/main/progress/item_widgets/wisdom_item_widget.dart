import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/ui/widgets/measure_size.dart';
import 'package:ui_kit/ui_kit.dart';

class WisdomListItemWidget extends StatefulWidget {
  final WisdomListItem item;
  final VoidCallback onSelected;
  final Key key;

  WisdomListItemWidget({
    @required this.item,
    @required this.onSelected,
    @required this.key,
  }) : super(key: key);

  @override
  _WisdomListItemWidgetState createState() => _WisdomListItemWidgetState();
}

class _WisdomListItemWidgetState extends State<WisdomListItemWidget> {
  double _imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_buildTitle(), _buildContent()],
      ),
    );
  }

  Widget _buildTitle() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              mindHexIc,
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context).grow_your_mind,
              textAlign: TextAlign.left,
              style: title20.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
                letterSpacing: 0.015,
              ),
            ),
          ],
        ),
      );

  Widget _buildContent() {
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
                    color: widget.item.wisdomModel.isRead ? AppColorScheme.colorPurple2 : Colors.transparent,
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
            child: InkWell(
              onTap: () {
                if (widget.item.wisdomModel != null) {
                  widget.onSelected();
                }
              },
              child: MeasureSize(
                onChange: (size) {
                  setState(() {
                    _imageHeight = size.height;
                  });
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
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
                                          width: MediaQuery.of(context).size.width,
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
                                      widget.item.wisdomModel == null ? "" : widget.item.wisdomModel.name,
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
          ),
        ],
      ),
    );
  }
}
