import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_card_skeleton_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class SingleWorkoutsSkeletonWidget extends StatelessWidget {
  const SingleWorkoutsSkeletonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 12.0
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: AppColorScheme.colorBlack3,
              highlightColor: AppColorScheme.colorBlack6,
              child: Container(
                width: double.infinity,
                height: 36.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Column(
              children: List.generate(5, (index) =>
                SingleWorkoutsCardSkeletonWidget()),
            )
          ],
        ),
      ),
    );
  }
}
