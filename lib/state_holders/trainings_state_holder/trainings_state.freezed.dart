// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'trainings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrainingsState _$TrainingsStateFromJson(Map<String, dynamic> json) {
  return _TrainingsState.fromJson(json);
}

/// @nodoc
mixin _$TrainingsState {
  List<Training> get swimming => throw _privateConstructorUsedError;
  List<Training> get cycling => throw _privateConstructorUsedError;
  List<Training> get running => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingsStateCopyWith<TrainingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingsStateCopyWith<$Res> {
  factory $TrainingsStateCopyWith(
          TrainingsState value, $Res Function(TrainingsState) then) =
      _$TrainingsStateCopyWithImpl<$Res, TrainingsState>;
  @useResult
  $Res call(
      {List<Training> swimming,
      List<Training> cycling,
      List<Training> running});
}

/// @nodoc
class _$TrainingsStateCopyWithImpl<$Res, $Val extends TrainingsState>
    implements $TrainingsStateCopyWith<$Res> {
  _$TrainingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swimming = null,
    Object? cycling = null,
    Object? running = null,
  }) {
    return _then(_value.copyWith(
      swimming: null == swimming
          ? _value.swimming
          : swimming // ignore: cast_nullable_to_non_nullable
              as List<Training>,
      cycling: null == cycling
          ? _value.cycling
          : cycling // ignore: cast_nullable_to_non_nullable
              as List<Training>,
      running: null == running
          ? _value.running
          : running // ignore: cast_nullable_to_non_nullable
              as List<Training>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainingsStateCopyWith<$Res>
    implements $TrainingsStateCopyWith<$Res> {
  factory _$$_TrainingsStateCopyWith(
          _$_TrainingsState value, $Res Function(_$_TrainingsState) then) =
      __$$_TrainingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Training> swimming,
      List<Training> cycling,
      List<Training> running});
}

/// @nodoc
class __$$_TrainingsStateCopyWithImpl<$Res>
    extends _$TrainingsStateCopyWithImpl<$Res, _$_TrainingsState>
    implements _$$_TrainingsStateCopyWith<$Res> {
  __$$_TrainingsStateCopyWithImpl(
      _$_TrainingsState _value, $Res Function(_$_TrainingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swimming = null,
    Object? cycling = null,
    Object? running = null,
  }) {
    return _then(_$_TrainingsState(
      swimming: null == swimming
          ? _value._swimming
          : swimming // ignore: cast_nullable_to_non_nullable
              as List<Training>,
      cycling: null == cycling
          ? _value._cycling
          : cycling // ignore: cast_nullable_to_non_nullable
              as List<Training>,
      running: null == running
          ? _value._running
          : running // ignore: cast_nullable_to_non_nullable
              as List<Training>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrainingsState extends _TrainingsState {
  _$_TrainingsState(
      {required final List<Training> swimming,
      required final List<Training> cycling,
      required final List<Training> running})
      : _swimming = swimming,
        _cycling = cycling,
        _running = running,
        super._();

  factory _$_TrainingsState.fromJson(Map<String, dynamic> json) =>
      _$$_TrainingsStateFromJson(json);

  final List<Training> _swimming;
  @override
  List<Training> get swimming {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_swimming);
  }

  final List<Training> _cycling;
  @override
  List<Training> get cycling {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cycling);
  }

  final List<Training> _running;
  @override
  List<Training> get running {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_running);
  }

  @override
  String toString() {
    return 'TrainingsState(swimming: $swimming, cycling: $cycling, running: $running)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingsState &&
            const DeepCollectionEquality().equals(other._swimming, _swimming) &&
            const DeepCollectionEquality().equals(other._cycling, _cycling) &&
            const DeepCollectionEquality().equals(other._running, _running));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_swimming),
      const DeepCollectionEquality().hash(_cycling),
      const DeepCollectionEquality().hash(_running));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingsStateCopyWith<_$_TrainingsState> get copyWith =>
      __$$_TrainingsStateCopyWithImpl<_$_TrainingsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrainingsStateToJson(
      this,
    );
  }
}

abstract class _TrainingsState extends TrainingsState {
  factory _TrainingsState(
      {required final List<Training> swimming,
      required final List<Training> cycling,
      required final List<Training> running}) = _$_TrainingsState;
  _TrainingsState._() : super._();

  factory _TrainingsState.fromJson(Map<String, dynamic> json) =
      _$_TrainingsState.fromJson;

  @override
  List<Training> get swimming;
  @override
  List<Training> get cycling;
  @override
  List<Training> get running;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingsStateCopyWith<_$_TrainingsState> get copyWith =>
      throw _privateConstructorUsedError;
}
