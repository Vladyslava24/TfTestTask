import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TitleCategoryWidget extends StatelessWidget {
  final String title;
  final String textButton;
  final Function actionButton;

  const TitleCategoryWidget({
    @required this.title,
    @required this.textButton,
    @required this.actionButton,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: title20,
          ),
          GestureDetector(
            onTap: actionButton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textButton,
                  style: textRegular16.copyWith(
                    color: AppColorScheme.colorYellow
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColorScheme.colorYellow,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
