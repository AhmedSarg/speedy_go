import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/cache_data_source.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/data_source/runtime_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/app_prefs.dart';
import '../data/network/assets_loader.dart';
import '../data/network/dio_factory.dart';
import '../data/network/fireauth_factory.dart';
import '../data/network/firebase_app_check_factory.dart';
import '../data/network/firestorage_factory.dart';
import '../data/network/firestore_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/models/user_manager.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/add_bus_usecase.dart';
import '../domain/usecase/add_trip_bus.dart';
import '../domain/usecase/change_driver_status_usecase.dart';
import '../domain/usecase/find_trips_usecase.dart';
import '../domain/usecase/logout_usecase.dart';
import '../domain/usecase/accept_driver_usecase.dart';
import '../domain/usecase/authenticate_usecase.dart';
import '../domain/usecase/calculate_two_points_usecase.dart';
import '../domain/usecase/cancel_trip_usecase.dart';
import '../domain/usecase/rate_usecase.dart';
import '../domain/usecase/signed_user_usecase.dart';
import '../domain/usecase/current_user_usecase.dart';
import '../domain/usecase/end_trip_usecase.dart';
import '../domain/usecase/find_drivers_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../domain/usecase/start_verify_usecase.dart';
import '../domain/usecase/verify_otp_usecase.dart';
import 'date_ntp.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<DateNTP>(() => DateNTPImpl());
  sl.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(sharedPreferences));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnection()));

  // sl.registerLazySingleton<GSheetFactory>(() => GSheetFactoryImpl());

  sl.registerLazySingleton<AssetsLoader>(() => AssetsLoaderImpl());
  var dio = await DioFactory().getDio();

  sl.registerLazySingleton<Dio>(() => dio);
  var firestore = await FirestoreFactoryImpl().create();
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
  var fireAuth = await FireAuthFactoryImpl().create();
  sl.registerLazySingleton<FirebaseAuth>(() => fireAuth);
  var fireStorage = await FireStorageFactoryImpl().create();
  sl.registerLazySingleton<FirebaseStorage>(() => fireStorage);
  await FirebaseAppCheckFactoryImpl().create();
  sl.registerLazySingleton<UserManager>(() => UserManager());
  // sl.registerLazySingleton<UserManager<PassengerModel>>(
  //     () => UserManager<PassengerModel>());
  // sl.registerLazySingleton<UserManager<DriverModel>>(
  //     () => UserManager<DriverModel>());
  sl.registerLazySingleton<AppServiceClient>(() => AppServiceClientImpl(sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<RuntimeDataSource>(() => RuntimeDataSourceImpl());
  sl.registerLazySingleton<CacheDataSource>(
    () => CacheDataSourceImpl(sl(), sl()),
  );

  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sl()));

  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(sl(), sl(), sl(), sl()));
}

void initAuthenticateUseCase() {
  if (GetIt.instance.isRegistered<AuthenticateUseCase>() == false) {
    sl.registerFactory<AuthenticateUseCase>(() => AuthenticateUseCase(sl()));
  }
}

void initStartVerifyUseCase() {
  if (GetIt.instance.isRegistered<StartVerifyUseCase>() == false) {
    sl.registerFactory<StartVerifyUseCase>(() => StartVerifyUseCase(sl()));
  }
}

void initVerifyOtpUseCase() {
  if (GetIt.instance.isRegistered<VerifyOtpUseCase>() == false) {
    sl.registerFactory<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl()));
  }
}

void initRegisterUseCase() {
  if (GetIt.instance.isRegistered<RegisterUseCase>() == false) {
    sl.registerFactory<RegisterUseCase>(() => RegisterUseCase(sl()));
  }
}

void initLoginUseCase() {
  if (GetIt.instance.isRegistered<LoginUseCase>() == false) {
    sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl()));
  }
}

void initLogOutUseCase() {
  if (GetIt.instance.isRegistered<LogoutUseCase>() == false) {
    sl.registerFactory<LogoutUseCase>(() => LogoutUseCase(sl()));
  }
}

void initFindDriversUseCase() {
  if (GetIt.instance.isRegistered<FindDriversUseCase>() == false) {
    sl.registerFactory<FindDriversUseCase>(() => FindDriversUseCase(sl()));
  }
}

void initCalculateTwoPointsUseCase() {
  if (GetIt.instance.isRegistered<CalculateTwoPointsUseCase>() == false) {
    sl.registerFactory<CalculateTwoPointsUseCase>(
        () => CalculateTwoPointsUseCase(sl()));
  }
}

void initCancelTripUseCase() {
  if (GetIt.instance.isRegistered<CancelTripUseCase>() == false) {
    sl.registerFactory<CancelTripUseCase>(() => CancelTripUseCase(sl()));
  }
}

void initCurrentUserUseCase() {
  if (GetIt.instance.isRegistered<CurrentUserUseCase>() == false) {
    sl.registerFactory<CurrentUserUseCase>(() => CurrentUserUseCase(sl()));
  }
}

void initAcceptDriverUseCase() {
  if (GetIt.instance.isRegistered<AcceptDriverUseCase>() == false) {
    sl.registerFactory<AcceptDriverUseCase>(() => AcceptDriverUseCase(sl()));
  }
}

void initEndTripUseCase() {
  if (GetIt.instance.isRegistered<EndTripUseCase>() == false) {
    sl.registerFactory<EndTripUseCase>(() => EndTripUseCase(sl()));
  }
}

void initAddBusUseCase() {
  if (GetIt.instance.isRegistered<EndTripUseCase>() == false) {
    sl.registerFactory<AddBusUseCase>(() => AddBusUseCase(sl()));
  }
}

void initAddBusTripUseCase() {
  if (GetIt.instance.isRegistered<EndTripUseCase>() == false) {
    sl.registerFactory<AddBusTripUseCase>(() => AddBusTripUseCase(sl()));
  }
}

void initRateUseCase() {
  if (GetIt.instance.isRegistered<RateUseCase>() == false) {
    sl.registerFactory<RateUseCase>(() => RateUseCase(sl()));
  }
}

void initGetSignedUserUseCase() {
  if (GetIt.instance.isRegistered<GetSignedUserUseCase>() == false) {
    sl.registerFactory<GetSignedUserUseCase>(() => GetSignedUserUseCase(sl()));
  }
}

void initChangeDriverStatusUseCase() {
  if (GetIt.instance.isRegistered<ChangeDriverStatusUseCase>() == false) {
    sl.registerFactory<ChangeDriverStatusUseCase>(() => ChangeDriverStatusUseCase(sl()));
  }
}

void initFindTripsUseCase() {
  if (GetIt.instance.isRegistered<FindTripsUseCase>() == false) {
    sl.registerFactory<FindTripsUseCase>(() => FindTripsUseCase(sl()));
  }
}
