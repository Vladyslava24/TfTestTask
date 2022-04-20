// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mood_state_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoodStateDto _$MoodStateDtoFromJson(Map<String, dynamic> json) {
  return _MoodStateDto.fromJson(json);
}

/// @nodoc
class _$MoodStateDtoTearOff {
  const _$MoodStateDtoTearOff();

  _MoodStateDto call(int count, String moodMame, String image) {
    return _MoodStateDto(
      count,
      moodMame,
      image,
    );
  }

  MoodStateDto fromJson(Map<String, Object?> json) {
    return MoodStateDto.fromJson(json);
  }
}

/// @nodoc
const $MoodStateDto = _$MoodStateDtoTearOff();

/// @nodoc
mixin _$MoodStateDto {
  int get count => throw _privateConstructorUsedError;
  String get moodMame => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoodStateDtoCopyWith<MoodStateDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodStateDtoCopyWith<$Res> {
  factory $MoodStateDtoCopyWith(
          MoodStateDto value, $Res Function(MoodStateDto) then) =
      _$MoodStateDtoCopyWithImpl<$Res>;
  $Res call({int count, String moodMame, String image});
}

/// @nodoc
class _$MoodStateDtoCopyWithImpl<$Res> implements $MoodStateDtoCopyWith<$Res> {
  _$MoodStateDtoCopyWithImpl(this._value, this._then);

  final MoodStateDto _value;
  // ignore: unused_field
  final $Res Function(MoodStateDto) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? moodMame = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      moodMame: moodMame == freezed
          ? _value.moodMame
          : moodMame // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MoodStateDtoCopyWith<$Res>
    implements $MoodStateDtoCopyWith<$Res> {
  factory _$MoodStateDtoCopyWith(
          _MoodStateDto value, $Res Function(_MoodStateDto) then) =
      __$MoodStateDtoCopyWithImpl<$Res>;
  @override
  $Res call({int count, String moodMame, String image});
}

/// @nodoc
class __$MoodStateDtoCopyWithImpl<$Res> extends _$MoodStateDtoCopyWithImpl<$Res>
    implements _$MoodStateDtoCopyWith<$Res> {
  __$MoodStateDtoCopyWithImpl(
      _MoodStateDto _value, $Res Function(_MoodStateDto) _then)
      : super(_value, (v) => _then(v as _MoodStateDto));

  @override
  _MoodStateDto get _value => super._value as _MoodStateDto;

  @override
  $Res call({
    Object? count = freezed,
    Object? moodMame = freezed,
    Object? image = freezed,
  }) {
    return _then(_MoodStateDto(
      count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      moodMame == freezed
          ? _value.moodMame
          : moodMame // ignore: cast_nullable_to_non_nullable
              as String,
      image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoodStateDto implements _MoodStateDto {
  _$_MoodStateDto(this.count, this.moodMame, this.image);

  factory _$_MoodStateDto.fromJson(Map<String, dynamic> json) =>
      _$$_MoodStateDtoFromJson(json);

  @override
  final int count;
  @override
  final String moodMame;
  @override
  final String image;

  @override
  String toString() {
    return 'MoodStateDto(count: $count, moodMame: $moodMame, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MoodStateDto &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.moodMame, moodMame) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(moodMame),
      const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  _$MoodStateDtoCopyWith<_MoodStateDto> get copyWith =>
      __$MoodStateDtoCopyWithImpl<_MoodStateDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoodStateDtoToJson(this);
  }
}

abstract class _MoodStateDto implements MoodStateDto {
  factory _MoodStateDto(int count, String moodMame, String image) =
      _$_MoodStateDto;

  factory _MoodStateDto.fromJson(Map<String, dynamic> json) =
      _$_MoodStateDto.fromJson;

  @override
  int get count;
  @override
  String get moodMame;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$MoodStateDtoCopyWith<_MoodStateDto> get copyWith =>
      throw _privateConstructorUsedError;
}
