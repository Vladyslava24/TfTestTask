import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class HabitList extends StatefulWidget {
  final List<HabitDto> list;
  final Function(HabitDto) onHabitPressed;
  final int activatedCount;

  HabitList(
      {@required this.list,
      @required this.onHabitPressed,
      @required this.activatedCount,
      @required Key key})
      : super(key: key);

  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList>
    with AutomaticKeepAliveClientMixin {
  HabitDto _tippedHabit;

  _handleToolTip(bool isToolTipAllowed, HabitDto habit) async {
    if (_tippedHabit != null) {
      return;
    }
    if (isToolTipAllowed) {
      _tippedHabit = habit;
      await Future.delayed(Duration(milliseconds: 2500), () {
        if (mounted) {
          setState(() {
            _tippedHabit = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Container(
        color: AppColorScheme.colorBlack,
        child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return Material(
              color: AppColorScheme.colorBlack,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tippedHabit = null;
                  });
                  if (widget.list[index].chosen || widget.activatedCount < 3) {
                    final habit = widget.list[index];
                    if (widget.activatedCount == 0) {
                      _handleToolTip(true, habit);
                    }
                    widget.onHabitPressed(habit);
                  } else {
                    _handleToolTip(true, widget.list[index]);
                  }
                },
                child: _buildHabitWidget(widget.list[index]),
              ),
            );
          },
        ),
      );

  Widget _buildHabitWidget(HabitDto model) {
    return SimpleTooltip(
      animationDuration: Duration.zero,
      tooltipDirection: TooltipDirection.down,
      borderColor: Colors.transparent,
      maxWidth: MediaQuery.of(context).size.width * 0.8,
      arrowTipDistance: -12,
      arrowLength: 12,
      hideOnTooltipTap: true,
      ballonPadding: EdgeInsets.all(0),
      content: Material(
        child: Text(
          S.of(context).you_can_choose_two_more_habits,
          textAlign: TextAlign.center,
          style: textRegular16.copyWith(
            color: AppColorScheme.colorBlack5,
          ),
        ),
      ),
      show: _tippedHabit == model,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColorScheme.colorBlack2,
            borderRadius: BorderRadius.circular(cardBorderRadius),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: model.chosen
                          ? AppColorScheme.colorPurple2
                          : AppColorScheme.colorBlack4,
                      shape: BoxShape.circle),
                  child: model.chosen
                      ? Icon(
                          Icons.done,
                          size: 25,
                          color: AppColorScheme.colorBlack2,
                        )
                      : Container()),
              Container(width: 12),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      model.recommended
                          ? Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: Text(
                                S
                                    .of(context)
                                    .monthly_community_habit
                                    .toUpperCase(),
                                style: textRegular10.copyWith(
                                  color: AppColorScheme.colorPurple2,
                                ),
                              ),
                            )
                          : Container(),
                      Text(
                        model.habit.name,
                        textAlign: TextAlign.left,
                        style: textRegular14.copyWith(
                            color: AppColorScheme.colorPrimaryWhite),
                      ),
                    ],
                  ),
                ),
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

class _ViewModel {
  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
