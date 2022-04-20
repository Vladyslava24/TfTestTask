import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TextChangerWidget extends StatefulWidget {
  final TextConfig config;

  TextChangerWidget({this.config});

  @override
  _TextChangerWidgetState createState() => _TextChangerWidgetState();
}

class _TextChangerWidgetState extends State<TextChangerWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.config != null
        ? AnimatedOpacity(
            opacity: widget.config.isTextVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Text(
              widget.config.text,
              style: textRegular16.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          )
        : Container();
  }
}

class TextConfig {
  bool isTextVisible;
  String text;

  TextConfig(this.text, this.isTextVisible);

  void toggle(String nextText) {
    if (text == null) {
      return;
    }

    bool updatedVisibility = !isTextVisible;
    if (updatedVisibility && nextText != null) {
      text = nextText;
    }
    isTextVisible = updatedVisibility;
  }
}
