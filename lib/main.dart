import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'infrastructure/core/app_bloc_observer.dart';
import 'injectables.dart';

Future<void> main() async {
  await configureDependencies();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  Bloc.observer = AppBlocObserver(messengerKey);
  runApp(const App());
}
