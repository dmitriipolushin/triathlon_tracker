// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrainingsState _$$_TrainingsStateFromJson(Map<String, dynamic> json) =>
    _$_TrainingsState(
      swimming: (json['swimming'] as List<dynamic>)
          .map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
      cycling: (json['cycling'] as List<dynamic>)
          .map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
      running: (json['running'] as List<dynamic>)
          .map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TrainingsStateToJson(_$_TrainingsState instance) =>
    <String, dynamic>{
      'swimming': instance.swimming,
      'cycling': instance.cycling,
      'running': instance.running,
    };
