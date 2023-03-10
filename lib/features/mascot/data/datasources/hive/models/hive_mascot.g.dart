// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_mascot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMascotAdapter extends TypeAdapter<HiveMascot> {
  @override
  final int typeId = 2;

  @override
  HiveMascot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMascot(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMascot obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.expressionsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMascotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
