// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:triathlon_tracker/bloc/sign_in/sign_in_bloc.dart' as _i6;
import 'package:triathlon_tracker/bloc/sign_up/sign_up_bloc.dart' as _i7;
import 'package:triathlon_tracker/data/session_manager.dart' as _i3;
import 'package:triathlon_tracker/infrastructure/api/api_repository.dart'
    as _i4;
import 'package:triathlon_tracker/infrastructure/auth/auth_repository.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.SessionManager>(() => _i3.SessionManager());
    gh.lazySingleton<_i4.APIRepository>(
        () => _i4.APIRepository(gh<_i3.SessionManager>()));
    gh.lazySingleton<_i5.AuthRepository>(() => _i5.AuthRepository(
          gh<_i4.APIRepository>(),
          gh<_i3.SessionManager>(),
        ));
    gh.factory<_i6.SignInBloc>(() => _i6.SignInBloc(gh<_i5.AuthRepository>()));
    gh.factory<_i7.SignUpBloc>(() => _i7.SignUpBloc(gh<_i5.AuthRepository>()));
    return this;
  }
}
