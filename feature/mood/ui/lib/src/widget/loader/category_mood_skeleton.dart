import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_kit/ui_kit.dart';

class CategoryMoodSkeleton extends StatelessWidget {
  const CategoryMoodSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 5 / 6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        itemCount: 6,
        itemBuilder: (ctx, index) {
          return Shimmer.fromColors(
            baseColor: AppColorScheme.colorBlack3,
            highlightColor: AppColorScheme.colorBlack6,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cardBorderRadius),
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          );
        }
      ),
    );
  }
}
