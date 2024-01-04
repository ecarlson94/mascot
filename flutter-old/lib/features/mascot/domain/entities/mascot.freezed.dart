// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mascot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Mascot {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Set<Expression> get expressions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MascotCopyWith<Mascot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MascotCopyWith<$Res> {
  factory $MascotCopyWith(Mascot value, $Res Function(Mascot) then) =
      _$MascotCopyWithImpl<$Res, Mascot>;
  @useResult
  $Res call({int id, String name, Set<Expression> expressions});
}

/// @nodoc
class _$MascotCopyWithImpl<$Res, $Val extends Mascot>
    implements $MascotCopyWith<$Res> {
  _$MascotCopyWithImpl(this._value, this._then);

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
              as Set<Expression>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MascotCopyWith<$Res> implements $MascotCopyWith<$Res> {
  factory _$$_MascotCopyWith(_$_Mascot value, $Res Function(_$_Mascot) then) =
      __$$_MascotCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, Set<Expression> expressions});
}

/// @nodoc
class __$$_MascotCopyWithImpl<$Res>
    extends _$MascotCopyWithImpl<$Res, _$_Mascot>
    implements _$$_MascotCopyWith<$Res> {
  __$$_MascotCopyWithImpl(_$_Mascot _value, $Res Function(_$_Mascot) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? expressions = null,
  }) {
    return _then(_$_Mascot(
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
              as Set<Expression>,
    ));
  }
}

/// @nodoc

class _$_Mascot implements _Mascot {
  const _$_Mascot(
      {required this.id,
      required this.name,
      required final Set<Expression> expressions})
      : _expressions = expressions;

  @override
  final int id;
  @override
  final String name;
  final Set<Expression> _expressions;
  @override
  Set<Expression> get expressions {
    if (_expressions is EqualUnmodifiableSetView) return _expressions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_expressions);
  }

  @override
  String toString() {
    return 'Mascot(id: $id, name: $name, expressions: $expressions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Mascot &&
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
  _$$_MascotCopyWith<_$_Mascot> get copyWith =>
      __$$_MascotCopyWithImpl<_$_Mascot>(this, _$identity);
}

abstract class _Mascot implements Mascot {
  const factory _Mascot(
      {required final int id,
      required final String name,
      required final Set<Expression> expressions}) = _$_Mascot;

  @override
  int get id;
  @override
  String get name;
  @override
  Set<Expression> get expressions;
  @override
  @JsonKey(ignore: true)
  _$$_MascotCopyWith<_$_Mascot> get copyWith =>
      throw _privateConstructorUsedError;
}
