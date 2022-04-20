// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mood_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MoodStateTearOff {
  const _$MoodStateTearOff();

  _MoodState call(int count, String moodMame, String image) {
    return _MoodState(
      count,
      moodMame,
      image,
    );
  }
}

/// @nodoc
const $MoodState = _$MoodStateTearOff();

/// @nodoc
mixin _$MoodState {
  int get count => throw _privateConstructorUsedError;
  String get moodMame => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoodStateCopyWith<MoodState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodStateCopyWith<$Res> {
  factory $MoodStateCopyWith(MoodState value, $Res Function(MoodState) then) =
      _$MoodStateCopyWithImpl<$Res>;
  $Res call({int count, String moodMame, String image});
}

/// @nodoc
class _$MoodStateCopyWithImpl<$Res> implements $MoodStateCopyWith<$Res> {
  _$MoodStateCopyWithImpl(this._value, this._then);

  final MoodState _value;
  // ignore: unused_field
  final $Res Function(MoodState) _then;

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
abstract class _$MoodStateCopyWith<$Res> implements $MoodStateCopyWith<$Res> {
  factory _$MoodStateCopyWith(
          _MoodState value, $Res Function(_MoodState) then) =
      __$MoodStateCopyWithImpl<$Res>;
  @override
  $Res call({int count, String moodMame, String image});
}

/// @nodoc
class __$MoodStateCopyWithImpl<$Res> extends _$MoodStateCopyWithImpl<$Res>
    implements _$MoodStateCopyWith<$Res> {
  __$MoodStateCopyWithImpl(_MoodState _value, $Res Function(_MoodState) _then)
      : super(_value, (v) => _then(v as _MoodState));

  @override
  _MoodState get _value => super._value as _MoodState;

  @override
  $Res call({
    Object? count = freezed,
    Object? moodMame = freezed,
    Object? image = freezed,
  }) {
    return _then(_MoodState(
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

class _$_MoodState implements _MoodState {
  _$_MoodState(this.count, this.moodMame, this.image);

  @override
  final int count;
  @override
  final String moodMame;
  @override
  final String image;

  @override
  String toString() {
    return 'MoodState(count: $count, moodMame: $moodMame, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MoodState &&
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
  _$MoodStateCopyWith<_MoodState> get copyWith =>
      __$MoodStateCopyWithImpl<_MoodState>(this, _$identity);
}

abstract class _MoodState implements MoodState {
  factory _MoodState(int count, String moodMame, String image) = _$_MoodState;

  @override
  int get count;
  @override
  String get moodMame;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$MoodStateCopyWith<_MoodState> get copyWith =>
      throw _privateConstructorUsedError;
}
