import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:l/l.dart';

import '../../domain/core/types.dart';




@injectable
class AppBlocObserver extends BlocObserver {
  AppBlocObserver(
    @factoryParam this._messenger,
  );

  final GlobalKey<ScaffoldMessengerState>? _messenger;


  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    l.e('${bloc.runtimeType}: $error', stackTrace);

    /// Extract the error message if exit to display in app snackBar.
    /// This only work in the debug mode.
    final message = _extractErrorMessage(error);

    final state = _messenger?.currentState;
    final context = _messenger?.currentContext;
    if (state != null && context != null) {
      final theme = Theme.of(context);
      state
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              message ?? 'Ocurrio un error inesperado',
              style: TextStyle(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
            backgroundColor: theme.colorScheme.errorContainer,
          ),
        );
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    l.d(transition);
  }

  /// Extract the error message to display in the Log Terminal.
  String? _extractErrorMessage(
    Object error,
  ) {
    if (error is DioException) {
      if (error.type == DioExceptionType.badResponse) {
        final data = error.response!.data;
        if (data is Json) {
          return (data['message'] as String?) ??
              'Ocurrio un error para procesar tu solicitud';
        }
        return 'Ocurrio un error para procesar tu solicitud';
      }
      if (error.error is SocketException) {
        return 'Tuvimos un problema para conectar con nuestro servidor. Revisa tu conexión a internet';
      }
    }
    if (error is AssertionError) {
      return error.message.toString();
    }
    return null;
  }
}
