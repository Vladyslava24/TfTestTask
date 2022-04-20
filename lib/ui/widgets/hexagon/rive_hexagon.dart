import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:rive/rive.dart';
import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';

class RiveHexagon extends StatefulWidget {
  final Map<HexagonParam, int> params;
  final int animationDelayMillis;
  final double width;
  final double height;
  final Key key;
  final bool initialy;

  const RiveHexagon({
    @required this.params,
    @required this.animationDelayMillis,
    @required this.width,
    @required this.height,
    @required this.key,
    @required this.initialy,
  });

  @override
  _RiveHexagonState createState() => _RiveHexagonState();
}

class _RiveHexagonState extends State<RiveHexagon>
    with TickerProviderStateMixin {
  Artboard _riveArtBoard;

  StateMachineController _controller;

  SMIInput<bool> _start;
  SMIInput<double> _mind;
  SMIInput<double> _spirit;
  SMIInput<double> _body;
  SMIInput<double> _bodyExtra;
  SMIInput<double> _mindExtra;
  SMIInput<double> _spiritExtra;

  AnimationController _animationController;

  int _animationDuration = 1500;
  int _bodyEnvironmentRange = 0;
  int _socialIntellectualRange = 0;
  int _spiritualEmotionalRange = 0;

  double _recentBodyEnvironment = 0;
  double _recentSocialIntellectual = 0;
  double _recentSpiritualEmotional = 0;

  void _animate() async {
    if(_animationController == null) {
      return;
    }
    _animationController.duration = Duration(milliseconds: _animationDuration);
    _animationController.stop(canceled: true);
    try {
      _animationController?.forward(from: 0.0);
      _start?.value = true;
    } catch (e) {
      print(e);
    }
  }

  void _initializeRive() async {
    await RiveController.getHexagonFile().then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;

        _controller = StateMachineController.fromArtboard(
          artboard,
          'Hexagon',
        );

        if (_controller != null) {
          artboard.addController(_controller);
          _start = _controller.findInput('start');
          _mind = _controller.findInput('mind-percent');
          _spirit = _controller.findInput('spirit-percent');
          _body = _controller.findInput('body-percent');
          _bodyExtra = _controller.findInput('extra-body-percent');
          _mindExtra = _controller.findInput('extra-mind-percent');
          _spiritExtra = _controller.findInput('extra-spirit-percent');
          _body?.value = 0.1;
          _mind?.value = 0.1;
          _spirit?.value = 0.1;
          _bodyExtra?.value = 0.0;
          _mindExtra?.value = 0.0;
          _spiritExtra?.value = 0.0;
        }

        setState(() {
          _riveArtBoard = artboard;
          if (widget.params[HexagonParam.bodyEnvironment] == 0) {
            _recentBodyEnvironment = 0.1;
          }
          if (widget.params[HexagonParam.socialIntellectual] == 0) {
            _recentSocialIntellectual = 0.1;
          }
          if (widget.params[HexagonParam.spiritualEmotional] == 0) {
            _recentSpiritualEmotional = 0.1;
          }

          _bodyEnvironmentRange = widget.params[HexagonParam.bodyEnvironment];
          _socialIntellectualRange =
              widget.params[HexagonParam.socialIntellectual];
          _spiritualEmotionalRange =
              widget.params[HexagonParam.spiritualEmotional];
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(milliseconds: _animationDuration), () {});
        });

        _animationController = AnimationController(
            duration: Duration(milliseconds: _animationDuration), vsync: this);
        final _bodyAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.0, 0.7, curve: Curves.easeInOut)));
        final _mindAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.1, 0.85, curve: Curves.easeInOut)));
        final _spiritAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.2, 1.0, curve: Curves.easeInOut)));

        _animationController.addListener(() {
          _body?.value = _recentBodyEnvironment +
            _bodyAnimation.value * (_bodyEnvironmentRange);
          _bodyExtra?.value = _body.value > 100.0 ? _body.value - 100.0 : 0;
          _mind?.value = _recentSocialIntellectual +
            _mindAnimation.value * (_socialIntellectualRange);
          _mindExtra?.value = _mind.value > 100.0 ? _mind.value - 100.0 : 0;
          _spirit?.value = _recentSpiritualEmotional +
            _spiritAnimation.value * (_spiritualEmotionalRange);
          _spiritExtra?.value = _spirit.value > 100.0 ?
            _spirit.value - 100.0 : 0;
        });

        if (widget.initialy) {
          _animate();
        }
      },
    );
  }

  @override
  void initState() {
    _initializeRive();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RiveHexagon oldWidget) {
    if (oldWidget.params != widget.params) {
      _animationDuration = widget.animationDelayMillis;
      _recentBodyEnvironment = oldWidget.params.values.elementAt(0) != 0
          ? oldWidget.params.values.elementAt(0).toDouble()
          : 0.1;
      _recentSocialIntellectual = oldWidget.params.values.elementAt(1) != 0
          ? oldWidget.params.values.elementAt(1).toDouble()
          : 0.1;
      _recentSpiritualEmotional = oldWidget.params.values.elementAt(2) != 0
          ? oldWidget.params.values.elementAt(2).toDouble()
          : 0.1;
      _bodyEnvironmentRange = widget.params.values.elementAt(0) -
          oldWidget.params.values.elementAt(0);
      _socialIntellectualRange = widget.params.values.elementAt(1) -
          oldWidget.params.values.elementAt(1);
      _spiritualEmotionalRange = widget.params.values.elementAt(2) -
          oldWidget.params.values.elementAt(2);
      _animate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _riveArtBoard.remove();
    _start?.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) => SizedBox(
        key: ValueKey(widget.key),
        child: _riveArtBoard != null ?
          Rive(artboard: _riveArtBoard) : Container(),
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}

class _ViewModel {
  final HexagonState hs;
  final int index;

  _ViewModel({@required this.hs, @required this.index});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      hs: store
        .state
        .mainPageState
        .progressPages[store.state.mainPageState.progressPageIndex]
        .hexagonState,
      index: store.state.mainPageState.progressPageIndex
    );
  }
}

class RiveController {
  static Completer<ByteData> _hexagonFileLoader;

  static Future<ByteData> getHexagonFile() async {
    if (_hexagonFileLoader == null) {
      final completer = Completer<ByteData>();
      try {
        final file = await rootBundle.load('assets/rive/hexagon.riv');
        completer.complete(file);
      } on Exception catch (e) {
        completer.completeError(e);
        final Future<ByteData> clientFuture = completer.future;
        _hexagonFileLoader = null;
        return clientFuture;
      }
      _hexagonFileLoader = completer;
    }
    return _hexagonFileLoader.future;
  }
}
