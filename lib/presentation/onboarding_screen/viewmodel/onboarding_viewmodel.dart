
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_cubit.dart';
import 'onboarding_states.dart';

class OnboardingViewModel extends BaseCubit
    implements OnboardingViewModelInput, OnboardingViewModelOutput {

  @override
  void start() {}

  @override
  void getStartBtnOnTap() {
    // bool isLogin = true;
    //
    // if (isLogin) {
    //   emit(OnBoardingGoToHomeState());
    // } else {
    //   emit(OnBoardingGoToLoginState());
    // }
    emit(OnBoardingGoToHomeState());
  }

  static OnboardingViewModel get(context) => BlocProvider.of(context);

}

abstract class OnboardingViewModelInput {
  void getStartBtnOnTap();
}

abstract class OnboardingViewModelOutput {}
