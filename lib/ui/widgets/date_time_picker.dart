import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class DateTimePicker {
  static Future<List<int>> show(BuildContext context) async {
    final dateMap = _buildDateMap();
    final timeMap = _buildTimeMap();
    final data = [dateMap.values.toList(), timeMap.values.toList()];
    final result = await Picker(
      backgroundColor: AppColorScheme.colorBlack2,
      onConfirm: (p, s) {},
      onCancel: () {},
      textStyle:
          textRegular14.copyWith(color: AppColorScheme.colorPrimaryWhite),
      adapter: PickerDataAdapter<String>(pickerdata: data, isArray: true),
      hideHeader: false,
      builderHeader: (context) => Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.of(context).workout_schedule_pop_title,
            textAlign: TextAlign.center,
            style: title16.copyWith(color: AppColorScheme.colorPrimaryWhite),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Text(
            S.of(context).workout_schedule_pop_sub_title,
            textAlign: TextAlign.center,
            style: textRegular16.copyWith(color: AppColorScheme.colorBlack9),
          ),
        )
      ]),
      height: 185,
      selecteds: [0, 37],
      selectedTextStyle:
          title14.copyWith(color: AppColorScheme.colorPrimaryWhite),
      itemExtent: 30,
      columnPadding: EdgeInsets.zero,
      cancelText: S.of(context).all__skip.toUpperCase(),
      cancelTextStyle:
          textRegular16.copyWith(color: AppColorScheme.colorBlack9),
      confirmText:
          S.of(context).workout_schedule_pop_confirm_text.toUpperCase(),
      confirmTextStyle:
          textRegular16.copyWith(color: AppColorScheme.colorYellow),
    ).showDialog(context);
    if (result == null) {
      return null;
    }

    final pickedDate = dateMap.keys.toList()[result[0]];
    final pickedTime = timeMap.keys.toList()[result[1]];

    return [pickedDate, pickedTime];
  }

  static const _firstDateItem = 'Tomorrow';

  static Map<int, String> _buildDateMap() {
    Map<int, String> dates = {};

    const String DATE_FORMAT = 'MMMM dd';
    int now = DateTime.now().millisecondsSinceEpoch;

    for (int i = 1; i < 31; i++) {
      int millis = now + i * DAY_IN_MILLIS;
      if (dates.isEmpty) {
        dates.putIfAbsent(millis, () => _firstDateItem);
      } else {
        final formattedDate = DateFormat(DATE_FORMAT)
            .format(DateTime.fromMillisecondsSinceEpoch(millis));
        dates.putIfAbsent(millis, () => formattedDate);
      }
    }

    return dates;
  }

  static const _seconds15 = 15 * 1000;

  static Map<int, String> _buildTimeMap() {
    Map<int, String> items = {};
    int curr = 0;
    String time;

    while (time != '23:45') {
      time = timeFromDuration(Duration(milliseconds: curr));
      items.putIfAbsent(curr, () => time);
      curr += _seconds15;
    }

    return items;
  }
}
