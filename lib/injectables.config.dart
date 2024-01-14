// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'aplication/chatbot/chatbot_bloc.dart' as _i12;
import 'domain/chatbot/i_chatbot_data_source.dart' as _i8;
import 'domain/chatbot/i_chatbot_facade.dart' as _i10;
import 'infrastructure/chatbot/chatbot_data_source_impl.dart' as _i9;
import 'infrastructure/chatbot/chatbot_facade_impl.dart' as _i11;
import 'infrastructure/core/app_bloc_observer.dart' as _i3;
import 'infrastructure/core/register_module.dart' as _i13;
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
  final registerModule = _$RegisterModule();
  gh.factoryParam<_i3.AppBlocObserver,
      _i4.GlobalKey<_i4.ScaffoldMessengerState>?, dynamic>((
    _messenger,
    _,
  ) =>
      _i3.AppBlocObserver(_messenger));
  gh.singleton<_i5.AppRouter>(_i5.AppRouter());
  gh.factory<_i6.BaseOptions>(() => registerModule.getDioBaseOptions());
  gh.factory<Iterable<_i6.Interceptor>>(() => registerModule.getInterceptors());
  gh.singleton<_i7.ThemeConfig>(_i7.ThemeConfig());
  gh.singleton<_i6.Dio>(registerModule.getDio(
    gh<_i6.BaseOptions>(),
    gh<Iterable<_i6.Interceptor>>(),
  ));
  gh.factory<_i8.IChatBotDataSource>(
      () => _i9.ChatBotDataSourceImpl(gh<_i6.Dio>()));
  gh.factory<_i10.IChatBotFacade>(
      () => _i11.ChatBotFacadeImpl(gh<_i8.IChatBotDataSource>()));
  gh.factory<_i12.ChatBotBloc>(
      () => _i12.ChatBotBloc(gh<_i10.IChatBotFacade>()));
  return getIt;
}

class _$RegisterModule extends _i13.RegisterModule {}
