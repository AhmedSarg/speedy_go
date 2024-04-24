import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/main_layout/view/main_layout_view.dart';
import 'package:speedy_go/presentation/onboarding_screen/view/onboarding_view.dart';
import 'package:speedy_go/presentation/splash_screen/viewmodel/splash_states.dart';

import '../../../domain/usecase/checkLoginUseCase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../resources/assets_manager.dart';


class SplashViewModel extends BaseCubit
    implements SplashViewModelInput, SplashViewModelOutput {
  static SplashViewModel get(context) => BlocProvider.of(context);

  final BuildContext _context;
  final GetSignedUserUseCase _signedUserUseCase;

  SplashViewModel(this._context, this._signedUserUseCase);

  @override
  void start() async {
    final userResult = await _signedUserUseCase(null);

    Future.delayed(
      const Duration(seconds: 1),
          () {
        _signedUserUseCase(null).then(
              (value) {
            value.fold(
                  (l) {
                ErrorState(
                  failure: l,
                  retry: () {
                    start();
                  },
                );
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
      },
    );


  }
}

abstract class SplashViewModelInput {}

abstract class SplashViewModelOutput {}