import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:totalfit/data/dto/mood_dto.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:collection/collection.dart';
import 'package:mood_api/mood_api.dart';

class MoodListItemWidget extends StatelessWidget {
  final List<MoodDTO> item;
  final bool isToday;

  const MoodListItemWidget({
    @required this.item,
    this.isToday = false,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 12.0,
        right: 16.0,
        bottom: 12.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.isEmpty && isToday ?
            _MoodDefaultStateWidget() : _MoodFilledStateWidget(
              list: item,
              isToday: isToday
          )
        ],
      ),
    );
  }
}

class _MoodFilledStateWidget extends StatefulWidget {

  final List<MoodDTO> list;
  final bool isToday;

  const _MoodFilledStateWidget({
    @required this.list,
    this.isToday = false,
    Key key
  }) : super(key: key);

  @override
  State<_MoodFilledStateWidget> createState() => _MoodFilledStateWidgetState();
}

class _MoodFilledStateWidgetState extends State<_MoodFilledStateWidget> {

  List<Widget> _moodList = [];

  @override
  void initState() {
    super.initState();
    generateMoodList();
  }

  @override
  void didUpdateWidget(covariant _MoodFilledStateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.list != widget.list) {
      generateMoodList();
    }
  }

  void generateMoodList() {
    setState(() {
      _moodList.clear();
      if (widget.isToday) {
        _moodList.add(_AddMoodWidget());
      }
      _moodList.addAll(
        widget.list.mapIndexed((i, e) {
            return _MoodItemWidget(
              emoji: e.emoji,
              text: e.feelingName,
              time: e.time,
              leftMargin: !widget.isToday && i == 0
            );
          }
        ).toList()
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _moodList.isNotEmpty ? Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          child: _moodList.isNotEmpty && !widget.isToday ?
          const _MoodCircleRoundWidget.done() :
          const _MoodCircleRoundWidget.filled(),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(cardBorderRadius),
                child:
                Container(
                  height: 130.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: AppColorScheme.colorBlack2,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          S.of(context)
                            .progress_screen_mood_card_title
                            .toUpperCase(),
                          textAlign: TextAlign.left,
                          style: textRegular10.copyWith(
                            letterSpacing: 0.05,
                            color:
                            AppColorScheme.colorPrimaryWhite,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        height: 76.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _moodList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _moodList[index];
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ) : const SizedBox.shrink();
  }
}

class _AddMoodWidget extends StatelessWidget {

  const _AddMoodWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModelAddMoodWidget>(
      distinct: true,
      converter: (store) => _ViewModelAddMoodWidget.fromStore(store),
      builder: (context, vm) =>
        GestureDetector(
          onTap: () async {
            final result =
              await Navigator.of(context).pushNamed(MoodRoute.moodScreen);
            if (result != null) {
              vm.onUpdateMoodTracking(result);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12.0, left: 16.0),
            width: 70.0,
            height: 76.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardBorderRadius),
              color: AppColorScheme.colorBlack3,
            ),
            child: Center(
              child: SvgPicture.asset(
                addIcon,
                width: 33.0,
                height: 33.0,
              ),
            ),
          ),
        )
    );
  }
}

class _ViewModelAddMoodWidget {
  final Function(dynamic) onUpdateMoodTracking;

  _ViewModelAddMoodWidget({
    @required this.onUpdateMoodTracking
  });

  static _ViewModelAddMoodWidget fromStore(Store<AppState> store) =>
    _ViewModelAddMoodWidget(
      onUpdateMoodTracking: (model) =>
        store.dispatch(UpdateMoodTracking(model: MoodDTO.fromJson(model))));
}

class _MoodItemWidget extends StatelessWidget {
  final String emoji;
  final String text;
  final String time;
  final bool leftMargin;

  const _MoodItemWidget({
    @required this.emoji,
    @required this.text,
    @required this.time,
    this.leftMargin = false,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.0, left: leftMargin ? 16.0 : 0.0),
      width: 70.0,
      height: 76.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardBorderRadius),
        color: AppColorScheme.colorBlack3,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            String.fromCharCode(int.parse(emoji, radix: 16)),
            style: TextStyle(fontSize: 24.0)
          ),
          const SizedBox(height: 4.0),
          Text(
            text,
            style: textRegular10.copyWith(color: AppColorScheme.colorPrimaryWhite)
          ),
          Text(
            time,
            style: textRegular10.copyWith(color: AppColorScheme.colorBlack7)
          )
        ],
      ),
    );
  }
}

class _MoodDefaultStateWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModelMoodDefaultWidget>(
      distinct: true,
      converter: (store) => _ViewModelMoodDefaultWidget.fromStore(store),
      builder: (context, vm) => Row(
        children: [
          Container(
            width: 16.0,
            height: 16.0,
            child: const _MoodCircleRoundWidget.circle(),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  onTap: () async {
                    final result = await Navigator.of(context).pushNamed(MoodRoute.moodScreen);
                    if (result != null) {
                      vm.onUpdateMoodTracking(result);
                    }
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(cardBorderRadius),
                      child: Stack(
                        fit: StackFit.loose,
                        clipBehavior: Clip.hardEdge,
                        children: <Widget>[
                          Container(
                            height: 123.0,
                            decoration: BoxDecoration(
                              color: AppColorScheme.colorBlack2
                            ),
                          ),
                          Container(
                            height: 123.0,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  S.of(context)
                                    .progress_screen_mood_card_title
                                    .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: textRegular10.copyWith(
                                    letterSpacing: 0.05,
                                    color:
                                    AppColorScheme.colorPrimaryWhite,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  S.of(context)
                                    .progress_screen_mood_card_description,
                                  textAlign: TextAlign.left,
                                  style: title16.copyWith(
                                    color:
                                    AppColorScheme.colorPrimaryWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -25.0,
                            top: -35.0,
                            child: TfImage(
                              width: 140.0,
                              height: 140.0,
                              url: moodTrackingCardBg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

class _ViewModelMoodDefaultWidget {
  final Function(dynamic) onUpdateMoodTracking;

  _ViewModelMoodDefaultWidget({
    @required this.onUpdateMoodTracking
  });

  static _ViewModelMoodDefaultWidget fromStore(Store<AppState> store) =>
      _ViewModelMoodDefaultWidget(
        onUpdateMoodTracking: (model) =>
          store.dispatch(UpdateMoodTracking(model: MoodDTO.fromJson(model))));
}

class _MoodCircleRoundWidget extends StatelessWidget {

  final Color color;
  final bool done;

  const _MoodCircleRoundWidget.circle({
    this.color = Colors.transparent,
    this.done = false
  });

  const _MoodCircleRoundWidget.filled({
    this.color = AppColorScheme.colorBlue2,
    this.done = false
  });

  const _MoodCircleRoundWidget.done({
    this.color = AppColorScheme.colorBlue2,
    this.done = true
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: color,
            border: Border.all(
              color: AppColorScheme.colorBlue2,
              width: 2.0,
            ),
          ),
        ),
        Positioned(
          top: 4.0,
          left: 2.5,
          child: Opacity(
            opacity: done ? 1.0 : 0.0,
            child: SvgPicture.asset(
              checkIc,
              width: 12.0,
              height: 9.0,
            ),
          ),
        ),
      ]
    );
  }
}