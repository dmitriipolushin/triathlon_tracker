import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/domain/training.dart';
import 'package:triathlon_tracker/state_holders/trainings_state_holder/trainings_state.dart';

class TrainingsStateNotifier extends StateNotifier<TrainingsState> {
  TrainingsStateNotifier()
      : super(TrainingsState(swimming: [], cycling: [], running: []));

  void setInintialState(
    List<Training> swimming,
    List<Training> cycling,
    List<Training> running,
  ) {
    state = TrainingsState(
      swimming: swimming,
      cycling: cycling,
      running: running,
    );
  }

  void addTraining(TrainingType trainingType, Training newTraining) {
    late List<Training> trainings;
    switch (trainingType) {
      case TrainingType.swimming:
        trainings = List.from(state.swimming);
        trainings.add(newTraining);
        state = state.copyWith(swimming: trainings);
        break;
      case TrainingType.cycling:
        trainings = List.from(state.cycling);
        trainings.add(newTraining);
        state = state.copyWith(cycling: trainings);
        break;
      case TrainingType.running:
        trainings = List.from(state.running);
        trainings.add(newTraining);
        state = state.copyWith(running: trainings);
        break;
    }
  }
}

final trainingsStateNotifierProvider =
    StateNotifierProvider<TrainingsStateNotifier, TrainingsState>((ref) {
  return TrainingsStateNotifier();
});
