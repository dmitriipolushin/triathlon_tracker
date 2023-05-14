import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:triathlon_tracker/data/local_storage_constants.dart';

@LazySingleton()
class SessionManager {
  String? token;

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    iOptions: IOSOptions(
      synchronizable: true,
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  Future<String?> getAuthToken() => _storage.read(
        key: LocalStorageConstants.authToken,
      );

  Future deleteAuthToken() {
    token = null;
    return _storage.delete(key: LocalStorageConstants.authToken);
  }

  Future clearStorage() => _storage.deleteAll();

  Future saveAuthToken(final String authToken) {
    initToken(authToken);
    return _storage.write(key: LocalStorageConstants.authToken, value: authToken);
  }

  initToken(final String token) => this.token = "Token $token";
}
