import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_kit/ui_kit.dart';

class SingleWorkoutsCardSkeletonWidget extends StatelessWidget {
  const SingleWorkoutsCardSkeletonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Shimmer.fromColors(
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
    );
  }
}
