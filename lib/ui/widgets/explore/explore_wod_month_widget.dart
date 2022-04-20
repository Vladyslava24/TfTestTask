import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/ui/widgets/cards/card_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class ExploreWodMonthWidget extends StatelessWidget {
  final String title;
  final List<String> badges;
  final String image;
  final EdgeInsets padding;
  final Function action;
  final double minHeight;
  final bool premium;

  const ExploreWodMonthWidget({
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.minHeight = 214.0,
    @required this.title,
    @required this.image,
    @required this.badges,
    @required this.action,
    @required this.premium,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Text(
            S.of(context).explore_wod_of_month,
            style: title20
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: padding,
          child: CardWidget(
            minHeight: minHeight,
            title: title,
            image: image,
            chips: badges,
            action: action,
            premium: premium,
          ),
        ),
      ],
    );
  }
}
