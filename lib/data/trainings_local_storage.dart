import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/domain/training.dart';

class TrainingsLocalStorage {
  Map<TrainingType, Box<Training>> boxes = {};

  Future<void> init() async {
    for (var element in TrainingType.values) {
      boxes[element] = await Hive.openBox<Training>(element.toString());
    }
  }

  Future<void> addTraining(TrainingType trainingType, Training training) async {
    boxes[trainingType]!.add(training);
  }

  List<Training> getTrainings(TrainingType trainingType) {
    return boxes[trainingType]!.values.toList();
  }
}

final trainingsLocalStorageProvider = Provider<TrainingsLocalStorage>((ref) {
  return TrainingsLocalStorage();
});
