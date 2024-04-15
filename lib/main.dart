import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/data/data_source/remote_data_source.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'app/app.dart';
import 'app/sl.dart';
import 'presentation/resources/langauge_manager.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Bloc.observer = MyBlocObserver();

  // await (await SharedPreferences.getInstance()).clear();
  await initAppModule();

  //TODO: remove on release
  //Created by youssef samy
  // if (kDebugMode) {
  //   test();
  // }
  // var _rem = RemoteDataSourceImpl(sl(), sl(), sl());
  //
  // _rem.findDrivers(
  //   passengerId: '9a2a6870-1a0b-1f5c-8a97-55979f1354eb',
  //   tripType: TripType.car,
  //   pickupLocation: const LatLng(0, 0),
  //   destinationLocation: const LatLng(1, 1),
  //   price: 10,
  // );

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguages.locals,
      path: AppLanguages.translationsPath,
      fallbackLocale: AppLanguages.fallBackLocal,
      startLocale: AppLanguages.startLocal,
      useOnlyLangCode: true,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}
