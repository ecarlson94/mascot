// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expression.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Expression {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Uint8List get image => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  ExpressionTriggers get activator => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpressionCopyWith<Expression> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpressionCopyWith<$Res> {
  factory $ExpressionCopyWith(
          Expression value, $Res Function(Expression) then) =
      _$ExpressionCopyWithImpl<$Res, Expression>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      Uint8List image,
      int priority,
      ExpressionTriggers activator});
}

/// @nodoc
class _$ExpressionCopyWithImpl<$Res, $Val extends Expression>
    implements $ExpressionCopyWith<$Res> {
  _$ExpressionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? image = null,
    Object? priority = null,
    Object? activator = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      activator: null == activator
          ? _value.activator
          : activator // ignore: cast_nullable_to_non_nullable
              as ExpressionTriggers,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpressionCopyWith<$Res>
    implements $ExpressionCopyWith<$Res> {
  factory _$$_ExpressionCopyWith(
          _$_Expression value, $Res Function(_$_Expression) then) =
      __$$_ExpressionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      Uint8List image,
      int priority,
      ExpressionTriggers activator});
}

/// @nodoc
class __$$_ExpressionCopyWithImpl<$Res>
    extends _$ExpressionCopyWithImpl<$Res, _$_Expression>
    implements _$$_ExpressionCopyWith<$Res> {
  __$$_ExpressionCopyWithImpl(
      _$_Expression _value, $Res Function(_$_Expression) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? image = null,
    Object? priority = null,
    Object? activator = null,
  }) {
    return _then(_$_Expression(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      activator: null == activator
          ? _value.activator
          : activator // ignore: cast_nullable_to_non_nullable
              as ExpressionTriggers,
    ));
  }
}

/// @nodoc

class _$_Expression implements _Expression {
  const _$_Expression(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.priority,
      required this.activator});

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final Uint8List image;
  @override
  final int priority;
  @override
  final ExpressionTriggers activator;

  @override
  String toString() {
    return 'Expression(id: $id, name: $name, description: $description, image: $image, priority: $priority, activator: $activator)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Expression &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.activator, activator) ||
                other.activator == activator));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(image), priority, activator);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpressionCopyWith<_$_Expression> get copyWith =>
      __$$_ExpressionCopyWithImpl<_$_Expression>(this, _$identity);
}

abstract class _Expression implements Expression {
  const factory _Expression(
      {required final int id,
      required final String name,
      required final String description,
      required final Uint8List image,
      required final int priority,
      required final ExpressionTriggers activator}) = _$_Expression;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Uint8List get image;
  @override
  int get priority;
  @override
  ExpressionTriggers get activator;
  @override
  @JsonKey(ignore: true)
  _$$_ExpressionCopyWith<_$_Expression> get copyWith =>
      throw _privateConstructorUsedError;
}
