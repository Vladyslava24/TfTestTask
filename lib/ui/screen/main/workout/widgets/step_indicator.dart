import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class StepIndicator extends StatelessWidget {
  final int index;
  final bool isCompleted;

  StepIndicator({@required this.index, @required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: new BoxDecoration(
        color: AppColorScheme.colorBlack6,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.done,
                color: AppColorScheme.colorPrimaryWhite.withOpacity(0.5))
            : Text(
                index.toString(),
                textAlign: TextAlign.left,
                style:
                    title16.copyWith(color: AppColorScheme.colorPrimaryWhite),
              ),
      ),
    );
  }
}
