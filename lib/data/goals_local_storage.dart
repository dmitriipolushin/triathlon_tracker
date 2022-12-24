import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/data/local_storage_constants.dart';
import 'package:triathlon_tracker/domain/goals.dart';

class GoalsLocalStorage {
  late Box<Goals> box;

  Future<void> init() async {
    box = await Hive.openBox(LocalStorageConstants.goalsBox);
  }

  Future<void> saveNewGoals(Goals newGoals) async {
    await box.put(LocalStorageConstants.underscoreKey, newGoals);
  }

  bool get hasData => box.isNotEmpty;

  Goals? get data => hasData ? box.values.first : null;
}

final goalsLocalStorageProvider = Provider<GoalsLocalStorage>((ref) {
  return GoalsLocalStorage();
});
