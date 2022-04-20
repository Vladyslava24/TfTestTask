import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'footer_tile.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const FooterTile(child: CircularLoadingIndicator());
}
