import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/common/countdown_widget.dart';

class CountDownPage extends StatefulWidget {
  final int count;
  final VoidCallback onNext;
  final VoidCallback startVoice;

  const CountDownPage({
    required this.startVoice,
    required this.count,
    required this.onNext,
    Key? key
  }) : super(key: key);

  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      widget.startVoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      body: CountDownWidget(
        count: widget.count,
        onCountdownFinished: () => widget.onNext(),
      ),
    );
  }
}
