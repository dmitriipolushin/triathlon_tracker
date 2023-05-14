import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:triathlon_tracker/core/logger.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/infrastructure/auth/auth_repository.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  String email = '';
  String password = '';

  SignUpBloc(this._authRepository) : super(const SignUpState.defaultState()) {
    on<SignUpEvent>(
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
          buttonPressed: (name, goals) async {
            emit(const SignUpState.loading());
            logger.info(name);
            final response = await _authRepository.signUp(
              email: email,
              password: password,
              name: name,
              goals: goals,
            );
            response.fold(
              (failure) {
                emit(SignUpState.error(failure));
              },
              (success) {
                emit(const SignUpState.success());
              },
            );
          },
        );
      },
    );
  }

  SignUpState _stateOnFieldChanged() {
    return SignUpState.buttonState(email.isNotEmpty && password.isNotEmpty);
  }
}
