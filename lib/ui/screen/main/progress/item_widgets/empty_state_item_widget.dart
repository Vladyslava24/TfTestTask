import 'package:flutter/material.dart';
import 'package:totalfit/common/strings.dart';
import 'package:ui_kit/ui_kit.dart';

class EmptyStateItemWidget extends StatefulWidget {
  @override
  _EmptyStateItemWidgetState createState() => _EmptyStateItemWidgetState();
}

class _EmptyStateItemWidgetState extends State<EmptyStateItemWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30),
        TfImage(
          url: imEmptyProgressState,
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.2,
          background: Colors.transparent,
        ),
        SizedBox(height: 30),
        Opacity(
          opacity: _animation.value,
          child: Text(
            empty_state_text,
            textAlign: TextAlign.center,
            style: textRegular16.copyWith(
              color: AppColorScheme.colorBlack7,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
