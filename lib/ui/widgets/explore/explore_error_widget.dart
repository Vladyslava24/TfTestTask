import 'package:flutter/material.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';

class ExploreErrorWidget extends StatelessWidget {
  final TfException exception;
  final bool isLoading;
  final Function reload;
  
  const ExploreErrorWidget({
    @required this.exception,
    @required this.reload,
    this.isLoading = false,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: reload,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).explore_error_title,
              style: title20
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              height: 214.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              margin: const EdgeInsets.only(bottom: 32.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColorScheme.colorBlack2
              ),
              child: isLoading ?
                CircularProgressIndicator(
                  color: AppColorScheme.colorBlack9,
                ) :
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(
                        reloadIcon
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        S.of(context).explore_error_btn_text,
                        style: textRegular16.copyWith(color: AppColorScheme.colorBlack9),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
