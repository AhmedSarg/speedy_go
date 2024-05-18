import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/driver_main_layout/view/driver_main_layout_view.dart';

import '../../app/sl.dart';
import '../buses_screen/view/buses_screen.dart';
import '../buses_screen/view/pages/add_bus_screen/view/add_bus_view.dart';
import '../buses_screen/view/pages/add_trip_screen/view/add_trip_view.dart';
import '../buses_screen/view/pages/my_buses_screen/view/my_buses_screen.dart';
import '../buses_screen/view/pages/schedule_screen/view/schedule_screen.dart';
import '../common/transitions/transitions.dart';
import '../edit_profile_screen/view/edit_profile_view.dart';
import '../login_screen/view/login_view.dart';
import '../main_layout/view/main_layout_view.dart';
import '../main_layout/view/pages/bus_page/pages/bus_trips_page/view/bus_trips_view.dart';
import '../main_layout/view/pages/profile_page/pages/my_trips/view/my_trips_view.dart';
import '../main_layout/view/pages/profile_page/pages/request_history/view/request_history_view.dart';
import '../main_layout/view/pages/profile_page/pages/safty/safety.dart';
import '../main_layout/view/pages/profile_page/pages/support/view/support_screen.dart';
import '../onboarding_screen/view/onboarding_view.dart';
import '../passenger_map_screen/view/passenger_map_view.dart';
import '../passenger_trip_screen/view/passenger_trip_view.dart';
import '../permissions_screen/view/permissions_view.dart';
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
  static const String addBusTripRoute = "/addTrip";
  static const String myBusesRoute = "/myBuses";
  static const String addBusRoute = "/addBus";
  static const String profileEditRoute = "/profileEdit";
  static const String myTripsRoute = "/myTrips";
  static const String driverMainLayoutRoute = "/driverMainLayout";
  static const String safetyRoute = "/safety";
  static const String supportRoute = "/support";
  static const String requestHistoryRoute = "/requestHistory";
  static const String permissionsRoute = "/permissions";
  static const String viewBusTripsRoute = "/viewBusTrips";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        initGetSignedUserUseCase();
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
        initFindBusTripsUseCase();
        initBookBusTripUseCase();
        initLogOutUseCase();
        initHistoryTripsUseCase();
        initHistoryBusCurrentTripsUseCase();
        initHistoryBusPastTripsUseCase();
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
        initRateUseCase();
        return MaterialPageRoute(builder: (_) => const RateScreen());
      case Routes.busesRoute:
        initLogOutUseCase();
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const BusesScreen(),
        );
      case Routes.scheduleRoute:
        initBusesDriverTripsUseCase();
        return MaterialPageRoute(builder: (_) => const ScheduleScreen());
      case Routes.myBusesRoute:
        initDisplayBusesUseCase();
        return MaterialPageRoute(builder: (_) => const MyBusesScreen());
      case Routes.addBusTripRoute:
        initAddBusTripUseCase();
        initDisplayBusesUseCase();
        return MaterialPageRoute(builder: (_) => const AddBusTripScreen());
      case Routes.addBusRoute:
        initAddBusUseCase();
        return MaterialPageRoute(builder: (_) => const AddBusScreen());
      case Routes.profileEditRoute:
        initChangeAccountInfoUseCase();
        return MaterialPageRoute(builder: (_) => const ProfileEditPage());
      case Routes.myTripsRoute:
        return MaterialPageRoute(builder: (_) => const MyTripsScreen());
      case Routes.driverMainLayoutRoute:
        initLogOutUseCase();
        initChangeDriverStatusUseCase();
        initFindTripsUseCase();
        initAcceptTripUseCase();
        initCancelAcceptTripUseCase();
        initEndTripUseCase();
        return MaterialPageRoute(builder: (_) => const DriverMainScreen());
      case Routes.safetyRoute:
        return MaterialPageRoute(builder: (_) => const SafetyScreen());
      case Routes.supportRoute:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      case Routes.requestHistoryRoute:
        return MaterialPageRoute(builder: (_) => const RequestHistoryScreen());
      case Routes.permissionsRoute:
        return MaterialPageRoute(builder: (_) => const PermissionsScreen());
      case Routes.viewBusTripsRoute:
        return MaterialPageRoute(builder: (_) => const BusTripsPage());

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
