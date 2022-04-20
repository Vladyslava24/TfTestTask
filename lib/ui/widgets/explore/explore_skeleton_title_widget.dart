import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_kit/ui_kit.dart';

class ExploreSkeletonTitleWidget extends StatelessWidget {
  const ExploreSkeletonTitleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: AppColorScheme.colorBlack3,
          highlightColor: AppColorScheme.colorBlack6,
          child: Container(
            width: double.infinity,
            height: 32.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Shimmer.fromColors(
          baseColor: AppColorScheme.colorBlack3,
          highlightColor: AppColorScheme.colorBlack6,
          child: Container(
            width: double.infinity,
            height: 178.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
