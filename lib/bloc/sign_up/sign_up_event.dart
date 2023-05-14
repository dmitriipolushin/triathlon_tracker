part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.emailChanged(String email) = _EmailChanged;

  const factory SignUpEvent.passwordChanged(String password) = _PasswordChanged;

  const factory SignUpEvent.buttonPressed(
    String name,
    Goals goals,
  ) = _ButtonPressed;
}
