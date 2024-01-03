// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageFile {
  Uint8List get bytes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageFileCopyWith<ImageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageFileCopyWith<$Res> {
  factory $ImageFileCopyWith(ImageFile value, $Res Function(ImageFile) then) =
      _$ImageFileCopyWithImpl<$Res, ImageFile>;
  @useResult
  $Res call({Uint8List bytes});
}

/// @nodoc
class _$ImageFileCopyWithImpl<$Res, $Val extends ImageFile>
    implements $ImageFileCopyWith<$Res> {
  _$ImageFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
  }) {
    return _then(_value.copyWith(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageFileCopyWith<$Res> implements $ImageFileCopyWith<$Res> {
  factory _$$_ImageFileCopyWith(
          _$_ImageFile value, $Res Function(_$_ImageFile) then) =
      __$$_ImageFileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List bytes});
}

/// @nodoc
class __$$_ImageFileCopyWithImpl<$Res>
    extends _$ImageFileCopyWithImpl<$Res, _$_ImageFile>
    implements _$$_ImageFileCopyWith<$Res> {
  __$$_ImageFileCopyWithImpl(
      _$_ImageFile _value, $Res Function(_$_ImageFile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
  }) {
    return _then(_$_ImageFile(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$_ImageFile extends _ImageFile {
  const _$_ImageFile({required this.bytes}) : super._();

  @override
  final Uint8List bytes;

  @override
  String toString() {
    return 'ImageFile(bytes: $bytes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageFile &&
            const DeepCollectionEquality().equals(other.bytes, bytes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(bytes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageFileCopyWith<_$_ImageFile> get copyWith =>
      __$$_ImageFileCopyWithImpl<_$_ImageFile>(this, _$identity);
}

abstract class _ImageFile extends ImageFile {
  const factory _ImageFile({required final Uint8List bytes}) = _$_ImageFile;
  const _ImageFile._() : super._();

  @override
  Uint8List get bytes;
  @override
  @JsonKey(ignore: true)
  _$$_ImageFileCopyWith<_$_ImageFile> get copyWith =>
      throw _privateConstructorUsedError;
}
