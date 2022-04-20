import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_kit/ui_kit.dart';

class SkeletonItemWidget extends StatelessWidget {
  const SkeletonItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8, right: 16.0),
          child: Row(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: AppColorScheme.colorBlack3,
                highlightColor: AppColorScheme.colorBlack6,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    color: Colors.white,
                  ),
                )
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: AppColorScheme.colorBlack3,
                  highlightColor: AppColorScheme.colorBlack6,
                  child: Container(
                    width: double.infinity,
                    height: 24.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cardBorderRadius),
                      color: Colors.white,
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 16.0, left: 8.0, right: 16.0, bottom: 20.0),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: AppColorScheme.colorBlack3,
                highlightColor: AppColorScheme.colorBlack6,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    color: Colors.white,
                  ),
                )
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: AppColorScheme.colorBlack3,
                  highlightColor: AppColorScheme.colorBlack6,
                  child: Container(
                    height: 178,
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(cardBorderRadius),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0, right: 16.0, bottom: 20.0),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: AppColorScheme.colorBlack3,
                highlightColor: AppColorScheme.colorBlack6,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    color: Colors.white,
                  ),
                )
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: AppColorScheme.colorBlack3,
                  highlightColor: AppColorScheme.colorBlack6,
                  child: Container(
                    height: 178,
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(cardBorderRadius),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
