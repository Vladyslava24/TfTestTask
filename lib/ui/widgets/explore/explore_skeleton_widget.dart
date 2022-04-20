import 'package:flutter/material.dart';
import 'package:totalfit/ui/widgets/explore/explore_skeleton_slider_widget.dart';
import 'package:totalfit/ui/widgets/explore/explore_skeleton_title_widget.dart';

class ExploreSkeletonWidget extends StatelessWidget {
  const ExploreSkeletonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ExploreSkeletonTitleWidget(),
          SizedBox(height: 32.0),
          ExploreSkeletonSliderWidget(),
          SizedBox(height: 24.0),
          ExploreSkeletonSliderWidget(),
          SizedBox(height: 24.0),
          ExploreSkeletonSliderWidget()
        ],
      ),
    );
  }
}
