import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DoneIndicator extends StatelessWidget {
  final bool isCompleted;

  DoneIndicator({@required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColorScheme.colorBlack6,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _getIcon(),
        ));
  }

  Widget _getIcon() {
    if (isCompleted) {
      return const Icon(Icons.done, color: AppColorScheme.colorPrimaryWhite);
    } else {
      return const Icon(Icons.close, color: AppColorScheme.colorPrimaryWhite);
    }
  }
}
