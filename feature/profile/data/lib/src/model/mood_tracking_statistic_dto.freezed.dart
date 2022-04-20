// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mood_tracking_statistic_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MoodTrackingStatisticDtoTearOff {
  const _$MoodTrackingStatisticDtoTearOff();

  _MoodTrackingStatisticDto call(List<MoodItemDto> items) {
    return _MoodTrackingStatisticDto(
      items,
    );
  }
}

/// @nodoc
const $MoodTrackingStatisticDto = _$MoodTrackingStatisticDtoTearOff();

/// @nodoc
mixin _$MoodTrackingStatisticDto {
  List<MoodItemDto> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoodTrackingStatisticDtoCopyWith<MoodTrackingStatisticDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodTrackingStatisticDtoCopyWith<$Res> {
  factory $MoodTrackingStatisticDtoCopyWith(MoodTrackingStatisticDto value,
          $Res Function(MoodTrackingStatisticDto) then) =
      _$MoodTrackingStatisticDtoCopyWithImpl<$Res>;
  $Res call({List<MoodItemDto> items});
}

/// @nodoc
class _$MoodTrackingStatisticDtoCopyWithImpl<$Res>
    implements $MoodTrackingStatisticDtoCopyWith<$Res> {
  _$MoodTrackingStatisticDtoCopyWithImpl(this._value, this._then);

  final MoodTrackingStatisticDto _value;
  // ignore: unused_field
  final $Res Function(MoodTrackingStatisticDto) _then;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MoodItemDto>,
    ));
  }
}

/// @nodoc
abstract class _$MoodTrackingStatisticDtoCopyWith<$Res>
    implements $MoodTrackingStatisticDtoCopyWith<$Res> {
  factory _$MoodTrackingStatisticDtoCopyWith(_MoodTrackingStatisticDto value,
          $Res Function(_MoodTrackingStatisticDto) then) =
      __$MoodTrackingStatisticDtoCopyWithImpl<$Res>;
  @override
  $Res call({List<MoodItemDto> items});
}

/// @nodoc
class __$MoodTrackingStatisticDtoCopyWithImpl<$Res>
    extends _$MoodTrackingStatisticDtoCopyWithImpl<$Res>
    implements _$MoodTrackingStatisticDtoCopyWith<$Res> {
  __$MoodTrackingStatisticDtoCopyWithImpl(_MoodTrackingStatisticDto _value,
      $Res Function(_MoodTrackingStatisticDto) _then)
      : super(_value, (v) => _then(v as _MoodTrackingStatisticDto));

  @override
  _MoodTrackingStatisticDto get _value =>
      super._value as _MoodTrackingStatisticDto;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_MoodTrackingStatisticDto(
      items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MoodItemDto>,
    ));
  }
}

/// @nodoc

class _$_MoodTrackingStatisticDto implements _MoodTrackingStatisticDto {
  _$_MoodTrackingStatisticDto(this.items);

  @override
  final List<MoodItemDto> items;

  @override
  String toString() {
    return 'MoodTrackingStatisticDto(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MoodTrackingStatisticDto &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$MoodTrackingStatisticDtoCopyWith<_MoodTrackingStatisticDto> get copyWith =>
      __$MoodTrackingStatisticDtoCopyWithImpl<_MoodTrackingStatisticDto>(
          this, _$identity);
}

abstract class _MoodTrackingStatisticDto implements MoodTrackingStatisticDto {
  factory _MoodTrackingStatisticDto(List<MoodItemDto> items) =
      _$_MoodTrackingStatisticDto;

  @override
  List<MoodItemDto> get items;
  @override
  @JsonKey(ignore: true)
  _$MoodTrackingStatisticDtoCopyWith<_MoodTrackingStatisticDto> get copyWith =>
      throw _privateConstructorUsedError;
}

MoodItemDto _$MoodItemDtoFromJson(Map<String, dynamic> json) {
  return _MoodItemDto.fromJson(json);
}

/// @nodoc
class _$MoodItemDtoTearOff {
  const _$MoodItemDtoTearOff();

  _MoodItemDto call(String date, StatisticMeasure measureType,
      List<MoodStateDto> moodStates) {
    return _MoodItemDto(
      date,
      measureType,
      moodStates,
    );
  }

  MoodItemDto fromJson(Map<String, Object?> json) {
    return MoodItemDto.fromJson(json);
  }
}

/// @nodoc
const $MoodItemDto = _$MoodItemDtoTearOff();

/// @nodoc
mixin _$MoodItemDto {
  String get date => throw _privateConstructorUsedError;
  StatisticMeasure get measureType => throw _privateConstructorUsedError;
  List<MoodStateDto> get moodStates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoodItemDtoCopyWith<MoodItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodItemDtoCopyWith<$Res> {
  factory $MoodItemDtoCopyWith(
          MoodItemDto value, $Res Function(MoodItemDto) then) =
      _$MoodItemDtoCopyWithImpl<$Res>;
  $Res call(
      {String date,
      StatisticMeasure measureType,
      List<MoodStateDto> moodStates});
}

/// @nodoc
class _$MoodItemDtoCopyWithImpl<$Res> implements $MoodItemDtoCopyWith<$Res> {
  _$MoodItemDtoCopyWithImpl(this._value, this._then);

  final MoodItemDto _value;
  // ignore: unused_field
  final $Res Function(MoodItemDto) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? measureType = freezed,
    Object? moodStates = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      measureType: measureType == freezed
          ? _value.measureType
          : measureType // ignore: cast_nullable_to_non_nullable
              as StatisticMeasure,
      moodStates: moodStates == freezed
          ? _value.moodStates
          : moodStates // ignore: cast_nullable_to_non_nullable
              as List<MoodStateDto>,
    ));
  }
}

/// @nodoc
abstract class _$MoodItemDtoCopyWith<$Res>
    implements $MoodItemDtoCopyWith<$Res> {
  factory _$MoodItemDtoCopyWith(
          _MoodItemDto value, $Res Function(_MoodItemDto) then) =
      __$MoodItemDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String date,
      StatisticMeasure measureType,
      List<MoodStateDto> moodStates});
}

/// @nodoc
class __$MoodItemDtoCopyWithImpl<$Res> extends _$MoodItemDtoCopyWithImpl<$Res>
    implements _$MoodItemDtoCopyWith<$Res> {
  __$MoodItemDtoCopyWithImpl(
      _MoodItemDto _value, $Res Function(_MoodItemDto) _then)
      : super(_value, (v) => _then(v as _MoodItemDto));

  @override
  _MoodItemDto get _value => super._value as _MoodItemDto;

  @override
  $Res call({
    Object? date = freezed,
    Object? measureType = freezed,
    Object? moodStates = freezed,
  }) {
    return _then(_MoodItemDto(
      date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      measureType == freezed
          ? _value.measureType
          : measureType // ignore: cast_nullable_to_non_nullable
              as StatisticMeasure,
      moodStates == freezed
          ? _value.moodStates
          : moodStates // ignore: cast_nullable_to_non_nullable
              as List<MoodStateDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoodItemDto implements _MoodItemDto {
  _$_MoodItemDto(this.date, this.measureType, this.moodStates);

  factory _$_MoodItemDto.fromJson(Map<String, dynamic> json) =>
      _$$_MoodItemDtoFromJson(json);

  @override
  final String date;
  @override
  final StatisticMeasure measureType;
  @override
  final List<MoodStateDto> moodStates;

  @override
  String toString() {
    return 'MoodItemDto(date: $date, measureType: $measureType, moodStates: $moodStates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MoodItemDto &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.measureType, measureType) &&
            const DeepCollectionEquality()
                .equals(other.moodStates, moodStates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(measureType),
      const DeepCollectionEquality().hash(moodStates));

  @JsonKey(ignore: true)
  @override
  _$MoodItemDtoCopyWith<_MoodItemDto> get copyWith =>
      __$MoodItemDtoCopyWithImpl<_MoodItemDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoodItemDtoToJson(this);
  }
}

abstract class _MoodItemDto implements MoodItemDto {
  factory _MoodItemDto(String date, StatisticMeasure measureType,
      List<MoodStateDto> moodStates) = _$_MoodItemDto;

  factory _MoodItemDto.fromJson(Map<String, dynamic> json) =
      _$_MoodItemDto.fromJson;

  @override
  String get date;
  @override
  StatisticMeasure get measureType;
  @override
  List<MoodStateDto> get moodStates;
  @override
  @JsonKey(ignore: true)
  _$MoodItemDtoCopyWith<_MoodItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}
