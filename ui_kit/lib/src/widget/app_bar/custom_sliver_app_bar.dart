import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/widget/app_bar/sliver_app_bar_2.dart';
import 'package:ui_kit/ui_kit.dart';


class CustomSliverAppBar extends StatefulWidget {
  final Widget backButtonIcon;
  final Widget sliverContent;
  final Widget? extraOverlayContent;
  final String appBarTitle;
  final String collapsingTitle;
  final String imageUrl;
  final double zeroOpacityOffset;

  const CustomSliverAppBar({
    Key? key,
    required this.backButtonIcon,
    required this.sliverContent,
    required this.imageUrl,
    this.extraOverlayContent,
    this.appBarTitle = "",
    this.collapsingTitle = "",
    this.zeroOpacityOffset = 0,
  }) : super(key: key);

  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  double _offset = 0;
  late double _statusBarHeight;
  late double _fullOpacityOffset;
  ScrollController _controller = ScrollController();
  final ValueNotifier<double> _opacityNotifier = ValueNotifier<double>(0);

  @override
  initState() {
    super.initState();
    _controller.addListener(_setOffset);
  }

  @override
  void didChangeDependencies() {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _fullOpacityOffset = 175 - (_statusBarHeight + kToolbarHeight);
    super.didChangeDependencies();
  }

  @override
  dispose() {
    _controller.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = _controller.offset;
    });
  }

  double _calculateOpacity() {
    if (_fullOpacityOffset == widget.zeroOpacityOffset)
      return 1;
    else if (_fullOpacityOffset > widget.zeroOpacityOffset) {
      // fading in
      if (_offset <= widget.zeroOpacityOffset)
        return 0;
      else if (_offset >= _fullOpacityOffset)
        return 1;
      else
        return (_offset - widget.zeroOpacityOffset) / (_fullOpacityOffset - widget.zeroOpacityOffset);
    } else {
      // fading out
      if (_offset <= _fullOpacityOffset)
        return 1;
      else if (_offset >= widget.zeroOpacityOffset)
        return 0;
      else {
        return (_offset - _fullOpacityOffset) / (widget.zeroOpacityOffset - _fullOpacityOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _opacityNotifier.value = _calculateOpacity();
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverAppBar2(
              brightness: Brightness.dark,
              opacityNotifier: _opacityNotifier,
              expandedHeight: 181,
              leading: widget.backButtonIcon,
              backgroundColor: AppColorScheme.colorBlack.withOpacity(0.6),
              floating: false,
              pinned: true,
              snap: false,
              centerTitle: true,
              title: Opacity(
                opacity: _opacityNotifier.value,
                child: Text(
                  widget.appBarTitle,
                  style: title16.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    TfImage(
                      url: widget.imageUrl,
                      dim: AppColorScheme.colorPrimaryBlack,
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                          Colors.transparent,
                          AppColorScheme.colorBlack,
                        ]),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16),
                      child: Text(
                        widget.collapsingTitle,
                        style: title20.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.sliverContent,
          ],
        ),
        widget.extraOverlayContent ?? SizedBox.shrink(),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0 * _opacityNotifier.value, sigmaY: 10.0 * _opacityNotifier.value),
            child: Container(
              height: _statusBarHeight,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
