import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:ui_kit/ui_kit.dart';

class OnboardingActionBar extends StatefulWidget {
  final String title;
  final VoidCallback onBackPressed;
  final bool showBackArrow;
  final double value;

  OnboardingActionBar(
      {@required this.title, @required this.showBackArrow, @required this.value, @required this.onBackPressed});

  @override
  _OnboardingActionBarState createState() => _OnboardingActionBarState();
}

class _OnboardingActionBarState extends State<OnboardingActionBar> {
  Artboard _riveArtBoard;
  StateMachineController _controller;
  SMIInput<double> _progress;
  Future initRive;

  @override
  void initState() {
    initRive = _initializeRive();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OnboardingActionBar oldWidget) {
    if (oldWidget.value != widget.value) {
      _progress.value = widget.value * 100;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColorScheme.colorPrimaryBlack,
      padding: EdgeInsetsDirectional.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: widget.showBackArrow
                    ? CupertinoButton(
                        child: Icon(Icons.arrow_back_ios, color: AppColorScheme.colorPrimaryWhite),
                        padding: EdgeInsets.zero,
                        onPressed: () => widget.onBackPressed())
                    : SizedBox.shrink())),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title, style: textBold16.copyWith(color: AppColorScheme.colorPrimaryWhite)),
              Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 16,
                  width: 150,
                  child: FutureBuilder<Artboard>(
                      future: initRive,
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          return Rive(artboard: snapShot.data);
                        }
                        if (snapShot.hasError) {
                          print(snapShot.error);
                        }
                        return SizedBox.shrink();
                      }))
            ],
          ),
        ),
        Expanded(child: SizedBox.shrink())
      ]),
    );
  }

  Future<Artboard> _initializeRive() async {
    return RiveController.getHexagonFile().then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;

        _controller = StateMachineController.fromArtboard(artboard, 'onboarding-progress');

        if (_controller != null) {
          artboard.addController(_controller);
          _progress = _controller.findInput('progress');
          _progress?.value = 0.1;
        }
        _riveArtBoard = artboard;
        return artboard;
      },
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }

    if (_riveArtBoard != null) {
      _riveArtBoard.remove();
    }

    super.dispose();
  }
}

class RiveController {
  static Completer<ByteData> _fileLoader;

  static Future<ByteData> getHexagonFile() async {
    if (_fileLoader == null) {
      final completer = Completer<ByteData>();
      try {
        final file = await rootBundle.load('assets/rive/onboarding_top_progress.riv');
        completer.complete(file);
      } on Exception catch (e) {
        completer.completeError(e);
        final Future<ByteData> clientFuture = completer.future;
        _fileLoader = null;
        return clientFuture;
      }
      _fileLoader = completer;
    }
    return _fileLoader.future;
  }
}
