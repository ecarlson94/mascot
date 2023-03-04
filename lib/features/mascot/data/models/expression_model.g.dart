// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expression_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpressionModelAdapter extends TypeAdapter<ExpressionModel> {
  @override
  final int typeId = 3;

  @override
  ExpressionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpressionModel(
      name: fields[0] as String,
      description: fields[1] as String,
      image: fields[2] as Image,
    );
  }

  @override
  void write(BinaryWriter writer, ExpressionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpressionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
