// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/domain/profile.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_notifier.dart';

part 'personal_info_state.freezed.dart';
part 'personal_info_state.g.dart';

@freezed
class PersonalInfoState with _$PersonalInfoState {
  factory PersonalInfoState.empty() = Empty;
  factory PersonalInfoState.data({
    required Goals goals,
    required Profile profile,
  }) = Data;

  factory PersonalInfoState.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoStateFromJson(json);
}

final personalInfoStateNotifierProvider =
    StateNotifierProvider<PersonalInfoNotifier, PersonalInfoState>((ref) {
  return PersonalInfoNotifier();
});
