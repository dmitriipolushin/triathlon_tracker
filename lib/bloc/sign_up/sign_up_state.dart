part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState.defaultState() = _DefaultState;

  const factory SignUpState.loading() = _Loading;

  const factory SignUpState.buttonState(
    final bool isActive,
  ) = _ButtonState;

  const factory SignUpState.error(
    final String message,
  ) = _Error;

  const factory SignUpState.success() = _Success;
}
