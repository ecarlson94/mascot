// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecordSettings {
  int get fps => throw _privateConstructorUsedError;
  bool get holdToRecord => throw _privateConstructorUsedError;
  Seconds get delay => throw _privateConstructorUsedError;
  Seconds get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordSettingsCopyWith<RecordSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordSettingsCopyWith<$Res> {
  factory $RecordSettingsCopyWith(
          RecordSettings value, $Res Function(RecordSettings) then) =
      _$RecordSettingsCopyWithImpl<$Res, RecordSettings>;
  @useResult
  $Res call({int fps, bool holdToRecord, Seconds delay, Seconds duration});
}

/// @nodoc
class _$RecordSettingsCopyWithImpl<$Res, $Val extends RecordSettings>
    implements $RecordSettingsCopyWith<$Res> {
  _$RecordSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fps = null,
    Object? holdToRecord = null,
    Object? delay = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      fps: null == fps
          ? _value.fps
          : fps // ignore: cast_nullable_to_non_nullable
              as int,
      holdToRecord: null == holdToRecord
          ? _value.holdToRecord
          : holdToRecord // ignore: cast_nullable_to_non_nullable
              as bool,
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as Seconds,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Seconds,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordSettingsCopyWith<$Res>
    implements $RecordSettingsCopyWith<$Res> {
  factory _$$_RecordSettingsCopyWith(
          _$_RecordSettings value, $Res Function(_$_RecordSettings) then) =
      __$$_RecordSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fps, bool holdToRecord, Seconds delay, Seconds duration});
}

/// @nodoc
class __$$_RecordSettingsCopyWithImpl<$Res>
    extends _$RecordSettingsCopyWithImpl<$Res, _$_RecordSettings>
    implements _$$_RecordSettingsCopyWith<$Res> {
  __$$_RecordSettingsCopyWithImpl(
      _$_RecordSettings _value, $Res Function(_$_RecordSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fps = null,
    Object? holdToRecord = null,
    Object? delay = null,
    Object? duration = null,
  }) {
    return _then(_$_RecordSettings(
      fps: null == fps
          ? _value.fps
          : fps // ignore: cast_nullable_to_non_nullable
              as int,
      holdToRecord: null == holdToRecord
          ? _value.holdToRecord
          : holdToRecord // ignore: cast_nullable_to_non_nullable
              as bool,
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as Seconds,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Seconds,
    ));
  }
}

/// @nodoc

class _$_RecordSettings implements _RecordSettings {
  const _$_RecordSettings(
      {required this.fps,
      required this.holdToRecord,
      required this.delay,
      required this.duration});

  @override
  final int fps;
  @override
  final bool holdToRecord;
  @override
  final Seconds delay;
  @override
  final Seconds duration;

  @override
  String toString() {
    return 'RecordSettings(fps: $fps, holdToRecord: $holdToRecord, delay: $delay, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordSettings &&
            (identical(other.fps, fps) || other.fps == fps) &&
            (identical(other.holdToRecord, holdToRecord) ||
                other.holdToRecord == holdToRecord) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fps, holdToRecord, delay, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordSettingsCopyWith<_$_RecordSettings> get copyWith =>
      __$$_RecordSettingsCopyWithImpl<_$_RecordSettings>(this, _$identity);
}

abstract class _RecordSettings implements RecordSettings {
  const factory _RecordSettings(
      {required final int fps,
      required final bool holdToRecord,
      required final Seconds delay,
      required final Seconds duration}) = _$_RecordSettings;

  @override
  int get fps;
  @override
  bool get holdToRecord;
  @override
  Seconds get delay;
  @override
  Seconds get duration;
  @override
  @JsonKey(ignore: true)
  _$$_RecordSettingsCopyWith<_$_RecordSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
