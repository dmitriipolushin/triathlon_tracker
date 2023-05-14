import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:triathlon_tracker/core/logger.dart';
import 'package:triathlon_tracker/data/session_manager.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/infrastructure/api/api_repository.dart';

@LazySingleton()
class AuthRepository {
  final APIRepository _apiRepository;
  final SessionManager _sessionManager;
  //final ProfileManager _profileManager;

  AuthRepository(
    this._apiRepository,
    this._sessionManager,
    //this._profileManager,
  );

  Future<Either<String, Unit>> signUp({
    required final String email,
    required final String password,
    required final String name,
    required final Goals goals,
  }) async {
    final response = await _apiRepository.postData(
      '/users/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        "runningGoal": goals.running.toInt(),
        "cyclingGoal": goals.cycling.toInt(),
        "swimmingGoal": goals.swimming.toInt(),
      },
    );
    return response.fold((failure) {
      return left(failure);
    }, (success) {
      logger.info(success);
      _sessionManager.saveAuthToken(
        json.decode(success.data)['access_token'],
      );
      return right(unit);
    });
  }

  Future<Either<String, Unit>> signIn({
    required final String email,
    required final String password,
  }) async {
    final response = await _apiRepository.postData(
      '/users/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.fold((failure) {
      return left(failure);
    }, (success) {
      logger.info(success);
      _sessionManager.saveAuthToken(
        json.decode(success.data)['access_token'],
      );
      return right(unit);
    });
  }
}
