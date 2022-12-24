import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/data/trainings_local_storage.dart';
import 'package:triathlon_tracker/domain/training.dart';
import 'package:triathlon_tracker/state_holders/trainings_state_holder/trainings_notifier.dart';

class TrainingsManager {
  final TrainingsLocalStorage trainingsLocalStorage;
  final TrainingsStateNotifier trainingsStateNotifier;

  TrainingsManager(
    this.trainingsLocalStorage,
    this.trainingsStateNotifier,
  );

  void init() {
    trainingsStateNotifier.setInintialState(
      trainingsLocalStorage.getTrainings(TrainingType.swimming),
      trainingsLocalStorage.getTrainings(TrainingType.cycling),
      trainingsLocalStorage.getTrainings(TrainingType.running),
    );
  }

  void addTraining(TrainingType trainingType, Training training) {
    trainingsStateNotifier.addTraining(trainingType, training);
    trainingsLocalStorage.addTraining(trainingType, training);
  }
}

final trainingsManagerProvider = Provider<TrainingsManager>((ref) {
  return TrainingsManager(
    ref.read(trainingsLocalStorageProvider),
    ref.read(trainingsStateNotifierProvider.notifier),
  );
});
