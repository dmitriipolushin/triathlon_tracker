// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingTypeAdapter extends TypeAdapter<TrainingType> {
  @override
  final int typeId = 3;

  @override
  TrainingType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TrainingType.swimming;
      case 1:
        return TrainingType.cycling;
      case 2:
        return TrainingType.running;
      default:
        return TrainingType.swimming;
    }
  }

  @override
  void write(BinaryWriter writer, TrainingType obj) {
    switch (obj) {
      case TrainingType.swimming:
        writer.writeByte(0);
        break;
      case TrainingType.cycling:
        writer.writeByte(1);
        break;
      case TrainingType.running:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrainingAdapter extends TypeAdapter<_$_Training> {
  @override
  final int typeId = 1;

  @override
  _$_Training read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Training(
      distance: fields[0] as double,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Training obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.distance)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Training _$$_TrainingFromJson(Map<String, dynamic> json) => _$_Training(
      distance: (json['distance'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$_TrainingToJson(_$_Training instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'dateTime': instance.dateTime.toIso8601String(),
    };
