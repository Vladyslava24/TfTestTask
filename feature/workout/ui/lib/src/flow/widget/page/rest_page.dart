import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_page_list_item/exercises_item_widget.dart';
import 'package:workout_ui/src/flow/workout_flow_cubit.dart';
import 'package:workout_ui/src/model/summary_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_use_case/use_case.dart';

class _Constants {
  static const double nextStageLeftPadding = 16.0;
  static const double bottomSheetHeaderPaddingTop = 16.0;
  static const double bottomSheetHeaderTitleHeight = 16.0;
  static const double bottomSheetHeaderMaximizerPaddingBottom = 22.0;
  static const double bottomSheetHeaderPaddingBottom = 6.0;
  static const double bottomSheetHeaderMaximizerHeight = 5;
  static const double bottomSheetHeaderHeight = bottomSheetHeaderPaddingTop +
      bottomSheetHeaderMaximizerPaddingBottom +
      bottomSheetHeaderMaximizerHeight +
      bottomSheetHeaderPaddingBottom +
      bottomSheetHeaderTitleHeight;
}

class RestPage extends StatefulWidget {
  final VoidCallback onRestEnd;
  final WorkoutStage? nextStage;
  final int restTimeMillis;
  final bool showTimer;
  final List<ExercisesItem>? nextStageExercises;
  final MapEntry<String, String>? quote;

  const RestPage(
      {required this.onRestEnd,
      required this.restTimeMillis,
      required this.nextStage,
      this.nextStageExercises,
      this.showTimer = true,
      this.quote,
      Key? key})
      : super(key: key);

  @override
  _RestPageState createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  late Stream _timer;
  String _restTime = "30:00";
  StreamSubscription? _streamSubscription;
  int _passedTime = 0;

  bool isPaused = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isPaused = context.watch<WorkoutFlowCubit>().state.isPaused;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  @override
  void initState() {
    _restTime = timeFromMilliseconds(widget.restTimeMillis);

    if (widget.showTimer) {
      _initTimer();
    }
    super.initState();
  }

  _initTimer() {
    _timer = Stream.periodic(const Duration(milliseconds: 1000));
    _streamSubscription = _timer.listen((event) {
      if (isPaused) return;

      if (_passedTime >= widget.restTimeMillis) {
        _streamSubscription?.cancel();
        widget.onRestEnd();
        _passedTime = 0;
      } else {
        _passedTime += 1000;
        setState(() {
          _restTime = timeFromMilliseconds(widget.restTimeMillis - _passedTime);
        });
      }
    });
  }

  Widget _buildContent() {
    return Theme(
      data: Theme.of(context).copyWith(
          bottomSheetTheme: Theme.of(context)
              .bottomSheetTheme
              .copyWith(backgroundColor: Colors.transparent)),
      child: Scaffold(
          backgroundColor: AppColorScheme.colorBlack,
          bottomSheet: _buildBottomSheet(),
          body: widget.nextStageExercises == null
              ? _buildInnerRest()
              : _buildOuterRest()),
    );
  }

  Widget _buildInnerRest() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).rest,
                style:
                    title16.copyWith(color: AppColorScheme.colorPrimaryWhite)),
            Container(height: 16),
            widget.showTimer
                ? Text(
                    _restTime,
                    style: title40.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  )
                : Container()
          ],
        ),
      ],
    );
  }

  Widget _buildOuterRest() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 96),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(S.of(context).rest,
                    style: title16.copyWith(
                        color: AppColorScheme.colorPrimaryWhite)),
                Container(height: 16),
                widget.showTimer
                    ? Text(
                        _restTime,
                        style: title40.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      )
                    : Container(),
                Container(height: 16),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColorScheme.colorBlack2,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(quotationMarkIcon)),
                        const SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Column(
                           // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.quote?.key ?? "",
                                maxLines: 99,
                                overflow: TextOverflow.ellipsis,
                                style: title16.copyWith(
                                    color: AppColorScheme.colorPrimaryWhite),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.quote?.value ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textRegular12.copyWith(
                                      color: AppColorScheme.colorBlack8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildBottomSheet() {
    if (widget.nextStageExercises == null) {
      return null;
    }

    double _getHeight(int itemCount) {
      final height = (ExercisesItemWidget.itemHeight * itemCount +
              _Constants.bottomSheetHeaderHeight) /
          MediaQuery.of(context).size.height;
      return height >= 1.0 ? 1.0 : height;
    }

    final listWidgets = <Widget>[
      _buildBottomSheetHeader(),
      ...widget.nextStageExercises!.map((item) => ExercisesItemWidget(
            image: item.image,
            name: item.name,
            duration: item.duration,
          ))
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
      child: DraggableScrollableSheet(
        maxChildSize: _getHeight(widget.nextStageExercises!.length),
        minChildSize: _getHeight(1),
        initialChildSize: widget.nextStageExercises!.length >= 2
            ? _getHeight(2)
            : _getHeight(widget.nextStageExercises!.length),
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: AppColorScheme.colorBlack2,
            child: ScrollConfiguration(
              behavior: _NoGlowBehavior(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: listWidgets,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomSheetHeader() {
    return Container(
      padding: const EdgeInsets.only(
        top: _Constants.bottomSheetHeaderPaddingTop,
        bottom: _Constants.bottomSheetHeaderPaddingBottom,
      ),
      height: _Constants.bottomSheetHeaderHeight,
      child: Column(
        children: [
          Center(
              child: SvgPicture.asset(maximizerIcon,
                  height: _Constants.bottomSheetHeaderMaximizerHeight)),
          const SizedBox(
              height: _Constants.bottomSheetHeaderMaximizerPaddingBottom),
          Container(
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(left: _Constants.nextStageLeftPadding),
            height: _Constants.bottomSheetHeaderTitleHeight,
            child: Text(
              'Next: ${fromWorkoutStageEnumToString(widget.nextStage ?? WorkoutStage.IDLE)}',
              style: textBold16,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

class _NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
