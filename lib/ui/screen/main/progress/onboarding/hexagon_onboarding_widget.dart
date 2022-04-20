import 'package:flutter/material.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';
import 'package:totalfit/ui/widgets/hexagon/rive_hexagon.dart';

class HexagonOnBoardingWidget extends StatelessWidget {
  final double body;
  final double mind;
  final double spirit;
  final bool initial;

  const HexagonOnBoardingWidget({
    @required this.body,
    @required this.mind,
    @required this.spirit,
    this.initial = true
  });

  @override
  Widget build(BuildContext context) {
    final hexSize = MediaQuery.of(context).size.width * 0.7;
    return Padding(
      padding: const EdgeInsets.only(top: 72.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Container(height: 16.0),
          RiveHexagon(
            params: toRiveHexagonParam({
              MetaHexSegment.BODY: body,
              MetaHexSegment.MIND: mind,
              MetaHexSegment.SPIRIT: spirit
            }),
            animationDelayMillis: 1500,
            width: hexSize,
            height: hexSize,
            initialy: initial,
            key: ValueKey('Today'),
          ),
        ],
      ),
    );
  }
}
