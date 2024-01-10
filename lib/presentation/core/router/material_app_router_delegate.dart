import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../theme/theme_config.dart';


class MaterialAppRouterDelegate {
  static MaterialApp router(
    String title, {
    required RootStackRouter appRouter,
    required ThemeConfig themeConfig,
    required GlobalKey<ScaffoldMessengerState> messengerKey,
    required BuildContext context,
  }) {
    return MaterialApp.router(
      // Disables the debug banner in release builds.
      debugShowCheckedModeBanner: false,
      // Sets the scaffoldMessengerKey to the provided GlobalKey.
      scaffoldMessengerKey: messengerKey,
      // Sets the light theme for the app using themeConfigStyle.light.
      theme: themeConfig.light,
      // Sets the dark theme for the app using themeConfigStyle.dark.
      darkTheme: themeConfig.dark,
      // Sets the default theme mode to dark.
      themeMode: ThemeMode.dark,
      // Sets the title of the app.
      title: title,
      // Configures the router with the provided appRouter.config().
      routerConfig: appRouter.config(),
    );
  }
}
