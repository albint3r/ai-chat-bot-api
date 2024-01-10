// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChatBotRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatBotPage(),
      );
    }
  };
}

/// generated route for
/// [ChatBotPage]
class ChatBotRoute extends PageRouteInfo<void> {
  const ChatBotRoute({List<PageRouteInfo>? children})
      : super(
          ChatBotRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatBotRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
