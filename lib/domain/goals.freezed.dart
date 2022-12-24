// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'goals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Goals _$GoalsFromJson(Map<String, dynamic> json) {
  return _Goals.fromJson(json);
}

/// @nodoc
mixin _$Goals {
  @HiveField(0)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(1)
  double get swimming => throw _privateConstructorUsedError;
  @HiveField(2)
  double get cycling => throw _privateConstructorUsedError;
  @HiveField(3)
  double get running => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalsCopyWith<Goals> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalsCopyWith<$Res> {
  factory $GoalsCopyWith(Goals value, $Res Function(Goals) then) =
      _$GoalsCopyWithImpl<$Res, Goals>;
  @useResult
  $Res call(
      {@HiveField(0) String? name,
      @HiveField(1) double swimming,
      @HiveField(2) double cycling,
      @HiveField(3) double running});
}

/// @nodoc
class _$GoalsCopyWithImpl<$Res, $Val extends Goals>
    implements $GoalsCopyWith<$Res> {
  _$GoalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? swimming = null,
    Object? cycling = null,
    Object? running = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      swimming: null == swimming
          ? _value.swimming
          : swimming // ignore: cast_nullable_to_non_nullable
              as double,
      cycling: null == cycling
          ? _value.cycling
          : cycling // ignore: cast_nullable_to_non_nullable
              as double,
      running: null == running
          ? _value.running
          : running // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoalsCopyWith<$Res> implements $GoalsCopyWith<$Res> {
  factory _$$_GoalsCopyWith(_$_Goals value, $Res Function(_$_Goals) then) =
      __$$_GoalsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? name,
      @HiveField(1) double swimming,
      @HiveField(2) double cycling,
      @HiveField(3) double running});
}

/// @nodoc
class __$$_GoalsCopyWithImpl<$Res> extends _$GoalsCopyWithImpl<$Res, _$_Goals>
    implements _$$_GoalsCopyWith<$Res> {
  __$$_GoalsCopyWithImpl(_$_Goals _value, $Res Function(_$_Goals) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? swimming = null,
    Object? cycling = null,
    Object? running = null,
  }) {
    return _then(_$_Goals(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      swimming: null == swimming
          ? _value.swimming
          : swimming // ignore: cast_nullable_to_non_nullable
              as double,
      cycling: null == cycling
          ? _value.cycling
          : cycling // ignore: cast_nullable_to_non_nullable
              as double,
      running: null == running
          ? _value.running
          : running // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0)
class _$_Goals extends _Goals {
  _$_Goals(
      {@HiveField(0) this.name,
      @HiveField(1) required this.swimming,
      @HiveField(2) required this.cycling,
      @HiveField(3) required this.running})
      : super._();

  factory _$_Goals.fromJson(Map<String, dynamic> json) =>
      _$$_GoalsFromJson(json);

  @override
  @HiveField(0)
  final String? name;
  @override
  @HiveField(1)
  final double swimming;
  @override
  @HiveField(2)
  final double cycling;
  @override
  @HiveField(3)
  final double running;

  @override
  String toString() {
    return 'Goals(name: $name, swimming: $swimming, cycling: $cycling, running: $running)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Goals &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.swimming, swimming) ||
                other.swimming == swimming) &&
            (identical(other.cycling, cycling) || other.cycling == cycling) &&
            (identical(other.running, running) || other.running == running));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, swimming, cycling, running);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoalsCopyWith<_$_Goals> get copyWith =>
      __$$_GoalsCopyWithImpl<_$_Goals>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoalsToJson(
      this,
    );
  }
}

abstract class _Goals extends Goals {
  factory _Goals(
      {@HiveField(0) final String? name,
      @HiveField(1) required final double swimming,
      @HiveField(2) required final double cycling,
      @HiveField(3) required final double running}) = _$_Goals;
  _Goals._() : super._();

  factory _Goals.fromJson(Map<String, dynamic> json) = _$_Goals.fromJson;

  @override
  @HiveField(0)
  String? get name;
  @override
  @HiveField(1)
  double get swimming;
  @override
  @HiveField(2)
  double get cycling;
  @override
  @HiveField(3)
  double get running;
  @override
  @JsonKey(ignore: true)
  _$$_GoalsCopyWith<_$_Goals> get copyWith =>
      throw _privateConstructorUsedError;
}
