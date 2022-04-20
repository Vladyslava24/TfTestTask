import 'package:flutter/material.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_card_skeleton_widget.dart';

class SingleWorkoutsFilterSkeletonWidget extends StatelessWidget {
  const SingleWorkoutsFilterSkeletonWidget({Key key}) : super(key: key);

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
          children: List.generate(5, (index) =>
            SingleWorkoutsCardSkeletonWidget()),
        ),
      ),
    );
  }
}
