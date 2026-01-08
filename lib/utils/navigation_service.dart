//
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
//
// class NavigationService {
//   final navigatorKey = GlobalKey<NavigatorState>();
//   BuildContext get navigatorContext => navigatorKey.currentState!.context;
// }
//
// BuildContext get getContext {
//   return GetIt.instance<NavigationService>().navigatorContext;
// }
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get state => navigatorKey.currentState;

  Future<T?> push<T>(Route<T> route) {
    final nav = state;
    print("nav $nav");
    if (nav == null) return Future.value(null);
    return nav.push(route);
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    final nav = state;
    if (nav == null) return Future.value(null);
    return nav.pushNamed<T>(routeName, arguments: arguments);
  }
}
