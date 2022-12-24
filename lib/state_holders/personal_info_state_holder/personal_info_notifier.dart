import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/domain/profile.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_state.dart';

class PersonalInfoNotifier extends StateNotifier<PersonalInfoState> {
  PersonalInfoNotifier() : super(PersonalInfoState.empty());

  void setPersonalInfo({Profile? newProfile, Goals? newGoals}) {
    if (!((newProfile == null || newGoals == null) && state is Empty)) {
      state = state.when(
        empty: () =>
            PersonalInfoState.data(goals: newGoals!, profile: newProfile!),
        data: (goals, profile) => PersonalInfoState.data(
          goals: newGoals ?? goals,
          profile: newProfile ?? profile,
        ),
      );
    }
  }

  void setEmpty() {
    state = PersonalInfoState.empty();
  }
}

final profileInfoStateNotifierProvider =
    StateNotifierProvider<PersonalInfoNotifier, PersonalInfoState>((ref) {
  return PersonalInfoNotifier();
});
