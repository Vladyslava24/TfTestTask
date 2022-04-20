import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';
import 'package:ui_kit/ui_kit.dart';

class BaseDownloadButton extends StatefulWidget {
  final double value;
  final String text;
  final bool textIsUppercase;
  final Color textColor;
  final EdgeInsets margin;
  final Function onPressed;
  final String fontFamily;
  final Color backgroundColor;
  final Color animationColor;
  final double height;
  final double width;
  final bool isDownloaded;

  const BaseDownloadButton({
    required this.value,
    required this.text,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.textColor = AppColorScheme.colorBlack,
    this.fontFamily = 'Gilroy',
    this.height = 48,
    this.width = double.infinity,
    this.textIsUppercase = false,
    this.backgroundColor = AppColorScheme.colorPrimaryWhite,
    this.animationColor = AppColorScheme.colorYellow,
    this.isDownloaded = false,
    Key? key,
  }) : super(key: key);

  @override
  State<BaseDownloadButton> createState() => _BaseDownloadButtonState();
}

class _BaseDownloadButtonState extends State<BaseDownloadButton> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseDownloadButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(oldWidget.value);
    print(widget.value);
    if (oldWidget.value != widget.value && oldWidget.value < widget.value) {
      controller.forward(from: oldWidget.value);
      controller.animateTo(widget.value);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: AppColorScheme.colorGreen,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: LinearProgressIndicator(
                  minHeight: widget.height,
                  value: controller.value,
                  backgroundColor: widget.isDownloaded ?
                    widget.animationColor : widget.backgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.animationColor),
                )
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    widget.textIsUppercase ? widget.text.toUpperCase() : widget.text,
                    style: Theme.of(context)
                      .elevatedButtonTheme
                      .style!
                      .textStyle!
                      .resolve(_interactiveStates)!
                      .copyWith(color: widget.textColor, fontFamily: widget.fontFamily),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

const Set<MaterialState> _interactiveStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.hovered,
  MaterialState.focused,
};
