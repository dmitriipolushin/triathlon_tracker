// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  @HiveType(typeId: 2)
  factory Profile({
    @HiveField(0) required String name,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
