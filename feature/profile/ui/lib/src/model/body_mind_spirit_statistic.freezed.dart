// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'body_mind_spirit_statistic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BodyMindSpiritStatisticTearOff {
  const _$BodyMindSpiritStatisticTearOff();

  _BodyMindSpiritStatistic call(int body, int mind, int spirit) {
    return _BodyMindSpiritStatistic(
      body,
      mind,
      spirit,
    );
  }
}

/// @nodoc
const $BodyMindSpiritStatistic = _$BodyMindSpiritStatisticTearOff();

/// @nodoc
mixin _$BodyMindSpiritStatistic {
  int get body => throw _privateConstructorUsedError;
  int get mind => throw _privateConstructorUsedError;
  int get spirit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BodyMindSpiritStatisticCopyWith<BodyMindSpiritStatistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyMindSpiritStatisticCopyWith<$Res> {
  factory $BodyMindSpiritStatisticCopyWith(BodyMindSpiritStatistic value,
          $Res Function(BodyMindSpiritStatistic) then) =
      _$BodyMindSpiritStatisticCopyWithImpl<$Res>;
  $Res call({int body, int mind, int spirit});
}

/// @nodoc
class _$BodyMindSpiritStatisticCopyWithImpl<$Res>
    implements $BodyMindSpiritStatisticCopyWith<$Res> {
  _$BodyMindSpiritStatisticCopyWithImpl(this._value, this._then);

  final BodyMindSpiritStatistic _value;
  // ignore: unused_field
  final $Res Function(BodyMindSpiritStatistic) _then;

  @override
  $Res call({
    Object? body = freezed,
    Object? mind = freezed,
    Object? spirit = freezed,
  }) {
    return _then(_value.copyWith(
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as int,
      mind: mind == freezed
          ? _value.mind
          : mind // ignore: cast_nullable_to_non_nullable
              as int,
      spirit: spirit == freezed
          ? _value.spirit
          : spirit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$BodyMindSpiritStatisticCopyWith<$Res>
    implements $BodyMindSpiritStatisticCopyWith<$Res> {
  factory _$BodyMindSpiritStatisticCopyWith(_BodyMindSpiritStatistic value,
          $Res Function(_BodyMindSpiritStatistic) then) =
      __$BodyMindSpiritStatisticCopyWithImpl<$Res>;
  @override
  $Res call({int body, int mind, int spirit});
}

/// @nodoc
class __$BodyMindSpiritStatisticCopyWithImpl<$Res>
    extends _$BodyMindSpiritStatisticCopyWithImpl<$Res>
    implements _$BodyMindSpiritStatisticCopyWith<$Res> {
  __$BodyMindSpiritStatisticCopyWithImpl(_BodyMindSpiritStatistic _value,
      $Res Function(_BodyMindSpiritStatistic) _then)
      : super(_value, (v) => _then(v as _BodyMindSpiritStatistic));

  @override
  _BodyMindSpiritStatistic get _value =>
      super._value as _BodyMindSpiritStatistic;

  @override
  $Res call({
    Object? body = freezed,
    Object? mind = freezed,
    Object? spirit = freezed,
  }) {
    return _then(_BodyMindSpiritStatistic(
      body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as int,
      mind == freezed
          ? _value.mind
          : mind // ignore: cast_nullable_to_non_nullable
              as int,
      spirit == freezed
          ? _value.spirit
          : spirit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_BodyMindSpiritStatistic implements _BodyMindSpiritStatistic {
  const _$_BodyMindSpiritStatistic(this.body, this.mind, this.spirit);

  @override
  final int body;
  @override
  final int mind;
  @override
  final int spirit;

  @override
  String toString() {
    return 'BodyMindSpiritStatistic(body: $body, mind: $mind, spirit: $spirit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BodyMindSpiritStatistic &&
            const DeepCollectionEquality().equals(other.body, body) &&
            const DeepCollectionEquality().equals(other.mind, mind) &&
            const DeepCollectionEquality().equals(other.spirit, spirit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(mind),
      const DeepCollectionEquality().hash(spirit));

  @JsonKey(ignore: true)
  @override
  _$BodyMindSpiritStatisticCopyWith<_BodyMindSpiritStatistic> get copyWith =>
      __$BodyMindSpiritStatisticCopyWithImpl<_BodyMindSpiritStatistic>(
          this, _$identity);
}

abstract class _BodyMindSpiritStatistic implements BodyMindSpiritStatistic {
  const factory _BodyMindSpiritStatistic(int body, int mind, int spirit) =
      _$_BodyMindSpiritStatistic;

  @override
  int get body;
  @override
  int get mind;
  @override
  int get spirit;
  @override
  @JsonKey(ignore: true)
  _$BodyMindSpiritStatisticCopyWith<_BodyMindSpiritStatistic> get copyWith =>
      throw _privateConstructorUsedError;
}
