import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';


class SingleWorkoutsNotFoundWidget extends StatelessWidget {
  final Function callback;

  SingleWorkoutsNotFoundWidget({
    this.callback,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorScheme.colorBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(searchIcon),
                  const SizedBox(height: 15.0),
                  Text(
                    S.of(context).no_workouts_found,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorBlack9,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: callback,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      S.of(context).reset_all_filters,
                      style: title16.copyWith(
                        color: AppColorScheme.colorBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.5),
              ],
            )
          ],
        ),
      ),
    );
  }
}
