import 'package:flutter/cupertino.dart';
import 'package:core/generated/l10n.dart';

class DayOfWeek {
  static const _MON_KEY = "MON";
  static const _TUE_KEY = "TUE";
  static const _WED_KEY = "WED";
  static const _THU_KEY = "THU";
  static const _FRI_KEY = "FRI";
  static const _SAT_KEY = "SAT";
  static const _SUN_KEY = "SUN";

  static const MONDAY = DayOfWeek._(key: _MON_KEY);
  static const TUESDAY = DayOfWeek._(key: _TUE_KEY);
  static const WEDNESDAY = DayOfWeek._(key: _WED_KEY);
  static const THURSDAY = DayOfWeek._(key: _THU_KEY);
  static const FRIDAY = DayOfWeek._(key: _FRI_KEY);
  static const SATURDAY = DayOfWeek._(key: _SAT_KEY);
  static const SUNDAY = DayOfWeek._(key: _SUN_KEY);

  static const LIST = const [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY];

  final String key;

  int index() => LIST.indexOf(this);

  const DayOfWeek._({
    @required this.key,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is DayOfWeek && key == other.key;

  @override
  int get hashCode => key.hashCode;

  String stringValue(BuildContext context) {
    if (key == _MON_KEY) {
      return S.of(context).choose_program_days__monday;
    }
    if (key == _TUE_KEY) {
      return S.of(context).choose_program_days__tuesday;
    }
    if (key == _WED_KEY) {
      return S.of(context).choose_program_days__wednesday;
    }
    if (key == _THU_KEY) {
      return S.of(context).choose_program_days__thursday;
    }
    if (key == _FRI_KEY) {
      return S.of(context).choose_program_days__friday;
    }
    if (key == _SAT_KEY) {
      return S.of(context).choose_program_days__saturday;
    }

    return S.of(context).choose_program_days__sunday;
  }
}
