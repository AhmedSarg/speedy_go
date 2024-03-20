import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app/sl.dart';
import 'strings_manager.dart';

class Routes {
  Routes._();

  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String mainLayoutRoute = "/mainLayout";
  static const String loginRoute = "/login";
  static const String boardRoute = "/board";
  static const String noInternetRoute = "/noInternet";
  static const String onGoingEventLayoutRoute = "/onGoingEventLayout";
  static const String trackDetailsRoute = "/trackDetails";
  static const String newsDetailsRoute = "/newsDetails";
  static const String awardDetailsRoute = "/awardDetails";
  static const String eventDetailsRoute = "/eventDetails";
  static const String orderRoute = "/order";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        // return MaterialPageRoute(builder: (_) => const SplashScreen());
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
