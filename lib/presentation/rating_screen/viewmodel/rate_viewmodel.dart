
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/rating_screen/view/states/rate_states.dart';

import '../../base/base_cubit.dart';

class RateViewModel extends BaseCubit
    implements RateViewModelInput, RateViewModelOutput {
  RateViewModel();

  late int indexRate = 0;

  static RateViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}

  void rated(int rate){
    indexRate = rate;
    print(rate);
    emit(ChangeRateState());
  }

  bool changeRate(int rate){
    return rate<=indexRate;
  }

}

abstract class RateViewModelInput {
}

abstract class RateViewModelOutput {
  // Stream<bool> get outputLoading;
}
