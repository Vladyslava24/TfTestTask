import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_kit/ui_kit.dart';

class ExploreSkeletonSliderWidget extends StatelessWidget {
  const ExploreSkeletonSliderWidget({Key key}) : super(key: key);

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
        Container(
          width: double.infinity,
          height: 208.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Shimmer.fromColors(
                baseColor: AppColorScheme.colorBlack3,
                highlightColor: AppColorScheme.colorBlack6,
                child: Container(
                  width: 168.0,
                  height: 32.0,
                  margin: EdgeInsets.only(
                    right: 16.0
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                )
              );
            },
          ),
        ),
      ],
    );
  }
}
