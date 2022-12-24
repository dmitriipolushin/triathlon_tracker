// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<_$_Profile> {
  @override
  final int typeId = 2;

  @override
  _$_Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Profile(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Profile obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
