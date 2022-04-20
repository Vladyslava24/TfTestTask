// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'body_mind_spirit_statistic_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BodyMindSpiritStatisticDto _$BodyMindSpiritStatisticDtoFromJson(
    Map<String, dynamic> json) {
  return _BodyMindSpiritStatisticDto.fromJson(json);
}

/// @nodoc
class _$BodyMindSpiritStatisticDtoTearOff {
  const _$BodyMindSpiritStatisticDtoTearOff();

  _BodyMindSpiritStatisticDto call(int body, int mind, int spirit) {
    return _BodyMindSpiritStatisticDto(
      body,
      mind,
      spirit,
    );
  }

  BodyMindSpiritStatisticDto fromJson(Map<String, Object?> json) {
    return BodyMindSpiritStatisticDto.fromJson(json);
  }
}

/// @nodoc
const $BodyMindSpiritStatisticDto = _$BodyMindSpiritStatisticDtoTearOff();

/// @nodoc
mixin _$BodyMindSpiritStatisticDto {
  int get body => throw _privateConstructorUsedError;
  int get mind => throw _privateConstructorUsedError;
  int get spirit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BodyMindSpiritStatisticDtoCopyWith<BodyMindSpiritStatisticDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyMindSpiritStatisticDtoCopyWith<$Res> {
  factory $BodyMindSpiritStatisticDtoCopyWith(BodyMindSpiritStatisticDto value,
          $Res Function(BodyMindSpiritStatisticDto) then) =
      _$BodyMindSpiritStatisticDtoCopyWithImpl<$Res>;
  $Res call({int body, int mind, int spirit});
}

/// @nodoc
class _$BodyMindSpiritStatisticDtoCopyWithImpl<$Res>
    implements $BodyMindSpiritStatisticDtoCopyWith<$Res> {
  _$BodyMindSpiritStatisticDtoCopyWithImpl(this._value, this._then);

  final BodyMindSpiritStatisticDto _value;
  // ignore: unused_field
  final $Res Function(BodyMindSpiritStatisticDto) _then;

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
abstract class _$BodyMindSpiritStatisticDtoCopyWith<$Res>
    implements $BodyMindSpiritStatisticDtoCopyWith<$Res> {
  factory _$BodyMindSpiritStatisticDtoCopyWith(
          _BodyMindSpiritStatisticDto value,
          $Res Function(_BodyMindSpiritStatisticDto) then) =
      __$BodyMindSpiritStatisticDtoCopyWithImpl<$Res>;
  @override
  $Res call({int body, int mind, int spirit});
}

/// @nodoc
class __$BodyMindSpiritStatisticDtoCopyWithImpl<$Res>
    extends _$BodyMindSpiritStatisticDtoCopyWithImpl<$Res>
    implements _$BodyMindSpiritStatisticDtoCopyWith<$Res> {
  __$BodyMindSpiritStatisticDtoCopyWithImpl(_BodyMindSpiritStatisticDto _value,
      $Res Function(_BodyMindSpiritStatisticDto) _then)
      : super(_value, (v) => _then(v as _BodyMindSpiritStatisticDto));

  @override
  _BodyMindSpiritStatisticDto get _value =>
      super._value as _BodyMindSpiritStatisticDto;

  @override
  $Res call({
    Object? body = freezed,
    Object? mind = freezed,
    Object? spirit = freezed,
  }) {
    return _then(_BodyMindSpiritStatisticDto(
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
@JsonSerializable()
class _$_BodyMindSpiritStatisticDto implements _BodyMindSpiritStatisticDto {
  _$_BodyMindSpiritStatisticDto(this.body, this.mind, this.spirit);

  factory _$_BodyMindSpiritStatisticDto.fromJson(Map<String, dynamic> json) =>
      _$$_BodyMindSpiritStatisticDtoFromJson(json);

  @override
  final int body;
  @override
  final int mind;
  @override
  final int spirit;

  @override
  String toString() {
    return 'BodyMindSpiritStatisticDto(body: $body, mind: $mind, spirit: $spirit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BodyMindSpiritStatisticDto &&
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
  _$BodyMindSpiritStatisticDtoCopyWith<_BodyMindSpiritStatisticDto>
      get copyWith => __$BodyMindSpiritStatisticDtoCopyWithImpl<
          _BodyMindSpiritStatisticDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BodyMindSpiritStatisticDtoToJson(this);
  }
}

abstract class _BodyMindSpiritStatisticDto
    implements BodyMindSpiritStatisticDto {
  factory _BodyMindSpiritStatisticDto(int body, int mind, int spirit) =
      _$_BodyMindSpiritStatisticDto;

  factory _BodyMindSpiritStatisticDto.fromJson(Map<String, dynamic> json) =
      _$_BodyMindSpiritStatisticDto.fromJson;

  @override
  int get body;
  @override
  int get mind;
  @override
  int get spirit;
  @override
  @JsonKey(ignore: true)
  _$BodyMindSpiritStatisticDtoCopyWith<_BodyMindSpiritStatisticDto>
      get copyWith => throw _privateConstructorUsedError;
}
