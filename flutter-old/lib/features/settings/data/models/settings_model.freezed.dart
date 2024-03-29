// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsModel {
  int get id => throw _privateConstructorUsedError;
  int? get favoriteMascotId => throw _privateConstructorUsedError;
  double get talkingThresholdDecibels => throw _privateConstructorUsedError;
  RecordSettingsModel get recordSettings => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) then) =
      _$SettingsModelCopyWithImpl<$Res, SettingsModel>;
  @useResult
  $Res call(
      {int id,
      int? favoriteMascotId,
      double talkingThresholdDecibels,
      RecordSettingsModel recordSettings});

  $RecordSettingsModelCopyWith<$Res> get recordSettings;
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res, $Val extends SettingsModel>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? favoriteMascotId = freezed,
    Object? talkingThresholdDecibels = null,
    Object? recordSettings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteMascotId: freezed == favoriteMascotId
          ? _value.favoriteMascotId
          : favoriteMascotId // ignore: cast_nullable_to_non_nullable
              as int?,
      talkingThresholdDecibels: null == talkingThresholdDecibels
          ? _value.talkingThresholdDecibels
          : talkingThresholdDecibels // ignore: cast_nullable_to_non_nullable
              as double,
      recordSettings: null == recordSettings
          ? _value.recordSettings
          : recordSettings // ignore: cast_nullable_to_non_nullable
              as RecordSettingsModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecordSettingsModelCopyWith<$Res> get recordSettings {
    return $RecordSettingsModelCopyWith<$Res>(_value.recordSettings, (value) {
      return _then(_value.copyWith(recordSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SettingsModelCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$$_SettingsModelCopyWith(
          _$_SettingsModel value, $Res Function(_$_SettingsModel) then) =
      __$$_SettingsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? favoriteMascotId,
      double talkingThresholdDecibels,
      RecordSettingsModel recordSettings});

  @override
  $RecordSettingsModelCopyWith<$Res> get recordSettings;
}

/// @nodoc
class __$$_SettingsModelCopyWithImpl<$Res>
    extends _$SettingsModelCopyWithImpl<$Res, _$_SettingsModel>
    implements _$$_SettingsModelCopyWith<$Res> {
  __$$_SettingsModelCopyWithImpl(
      _$_SettingsModel _value, $Res Function(_$_SettingsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? favoriteMascotId = freezed,
    Object? talkingThresholdDecibels = null,
    Object? recordSettings = null,
  }) {
    return _then(_$_SettingsModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteMascotId: freezed == favoriteMascotId
          ? _value.favoriteMascotId
          : favoriteMascotId // ignore: cast_nullable_to_non_nullable
              as int?,
      talkingThresholdDecibels: null == talkingThresholdDecibels
          ? _value.talkingThresholdDecibels
          : talkingThresholdDecibels // ignore: cast_nullable_to_non_nullable
              as double,
      recordSettings: null == recordSettings
          ? _value.recordSettings
          : recordSettings // ignore: cast_nullable_to_non_nullable
              as RecordSettingsModel,
    ));
  }
}

/// @nodoc

class _$_SettingsModel implements _SettingsModel {
  const _$_SettingsModel(
      {required this.id,
      required this.favoriteMascotId,
      required this.talkingThresholdDecibels,
      required this.recordSettings});

  @override
  final int id;
  @override
  final int? favoriteMascotId;
  @override
  final double talkingThresholdDecibels;
  @override
  final RecordSettingsModel recordSettings;

  @override
  String toString() {
    return 'SettingsModel(id: $id, favoriteMascotId: $favoriteMascotId, talkingThresholdDecibels: $talkingThresholdDecibels, recordSettings: $recordSettings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.favoriteMascotId, favoriteMascotId) ||
                other.favoriteMascotId == favoriteMascotId) &&
            (identical(
                    other.talkingThresholdDecibels, talkingThresholdDecibels) ||
                other.talkingThresholdDecibels == talkingThresholdDecibels) &&
            (identical(other.recordSettings, recordSettings) ||
                other.recordSettings == recordSettings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, favoriteMascotId,
      talkingThresholdDecibels, recordSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsModelCopyWith<_$_SettingsModel> get copyWith =>
      __$$_SettingsModelCopyWithImpl<_$_SettingsModel>(this, _$identity);
}

abstract class _SettingsModel implements SettingsModel {
  const factory _SettingsModel(
      {required final int id,
      required final int? favoriteMascotId,
      required final double talkingThresholdDecibels,
      required final RecordSettingsModel recordSettings}) = _$_SettingsModel;

  @override
  int get id;
  @override
  int? get favoriteMascotId;
  @override
  double get talkingThresholdDecibels;
  @override
  RecordSettingsModel get recordSettings;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsModelCopyWith<_$_SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
