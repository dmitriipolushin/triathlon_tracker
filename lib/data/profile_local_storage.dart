import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:triathlon_tracker/data/local_storage_constants.dart';
import 'package:triathlon_tracker/domain/profile.dart';

class ProfileLocalStorage {
  late Box<Profile> box;

  Future<void> init() async {
    box = await Hive.openBox(LocalStorageConstants.profileBox);
  }

  Future<void> saveNewProfile(Profile newProfile) async {
    await box.put(LocalStorageConstants.underscoreKey, newProfile);
  }

  bool get hasData => box.isNotEmpty;

  Profile? get data => hasData ? box.values.first : null;
}

final profileLocalStorageProvider = Provider<ProfileLocalStorage>((ref) {
  return ProfileLocalStorage();
});
