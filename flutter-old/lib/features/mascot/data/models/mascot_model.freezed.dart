// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mascot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MascotModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExpressionModel> get expressions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MascotModelCopyWith<MascotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MascotModelCopyWith<$Res> {
  factory $MascotModelCopyWith(
          MascotModel value, $Res Function(MascotModel) then) =
      _$MascotModelCopyWithImpl<$Res, MascotModel>;
  @useResult
  $Res call({int id, String name, List<ExpressionModel> expressions});
}

/// @nodoc
class _$MascotModelCopyWithImpl<$Res, $Val extends MascotModel>
    implements $MascotModelCopyWith<$Res> {
  _$MascotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? expressions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      expressions: null == expressions
          ? _value.expressions
          : expressions // ignore: cast_nullable_to_non_nullable
              as List<ExpressionModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MascotModelCopyWith<$Res>
    implements $MascotModelCopyWith<$Res> {
  factory _$$_MascotModelCopyWith(
          _$_MascotModel value, $Res Function(_$_MascotModel) then) =
      __$$_MascotModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, List<ExpressionModel> expressions});
}

/// @nodoc
class __$$_MascotModelCopyWithImpl<$Res>
    extends _$MascotModelCopyWithImpl<$Res, _$_MascotModel>
    implements _$$_MascotModelCopyWith<$Res> {
  __$$_MascotModelCopyWithImpl(
      _$_MascotModel _value, $Res Function(_$_MascotModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? expressions = null,
  }) {
    return _then(_$_MascotModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      expressions: null == expressions
          ? _value._expressions
          : expressions // ignore: cast_nullable_to_non_nullable
              as List<ExpressionModel>,
    ));
  }
}

/// @nodoc

class _$_MascotModel implements _MascotModel {
  const _$_MascotModel(
      {required this.id,
      required this.name,
      required final List<ExpressionModel> expressions})
      : _expressions = expressions;

  @override
  final int id;
  @override
  final String name;
  final List<ExpressionModel> _expressions;
  @override
  List<ExpressionModel> get expressions {
    if (_expressions is EqualUnmodifiableListView) return _expressions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expressions);
  }

  @override
  String toString() {
    return 'MascotModel(id: $id, name: $name, expressions: $expressions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MascotModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._expressions, _expressions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_expressions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MascotModelCopyWith<_$_MascotModel> get copyWith =>
      __$$_MascotModelCopyWithImpl<_$_MascotModel>(this, _$identity);
}

abstract class _MascotModel implements MascotModel {
  const factory _MascotModel(
      {required final int id,
      required final String name,
      required final List<ExpressionModel> expressions}) = _$_MascotModel;

  @override
  int get id;
  @override
  String get name;
  @override
  List<ExpressionModel> get expressions;
  @override
  @JsonKey(ignore: true)
  _$$_MascotModelCopyWith<_$_MascotModel> get copyWith =>
      throw _privateConstructorUsedError;
}
