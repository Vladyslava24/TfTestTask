import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/ui/widgets/measure_size.dart';
import 'package:ui_kit/ui_kit.dart';

class BreathingItemWidget extends StatefulWidget {
  final BreathingListItem item;
  final Function onSelected;
  final Key key;

  const BreathingItemWidget(
      {@required this.item, @required this.onSelected, @required this.key})
      : super(key: key);

  @override
  _BreathingItemWidgetState createState() => _BreathingItemWidgetState();
}

class _BreathingItemWidgetState extends State<BreathingItemWidget> {
  double _imageHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12, top: 12),
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
                    color: widget.item.breathingModel.done
                        ? AppColorScheme.colorPurple2
                        : Colors.transparent,
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
                    opacity: widget.item.breathingModel.done ? 1.0 : 0.0,
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
              onTap: widget.onSelected,
              borderRadius: BorderRadius.circular(cardBorderRadius),
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
                        Align(
                            alignment: Alignment.centerRight,
                            child: _imageHeight != null
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      widget.item.breathingModel.done
                                          ? AppColorScheme.colorPrimaryBlack
                                          : Colors.transparent,
                                      BlendMode.saturation,
                                    ),
                                    child: TfImage(
                                      url: breathingWidgetBackground,
                                      fit: BoxFit.cover,
                                      height: _imageHeight,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  )
                                : Container()),
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0, -1),
                              end: Alignment(0, 0),
                              stops: [
                                0.28,
                                1.0,
                              ],
                              colors: [
                                AppColorScheme.colorBlack2.withOpacity(0),
                                AppColorScheme.colorBlack2.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 160,
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  widget.item.breathingModel.done
                                      ? Container()
                                      : Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColorScheme
                                                  .colorPrimaryWhite),
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Icon(
                                            PlaybackIcons.play,
                                            size: 10.0,
                                            color: AppColorScheme.colorBlue,
                                          ),
                                        ),
                                  SizedBox(width: 6.0),
                                  !widget.item.breathingModel.done
                                      ? Text(
                                          S
                                              .of(context)
                                              .programs_progress__breathing_card_time,
                                          style: textRegular14)
                                      : SizedBox.shrink()
                                ],
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S
                                          .of(context)
                                          .programs_progress__breathing_card_sub,
                                      style: title14,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      S
                                          .of(context)
                                          .programs_progress__breathing_card_title,
                                      textAlign: TextAlign.left,
                                      style: title30,
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
