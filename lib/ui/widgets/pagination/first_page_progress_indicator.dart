import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class FirstPageProgressIndicator extends StatelessWidget {

  const FirstPageProgressIndicator();

  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.all(32), child: const CircularLoadingIndicator());
}
