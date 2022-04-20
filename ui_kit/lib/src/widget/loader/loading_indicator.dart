import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ui_kit/ui_kit.dart';

class DimmedCircularLoadingIndicator extends StatelessWidget {
  const DimmedCircularLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: double.infinity,
    color: AppColorScheme.colorPrimaryBlack.withOpacity(0.5),
    child: Center(
      child: SpinKitRing(
        color: AppColorScheme.colorPrimaryWhite.withOpacity(0.6)
      )
    )
  );
}

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
    child: SpinKitRing(
      color: AppColorScheme.colorPrimaryWhite.withOpacity(0.6)));
}
