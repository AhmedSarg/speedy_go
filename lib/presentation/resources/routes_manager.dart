import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:speedy_go/presentation/trip_screen/view/pages/map_pages/view/pages/search_map.dart';
import 'package:speedy_go/presentation/trip_screen/view/pages/map_pages/view/pages/trip_map_from_to.dart';

import '../../app/sl.dart';
import '../common/transitions/transitions.dart';
import '../login_screen/view/login_view.dart';
import '../main_layout/view/main_layout_view.dart';
import '../onboarding_screen/view/onboarding_view.dart';
import '../rating_screen/view/rate_view.dart';
import '../register_screen/view/register_view.dart';
import '../selection_screen/view/selection_view.dart';
import '../splash_screen/view/splash_view.dart';
import '../trip_screen/view/trip_view.dart';
import '../verification_screen/view/verification_view.dart';
import 'strings_manager.dart';

class Routes {
  Routes._();
  //todo make splash initial route
  static const String splashRoute = "/splash";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String selectionRoute = "/selection";
  static const String registerRoute = "/register";
  static const String verificationRoute = "/verification";
  static const String mainLayoutRoute = "/mainLayout";
  static const String tripRoute = "/trip";
  static const String rateRoute = "/rate";
  static const String searchMapRoute = "/searchMap";
  static const String fromToRoute = "/fromTo";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoardingRoute:
        return goTo(const OnBoardingScreen());
      case Routes.loginRoute:
        initLoginUseCase();
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.selectionRoute:
        return MaterialPageRoute(builder: (_) => const SelectionScreen());
      case Routes.registerRoute:
        initAuthenticateUseCase();
        initRegisterUseCase();
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.verificationRoute:
        initStartVerifyUseCase();
        initVerifyOtpUseCase();
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      case Routes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case Routes.tripRoute:
        return MaterialPageRoute(builder: (_) => const TripScreen());
      case Routes.rateRoute:
        return MaterialPageRoute(builder: (_) => const RateScreen());
      case Routes.fromToRoute:
        return MaterialPageRoute(builder: (_) => const TripFromTo());
      case Routes.searchMapRoute:
        return MaterialPageRoute(builder: (_) => const SearchMap());
      // case Routes.myCustomWidget:
      //   return MaterialPageRoute(builder: (_) => MyCustomWidget());
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
