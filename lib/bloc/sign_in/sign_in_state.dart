part of 'sign_in_bloc.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState.defaultState() = _DefaultState;

  const factory SignInState.loading() = _Loading;

  const factory SignInState.buttonState(
    final bool isActive,
  ) = _ButtonState;

  const factory SignInState.error(
    final String message,
  ) = _Error;

  const factory SignInState.success() = _Success;
}
