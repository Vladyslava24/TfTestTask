// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'header_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HeaderItemTearOff {
  const _$HeaderItemTearOff();

  _HeaderItem call({User? user}) {
    return _HeaderItem(
      user: user,
    );
  }
}

/// @nodoc
const $HeaderItem = _$HeaderItemTearOff();

/// @nodoc
mixin _$HeaderItem {
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HeaderItemCopyWith<HeaderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeaderItemCopyWith<$Res> {
  factory $HeaderItemCopyWith(
          HeaderItem value, $Res Function(HeaderItem) then) =
      _$HeaderItemCopyWithImpl<$Res>;
  $Res call({User? user});
}

/// @nodoc
class _$HeaderItemCopyWithImpl<$Res> implements $HeaderItemCopyWith<$Res> {
  _$HeaderItemCopyWithImpl(this._value, this._then);

  final HeaderItem _value;
  // ignore: unused_field
  final $Res Function(HeaderItem) _then;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
abstract class _$HeaderItemCopyWith<$Res> implements $HeaderItemCopyWith<$Res> {
  factory _$HeaderItemCopyWith(
          _HeaderItem value, $Res Function(_HeaderItem) then) =
      __$HeaderItemCopyWithImpl<$Res>;
  @override
  $Res call({User? user});
}

/// @nodoc
class __$HeaderItemCopyWithImpl<$Res> extends _$HeaderItemCopyWithImpl<$Res>
    implements _$HeaderItemCopyWith<$Res> {
  __$HeaderItemCopyWithImpl(
      _HeaderItem _value, $Res Function(_HeaderItem) _then)
      : super(_value, (v) => _then(v as _HeaderItem));

  @override
  _HeaderItem get _value => super._value as _HeaderItem;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_HeaderItem(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_HeaderItem implements _HeaderItem {
  const _$_HeaderItem({this.user});

  @override
  final User? user;

  @override
  String toString() {
    return 'HeaderItem(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HeaderItem &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$HeaderItemCopyWith<_HeaderItem> get copyWith =>
      __$HeaderItemCopyWithImpl<_HeaderItem>(this, _$identity);
}

abstract class _HeaderItem implements HeaderItem {
  const factory _HeaderItem({User? user}) = _$_HeaderItem;

  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$HeaderItemCopyWith<_HeaderItem> get copyWith =>
      throw _privateConstructorUsedError;
}
