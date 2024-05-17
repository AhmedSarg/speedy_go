import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/domain/models/user_manager.dart';

import '../../../domain/usecase/signed_user_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/splash_states.dart';

class SplashViewModel extends BaseCubit
    implements SplashViewModelInput, SplashViewModelOutput {
  static SplashViewModel get(context) => BlocProvider.of(context);

  final GetSignedUserUseCase _signedUserUseCase;
  final UserManager _userManager;

  SplashViewModel(this._signedUserUseCase, this._userManager);

  @override
  void start() async {
    await _signedUserUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            ErrorState(failure: l);
          },
          (r) async {
            if (r == null) {
              emit(UserNotSignedState());
            } else {
              if (_userManager.getCurrentUserType == UserType.driver &&
                  _userManager.getCurrentDriver!.vehicleType ==
                      VehicleType.bus) {
                emit(BusDriverSignedState());
              } else if (_userManager.getCurrentUserType == UserType.driver) {
                emit(DriverSignedState());
              } else {
                emit(PassengerSignedState());
              }
            }
          },
        );
      },
    );
  }
}

abstract class SplashViewModelInput {}

abstract class SplashViewModelOutput {}
