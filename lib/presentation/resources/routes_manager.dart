import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../login_screen/view/login_view.dart';
import '../register_screen/view/register_view.dart';
import '../selection_screen/view/selection_view.dart';
import '../splash_screen/view/splash_view.dart';
import 'strings_manager.dart';

class Routes {
  Routes._();

  static const String splashRoute = "/splash";
  static const String selectionRoute = "/selection";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.selectionRoute:
        return MaterialPageRoute(builder: (_) => const SelectionScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound.tr()),
        ),
        body: Center(child: Text(AppStrings.noRouteFound.tr())),
      ),
    );
  }
}
