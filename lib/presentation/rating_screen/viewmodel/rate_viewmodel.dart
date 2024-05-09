import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/rate_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../states/rate_states.dart';

class RateViewModel extends BaseCubit
    implements RateViewModelInput, RateViewModelOutput {
  final RateUseCase _rateUseCase;

  RateViewModel(this._rateUseCase);

  static RateViewModel get(context) => BlocProvider.of(context);

  int indexRate = 0;

  late String _userId;

  @override
  void start() {
    _userId = DataIntent.popRatedUserId();
  }

  void rated(int rate) {
    indexRate = rate;
    emit(ChangeRateState());
  }

  bool changeRate(int rate) {
    return rate <= indexRate;
  }

  Future<void> rateDriver() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _rateUseCase(
      RateUseCaseInput(
        userId: _userId,
        rate: indexRate,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            emit(RateSuccessState());
          },
        );
      },
    );
  }
}

abstract class RateViewModelInput {}

abstract class RateViewModelOutput {
}
