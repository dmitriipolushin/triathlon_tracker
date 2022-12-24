// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Empty _$$EmptyFromJson(Map<String, dynamic> json) => _$Empty(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EmptyToJson(_$Empty instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$Data _$$DataFromJson(Map<String, dynamic> json) => _$Data(
      goals: Goals.fromJson(json['goals'] as Map<String, dynamic>),
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataToJson(_$Data instance) => <String, dynamic>{
      'goals': instance.goals,
      'profile': instance.profile,
      'runtimeType': instance.$type,
    };
