// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Settings {
  int? get favoriteMascotId => throw _privateConstructorUsedError;
  DecibelLufs get talkingThreshold => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call({int? favoriteMascotId, DecibelLufs talkingThreshold});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteMascotId = freezed,
    Object? talkingThreshold = null,
  }) {
    return _then(_value.copyWith(
      favoriteMascotId: freezed == favoriteMascotId
          ? _value.favoriteMascotId
          : favoriteMascotId // ignore: cast_nullable_to_non_nullable
              as int?,
      talkingThreshold: null == talkingThreshold
          ? _value.talkingThreshold
          : talkingThreshold // ignore: cast_nullable_to_non_nullable
              as DecibelLufs,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$$_SettingsCopyWith(
          _$_Settings value, $Res Function(_$_Settings) then) =
      __$$_SettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? favoriteMascotId, DecibelLufs talkingThreshold});
}

/// @nodoc
class __$$_SettingsCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$_Settings>
    implements _$$_SettingsCopyWith<$Res> {
  __$$_SettingsCopyWithImpl(
      _$_Settings _value, $Res Function(_$_Settings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteMascotId = freezed,
    Object? talkingThreshold = null,
  }) {
    return _then(_$_Settings(
      favoriteMascotId: freezed == favoriteMascotId
          ? _value.favoriteMascotId
          : favoriteMascotId // ignore: cast_nullable_to_non_nullable
              as int?,
      talkingThreshold: null == talkingThreshold
          ? _value.talkingThreshold
          : talkingThreshold // ignore: cast_nullable_to_non_nullable
              as DecibelLufs,
    ));
  }
}

/// @nodoc

class _$_Settings implements _Settings {
  const _$_Settings(
      {required this.favoriteMascotId, required this.talkingThreshold});

  @override
  final int? favoriteMascotId;
  @override
  final DecibelLufs talkingThreshold;

  @override
  String toString() {
    return 'Settings(favoriteMascotId: $favoriteMascotId, talkingThreshold: $talkingThreshold)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Settings &&
            (identical(other.favoriteMascotId, favoriteMascotId) ||
                other.favoriteMascotId == favoriteMascotId) &&
            (identical(other.talkingThreshold, talkingThreshold) ||
                other.talkingThreshold == talkingThreshold));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, favoriteMascotId, talkingThreshold);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      __$$_SettingsCopyWithImpl<_$_Settings>(this, _$identity);
}

abstract class _Settings implements Settings {
  const factory _Settings(
      {required final int? favoriteMascotId,
      required final DecibelLufs talkingThreshold}) = _$_Settings;

  @override
  int? get favoriteMascotId;
  @override
  DecibelLufs get talkingThreshold;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}
