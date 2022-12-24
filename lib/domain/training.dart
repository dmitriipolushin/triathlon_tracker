// ignore_for_file: invalid_annotation_target
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:triathlon_tracker/core/s.dart';

part 'training.freezed.dart';
part 'training.g.dart';

@freezed
class Training with _$Training {
  @HiveType(typeId: 1)
  factory Training({
    @HiveField(0) required double distance,
    @HiveField(1) required DateTime dateTime,
  }) = _Training;

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
}

@HiveType(typeId: 3)
enum TrainingType {
  @HiveField(0)
  swimming,
  @HiveField(1)
  cycling,
  @HiveField(2)
  running;

  String getString(BuildContext context) {
    switch (this) {
      case TrainingType.swimming:
        return S.of(context).swimming;
      case TrainingType.cycling:
        return S.of(context).cycling;
      case TrainingType.running:
        return S.of(context).running;
    }
  }
}
