import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/signed_user_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import 'splash_states.dart';

class SplashViewModel extends BaseCubit
    implements SplashViewModelInput, SplashViewModelOutput {
  static SplashViewModel get(context) => BlocProvider.of(context);

  final GetSignedUserUseCase _signedUserUseCase;

  SplashViewModel(this._signedUserUseCase);

  @override
  void start() async {
    await _signedUserUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            ErrorState(failure: l);
          },
          (r) {
            if (r == null) {
              emit(UserNotSignedState());
            } else {
              emit(UserSignedState());
            }
          },
        );
      },
    );
  }
}

abstract class SplashViewModelInput {}

abstract class SplashViewModelOutput {}
