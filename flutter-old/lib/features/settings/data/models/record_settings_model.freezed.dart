// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecordSettingsModel {
  int get fps => throw _privateConstructorUsedError;
  bool get holdToRecord => throw _privateConstructorUsedError;
  SecondsModel get delay => throw _privateConstructorUsedError;
  SecondsModel get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordSettingsModelCopyWith<RecordSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordSettingsModelCopyWith<$Res> {
  factory $RecordSettingsModelCopyWith(
          RecordSettingsModel value, $Res Function(RecordSettingsModel) then) =
      _$RecordSettingsModelCopyWithImpl<$Res, RecordSettingsModel>;
  @useResult
  $Res call(
      {int fps, bool holdToRecord, SecondsModel delay, SecondsModel duration});
}

/// @nodoc
class _$RecordSettingsModelCopyWithImpl<$Res, $Val extends RecordSettingsModel>
    implements $RecordSettingsModelCopyWith<$Res> {
  _$RecordSettingsModelCopyWithImpl(this._value, this._then);

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
              as SecondsModel,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as SecondsModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordSettingsModelCopyWith<$Res>
    implements $RecordSettingsModelCopyWith<$Res> {
  factory _$$_RecordSettingsModelCopyWith(_$_RecordSettingsModel value,
          $Res Function(_$_RecordSettingsModel) then) =
      __$$_RecordSettingsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int fps, bool holdToRecord, SecondsModel delay, SecondsModel duration});
}

/// @nodoc
class __$$_RecordSettingsModelCopyWithImpl<$Res>
    extends _$RecordSettingsModelCopyWithImpl<$Res, _$_RecordSettingsModel>
    implements _$$_RecordSettingsModelCopyWith<$Res> {
  __$$_RecordSettingsModelCopyWithImpl(_$_RecordSettingsModel _value,
      $Res Function(_$_RecordSettingsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fps = null,
    Object? holdToRecord = null,
    Object? delay = null,
    Object? duration = null,
  }) {
    return _then(_$_RecordSettingsModel(
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
              as SecondsModel,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as SecondsModel,
    ));
  }
}

/// @nodoc

class _$_RecordSettingsModel implements _RecordSettingsModel {
  const _$_RecordSettingsModel(
      {required this.fps,
      required this.holdToRecord,
      required this.delay,
      required this.duration});

  @override
  final int fps;
  @override
  final bool holdToRecord;
  @override
  final SecondsModel delay;
  @override
  final SecondsModel duration;

  @override
  String toString() {
    return 'RecordSettingsModel(fps: $fps, holdToRecord: $holdToRecord, delay: $delay, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordSettingsModel &&
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
  _$$_RecordSettingsModelCopyWith<_$_RecordSettingsModel> get copyWith =>
      __$$_RecordSettingsModelCopyWithImpl<_$_RecordSettingsModel>(
          this, _$identity);
}

abstract class _RecordSettingsModel implements RecordSettingsModel {
  const factory _RecordSettingsModel(
      {required final int fps,
      required final bool holdToRecord,
      required final SecondsModel delay,
      required final SecondsModel duration}) = _$_RecordSettingsModel;

  @override
  int get fps;
  @override
  bool get holdToRecord;
  @override
  SecondsModel get delay;
  @override
  SecondsModel get duration;
  @override
  @JsonKey(ignore: true)
  _$$_RecordSettingsModelCopyWith<_$_RecordSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
