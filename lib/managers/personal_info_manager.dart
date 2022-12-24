import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/data/goals_local_storage.dart';
import 'package:triathlon_tracker/data/profile_local_storage.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/domain/profile.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_notifier.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_state.dart';

class PersonalInfoManager {
  final GoalsLocalStorage goalsLocalStorage;
  final ProfileLocalStorage profileLocalStorage;
  final PersonalInfoNotifier personalInfoNotifier;

  PersonalInfoManager(
    this.goalsLocalStorage,
    this.profileLocalStorage,
    this.personalInfoNotifier,
  );

  void init() {
    if (profileLocalStorage.hasData) {
      personalInfoNotifier.setPersonalInfo(
        newProfile: profileLocalStorage.data,
        newGoals: goalsLocalStorage.data,
      );
    } else {
      personalInfoNotifier.setEmpty();
    }
  }

  void setNewPersonalData({Profile? profile, Goals? goals}) {
    personalInfoNotifier.setPersonalInfo(
      newGoals: goals,
      newProfile: profile,
    );
    if (goals != null) {
      goalsLocalStorage.saveNewGoals(goals);
    }
    if (profile != null) {
      profileLocalStorage.saveNewProfile(profile);
    }
  }
}

final personalInfoManagerProvider = Provider<PersonalInfoManager>((ref) {
  return PersonalInfoManager(
    ref.read(goalsLocalStorageProvider),
    ref.read(profileLocalStorageProvider),
    ref.read(personalInfoStateNotifierProvider.notifier),
  );
});
