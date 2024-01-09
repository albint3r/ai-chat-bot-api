// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'aplication/chatbot/chatbot_bloc.dart' as _i6;
import 'infrastructure/core/app_bloc_observer.dart' as _i3;
import 'presentation/core/router/app_router.dart' as _i5;
import 'presentation/core/theme/theme_config.dart' as _i7;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factoryParam<_i3.AppBlocObserver,
      _i4.GlobalKey<_i4.ScaffoldMessengerState>?, dynamic>((
    _messenger,
    _,
  ) =>
      _i3.AppBlocObserver(_messenger));
  gh.singleton<_i5.AppRouter>(_i5.AppRouter());
  gh.factory<_i6.ChatBotBloc>(() => _i6.ChatBotBloc());
  gh.singleton<_i7.ThemeConfig>(_i7.ThemeConfig());
  return getIt;
}
