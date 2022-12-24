// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:triathlon_tracker/domain/training.dart';

part 'goals.freezed.dart';
part 'goals.g.dart';

@freezed
class Goals with _$Goals {
  const Goals._();
  @HiveType(typeId: 0)
  factory Goals({
    @HiveField(0) String? name,
    @HiveField(1) required double swimming,
    @HiveField(2) required double cycling,
    @HiveField(3) required double running,
  }) = _Goals;

  factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);

  double byTrainingtype(TrainingType type) {
    switch (type) {
      case TrainingType.swimming:
        return swimming;
      case TrainingType.cycling:
        return cycling;
      case TrainingType.running:
        return running;
    }
  }

  // factory Goals.sprint() => Goals(
  //       name: StaticS.loc.sprint,
  //       swimming: 0.75,
  //       cycling: 20,
  //       running: 5,
  //     );
  // factory Goals.olympic() => Goals(
  //       name: StaticS.loc.olympic,
  //       swimming: 1.5,
  //       cycling: 40,
  //       running: 10,
  //     );
  // factory Goals.o2() => Goals(
  //       name: StaticS.loc.o2,
  //       swimming: 3,
  //       cycling: 80,
  //       running: 20,
  //     );
  // factory Goals.halfIronman() => Goals(
  //       name: StaticS.loc.half_ironman,
  //       swimming: 1.9,
  //       cycling: 90,
  //       running: 21.0975,
  //     );
}
