import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:ui_kit/ui_kit.dart';

class HabitListItemWidget extends StatefulWidget {
  final HabitListItem item;
  final List<HabitDto> activeHabits;
  final VoidCallback openHabitPicker;
  final Function(HabitDto) onUpdateHabit;
  final bool isToday;
  final Key key;

  HabitListItemWidget({
    @required this.item,
    @required this.openHabitPicker,
    @required this.onUpdateHabit,
    @required this.isToday,
    @required this.key,
  })  : activeHabits = item.habits.where((element) => element.chosen).toList(),
        super(key: key);

  @override
  _HabitListItemWidgetState createState() => _HabitListItemWidgetState();
}

class _HabitListItemWidgetState extends State<HabitListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      child: widget.activeHabits.isEmpty
          ? _buildMainHabitItem()
          : Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 16.0, right: 16.0, bottom: 4),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(width: 28),
                      Expanded(
                        child: Text(
                          S.of(context).healthy_habits,
                          textAlign: TextAlign.left,
                          style: title16.copyWith(
                            color: AppColorScheme.colorPrimaryWhite,
                          ),
                        ),
                      ),
                      widget.isToday
                          ? GestureDetector(
                              onTap: () => widget.openHabitPicker(),
                              child: SvgPicture.asset(
                                editIc,
                                width: 24,
                                height: 24,
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Container(height: 12),
                  _buildSelectedItemsContainer(),
                ],
              ),
            ),
    );
  }

  Widget _buildSelectedItemsContainer() {
    List<Widget> items = [];
    widget.activeHabits.sort((a,b) => b.id.compareTo(a.id));
    widget.activeHabits.sort((a, b) => b.completed ? -1 : 1);
    items.addAll(widget.activeHabits.map((e) => _buildHabit(e)).toList());
    return Column(children: items);
  }

  Widget _buildHabit(HabitDto model) => Padding(
        key: ValueKey(model.id),
        padding: const EdgeInsets.only(bottom: 12.0),
        child: GestureDetector(
          onTap: () {
            widget.onUpdateHabit(model);
          },
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: model.completed
                            ? AppColorScheme.colorPurple2
                            : Colors.transparent,
                        border: Border.all(
                          color: AppColorScheme.colorPurple2,
                          width: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 2.5,
                      child: Opacity(
                        opacity: model.completed ? 1.0 : 0.0,
                        child: SvgPicture.asset(
                          checkIc,
                          width: 12,
                          height: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: Container(
                    color: AppColorScheme.colorBlack2,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      model.habit.name,
                      textAlign: TextAlign.left,
                      style: textRegular16.copyWith(
                        color: AppColorScheme.colorPrimaryWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildMainHabitItem() => Container(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            right: 16,
            bottom: 16,
            left: 12,
          ),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColorScheme.colorPurple2,
                        border: Border.all(
                          color: AppColorScheme.colorPurple2,
                          width: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: Container(
                    color: AppColorScheme.colorBlack2,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.item.habits == null
                                        ? ""
                                        : S.of(context).healthy_habits,
                                    textAlign: TextAlign.left,
                                    style: title16.copyWith(
                                      color: AppColorScheme.colorPrimaryWhite,
                                    ),
                                  ),
                                  Container(height: 4),
                                  Text(
                                    widget.item.habits == null
                                        ? ""
                                        : S.of(context).choose_track_habits,
                                    textAlign: TextAlign.left,
                                    style: textRegular16.copyWith(
                                      color: AppColorScheme.colorPrimaryWhite
                                          .withOpacity(0.65),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 7),
                            Container(
                              width: 36,
                              height: 36,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: AppColorScheme.colorBlack4,
                                    ),
                                  ),
                                  Positioned(
                                    top: 13,
                                    left: 7.25,
                                    child: SvgPicture.asset(
                                      infinityIc,
                                      width: 21,
                                      height: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: 9.5,
                                horizontal: 5,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              AppColorScheme.colorPurple2,
                            ),
                          ),
                          child: Text(
                            S.of(context).choose_habits,
                            style: title14.copyWith(
                                color: AppColorScheme.colorPrimaryWhite),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                widget.openHabitPicker();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
