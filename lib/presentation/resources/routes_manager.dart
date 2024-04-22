import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/request_history/view/request_history_screen.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/safty/safety.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/support/view/support_screen.dart';

import '../../app/sl.dart';
import '../buses_screen/pages/add_trip_screen/view/add_trip.dart';
import '../buses_screen/pages/schedule_screen/schedule_screen.dart';
import '../buses_screen/view/buses_screen.dart';
import '../common/transitions/transitions.dart';
import '../driver_trip_screen/view/driver_trip_view.dart';
import '../login_screen/view/login_view.dart';
import '../main_layout/view/main_layout_view.dart';
import '../main_layout/view/pages/profile_page/pages/edit_profile/view/edit_profile_screen.dart';
import '../main_layout/view/pages/profile_page/pages/my_trips/view/my_trips_screen.dart';
import '../onboarding_screen/view/onboarding_view.dart';
import '../passenger_map_screen/view/passenger_map_view.dart';
import '../passenger_trip_screen/view/passenger_trip_view.dart';
import '../rating_screen/view/rate_view.dart';
import '../register_screen/view/register_view.dart';
import '../selection_screen/view/selection_view.dart';
import '../splash_screen/view/splash_view.dart';
import '../verification_screen/view/verification_view.dart';
import 'strings_manager.dart';

class Routes {
  Routes._();

  //todo make splash initial route
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String selectionRoute = "/selection";
  static const String registerRoute = "/register";
  static const String verificationRoute = "/verification";
  static const String mainLayoutRoute = "/mainLayout";
  static const String passengerMapRoute = "/passengerMap";
  static const String passengerTripRoute = "/passengerTrip";
  static const String rateRoute = "/rate";
  static const String busesRoute = "/buses";
  static const String scheduleRoute = "/schedule";
  static const String addTripRoute = "/addTrip";
  static const String profileEditRoute = "/profileEdit";
  static const String myTripsRoute = "/myTrips";
  static const String driverTripRoute = "/driverTrip";
  static const String saftyRoute = "/safty";
  static const String supportRoute = "/support";
  static const String requestHistoryRoute = "/requestHistory";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoardingRoute:
        return goTo(const OnBoardingScreen());
      case Routes.loginRoute:
        initLoginUseCase();
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const LoginScreen(),
        );
      case Routes.selectionRoute:
        return MaterialPageRoute(
          builder: (_) => const SelectionScreen(),
        );
      case Routes.registerRoute:
        initAuthenticateUseCase();
        initRegisterUseCase();
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.verificationRoute:
        initStartVerifyUseCase();
        initVerifyOtpUseCase();
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const VerificationScreen(),
        );
      case Routes.mainLayoutRoute:
        initCurrentUserUseCase();
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case Routes.passengerMapRoute:
        return MaterialPageRoute(builder: (_) => const PassengerMapScreen());
      case Routes.passengerTripRoute:
        initFindDriversUseCase();
        initCalculateTwoPointsUseCase();
        initCancelTripUseCase();
        initAcceptDriverUseCase();
        initEndTripUseCase();
        return MaterialPageRoute(builder: (_) => const PassengerTripScreen());
      case Routes.rateRoute:
        return MaterialPageRoute(builder: (_) => const RateScreen());
      case Routes.busesRoute:
        return MaterialPageRoute(builder: (_) => const BusesScreen());
      case Routes.scheduleRoute:
        return MaterialPageRoute(builder: (_) => const ScheduleScreen());
      case Routes.addTripRoute:
        return MaterialPageRoute(builder: (_) => const AddTripScreen());
      case Routes.profileEditRoute:
        return MaterialPageRoute(builder: (_) => const ProfileEditPage());
      case Routes.myTripsRoute:
        return MaterialPageRoute(builder: (_) => const MyTripsScreen());
      case Routes.driverTripRoute:
        return MaterialPageRoute(builder: (_) => const DriverTripScreen());
      case Routes.saftyRoute:
        return MaterialPageRoute(builder: (_) => const SafetyScreen());
      case Routes.supportRoute:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
        case Routes.requestHistoryRoute:
      return MaterialPageRoute(builder: (_) => const RequestHistoryScreen());

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
