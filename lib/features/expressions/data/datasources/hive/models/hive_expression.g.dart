// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_expression.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveExpressionAdapter extends TypeAdapter<HiveExpression> {
  @override
  final int typeId = 3;

  @override
  HiveExpression read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveExpression(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      imageModel: fields[3] as HiveImage,
    );
  }

  @override
  void write(BinaryWriter writer, HiveExpression obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveExpressionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
