// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalsAdapter extends TypeAdapter<_$_Goals> {
  @override
  final int typeId = 0;

  @override
  _$_Goals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Goals(
      name: fields[0] as String?,
      swimming: fields[1] as double,
      cycling: fields[2] as double,
      running: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Goals obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.swimming)
      ..writeByte(2)
      ..write(obj.cycling)
      ..writeByte(3)
      ..write(obj.running);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Goals _$$_GoalsFromJson(Map<String, dynamic> json) => _$_Goals(
      name: json['name'] as String?,
      swimming: (json['swimming'] as num).toDouble(),
      cycling: (json['cycling'] as num).toDouble(),
      running: (json['running'] as num).toDouble(),
    );

Map<String, dynamic> _$$_GoalsToJson(_$_Goals instance) => <String, dynamic>{
      'name': instance.name,
      'swimming': instance.swimming,
      'cycling': instance.cycling,
      'running': instance.running,
    };
