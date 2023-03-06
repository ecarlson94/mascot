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
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as ImageModel,
    );
  }

  @override
  void write(BinaryWriter writer, ExpressionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
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
