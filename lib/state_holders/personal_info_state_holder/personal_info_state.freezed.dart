// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'personal_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PersonalInfoState _$PersonalInfoStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'empty':
      return Empty.fromJson(json);
    case 'data':
      return Data.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PersonalInfoState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PersonalInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Goals goals, Profile profile) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Goals goals, Profile profile)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Goals goals, Profile profile)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Data value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Data value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Data value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalInfoStateCopyWith<$Res> {
  factory $PersonalInfoStateCopyWith(
          PersonalInfoState value, $Res Function(PersonalInfoState) then) =
      _$PersonalInfoStateCopyWithImpl<$Res, PersonalInfoState>;
}

/// @nodoc
class _$PersonalInfoStateCopyWithImpl<$Res, $Val extends PersonalInfoState>
    implements $PersonalInfoStateCopyWith<$Res> {
  _$PersonalInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EmptyCopyWith<$Res> {
  factory _$$EmptyCopyWith(_$Empty value, $Res Function(_$Empty) then) =
      __$$EmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyCopyWithImpl<$Res>
    extends _$PersonalInfoStateCopyWithImpl<$Res, _$Empty>
    implements _$$EmptyCopyWith<$Res> {
  __$$EmptyCopyWithImpl(_$Empty _value, $Res Function(_$Empty) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$Empty implements Empty {
  _$Empty({final String? $type}) : $type = $type ?? 'empty';

  factory _$Empty.fromJson(Map<String, dynamic> json) => _$$EmptyFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PersonalInfoState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Empty);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Goals goals, Profile profile) data,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Goals goals, Profile profile)? data,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Goals goals, Profile profile)? data,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Data value) data,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Data value)? data,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Data value)? data,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EmptyToJson(
      this,
    );
  }
}

abstract class Empty implements PersonalInfoState {
  factory Empty() = _$Empty;

  factory Empty.fromJson(Map<String, dynamic> json) = _$Empty.fromJson;
}

/// @nodoc
abstract class _$$DataCopyWith<$Res> {
  factory _$$DataCopyWith(_$Data value, $Res Function(_$Data) then) =
      __$$DataCopyWithImpl<$Res>;
  @useResult
  $Res call({Goals goals, Profile profile});

  $GoalsCopyWith<$Res> get goals;
  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$$DataCopyWithImpl<$Res>
    extends _$PersonalInfoStateCopyWithImpl<$Res, _$Data>
    implements _$$DataCopyWith<$Res> {
  __$$DataCopyWithImpl(_$Data _value, $Res Function(_$Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goals = null,
    Object? profile = null,
  }) {
    return _then(_$Data(
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res> get goals {
    return $GoalsCopyWith<$Res>(_value.goals, (value) {
      return _then(_value.copyWith(goals: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Data implements Data {
  _$Data({required this.goals, required this.profile, final String? $type})
      : $type = $type ?? 'data';

  factory _$Data.fromJson(Map<String, dynamic> json) => _$$DataFromJson(json);

  @override
  final Goals goals;
  @override
  final Profile profile;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PersonalInfoState.data(goals: $goals, profile: $profile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Data &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, goals, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataCopyWith<_$Data> get copyWith =>
      __$$DataCopyWithImpl<_$Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(Goals goals, Profile profile) data,
  }) {
    return data(goals, profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(Goals goals, Profile profile)? data,
  }) {
    return data?.call(goals, profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(Goals goals, Profile profile)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(goals, profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Empty value) empty,
    required TResult Function(Data value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Empty value)? empty,
    TResult? Function(Data value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Empty value)? empty,
    TResult Function(Data value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataToJson(
      this,
    );
  }
}

abstract class Data implements PersonalInfoState {
  factory Data({required final Goals goals, required final Profile profile}) =
      _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  Goals get goals;
  Profile get profile;
  @JsonKey(ignore: true)
  _$$DataCopyWith<_$Data> get copyWith => throw _privateConstructorUsedError;
}
