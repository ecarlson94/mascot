// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mascot_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MascotModelAdapter extends TypeAdapter<MascotModel> {
  @override
  final int typeId = 2;

  @override
  MascotModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MascotModel(
      id: fields[0] as int,
      name: fields[1] as String,
      expressions: (fields[2] as List).cast<Expression>(),
    );
  }

  @override
  void write(BinaryWriter writer, MascotModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.expressions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MascotModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
