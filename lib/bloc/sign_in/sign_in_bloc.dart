import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:triathlon_tracker/infrastructure/auth/auth_repository.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;

  String email = '';
  String password = '';

  SignInBloc(this._authRepository) : super(const SignInState.defaultState()) {
    on<SignInEvent>(
      (event, emit) async {
        await event.when(
          emailChanged: (email) {
            this.email = email;
            emit(_stateOnFieldChanged());
          },
          passwordChanged: (password) {
            this.password = password;
            emit(_stateOnFieldChanged());
          },
          buttonPressed: () async {
            emit(const SignInState.loading());
            final response = await _authRepository.signIn(
              email: email,
              password: password,
            );
            response.fold(
              (failure) {
                emit(SignInState.error(failure));
              },
              (success) {
                emit(const SignInState.success());
              },
            );
          },
        );
      },
    );
  }

  SignInState _stateOnFieldChanged() {
    return SignInState.buttonState(email.isNotEmpty && password.isNotEmpty);
  }
}
