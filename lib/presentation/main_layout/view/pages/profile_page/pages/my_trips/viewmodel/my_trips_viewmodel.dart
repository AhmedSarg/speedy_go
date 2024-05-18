import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/domain/usecase/history_bus_current_trips_usecase.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

import '../../../../../../../../app/sl.dart';
import '../../../../../../../../domain/usecase/history_bus_past_trips_usecase.dart';

class MyTripsViewModel extends BaseCubit
    implements MyTripsViewModelInput, MyTripsViewModelOutput {
  static MyTripsViewModel get(context) => BlocProvider.of(context);

  final HistoryBusCurrentTripsUseCase _historyBusCurrentTripsUseCase;

  final HistoryBusPastTripsUseCase _historyBusPastTripsUseCase;

  final UserManager _userManager = sl<UserManager>();

  MyTripsViewModel(
    this._historyBusCurrentTripsUseCase,
    this._historyBusPastTripsUseCase,
  );

  List<TripBusModel> _currentTrips = [];

  List<TripBusModel> _pastTrips = [];

  Future<void> _fetchCurrentTrips() async {
    emit(LoadingState());
    await _historyBusCurrentTripsUseCase(
      HistoryBusCurrentTripsUseCaseInput(
        id: _userManager.getCurrentPassenger!.uuid,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {
            _currentTrips = r;
          },
        );
      },
    );
  }

  Future<void> _fetchPastTrips() async {
    emit(LoadingState());
    await _historyBusPastTripsUseCase(
      HistoryBusPastTripsUseCaseInput(
        id: _userManager.getCurrentPassenger!.uuid,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {
            _pastTrips = r;
          },
        );
      },
    );
  }

  @override
  void start() async {
    emit(LoadingState());
    await _fetchCurrentTrips();
    await _fetchPastTrips();
    emit(ContentState());
  }

  @override
  List<TripBusModel> get getCurrentTrips => _currentTrips;

  @override
  List<TripBusModel> get getPastTrips => _pastTrips;
}

abstract class MyTripsViewModelInput {}

abstract class MyTripsViewModelOutput {
  List<TripBusModel> get getCurrentTrips;

  List<TripBusModel> get getPastTrips;
}
