import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totalfit/ui/widgets/cards/card_chip_widget.dart';
import 'package:totalfit/utils/string_extensions.dart';
import 'package:ui_kit/ui_kit.dart';

class CardWidget extends StatelessWidget {

  final String title;
  final String image;
  final double minHeight;
  final double maxWidth;
  final List<String> chips;
  final Function action;
  final EdgeInsets margin;
  final bool premium;

  const CardWidget({
    @required this.title,
    @required this.image,
    @required this.action,
    this.minHeight = 208.0,
    this.maxWidth,
    this.chips = const [],
    this.margin = const EdgeInsets.all(0),
    this.premium = false,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: minHeight,
            maxWidth: maxWidth ?? double.infinity
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: TfImage(
                    url: image,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        AppColorScheme.colorBlack11.withOpacity(.8),
                        AppColorScheme.colorBlack11.withOpacity(0)
                      ]
                    )
                  ),
                )
              ),
              Positioned(
                left: 12.0,
                top: 12.0,
                child: premium ? Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColorScheme.colorGrey2.withOpacity(.7),
                  ),
                  child: Center(
                    child: SvgPicture.asset(icLockCircle),
                  ),
                ) : SizedBox()
              ),
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      chips.isNotEmpty ? Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        child: Wrap(
                          children: chips.asMap().entries.map((entry) {
                            final withoutDot = entry.key == chips.length - 1;
                            return CardChipWidget(
                                label: entry.value,
                                withSeparator: !withoutDot
                            );
                          }).toList()
                        ),
                      ) : SizedBox.shrink(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          title.capitalize(),
                          style: title16,
                        ),
                      ),
                    ],
                  ),
                )
              ),
              Positioned.fill(
                child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cardBorderRadius)),
                  child: InkWell(
                    onTap: action,
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    splashColor: AppColorScheme.colorYellow.withOpacity(0.15),
                    highlightColor: AppColorScheme.colorYellow.withOpacity(0.15),
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
