// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveSettingsAdapter extends TypeAdapter<HiveSettings> {
  @override
  final int typeId = 4;

  @override
  HiveSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveSettings(
      favoriteMascotId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveSettings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.favoriteMascotId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
