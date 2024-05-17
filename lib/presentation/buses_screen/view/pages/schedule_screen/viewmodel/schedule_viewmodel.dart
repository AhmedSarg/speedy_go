import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

import '../../../../../../app/sl.dart';
import '../../../../../../domain/usecase/buses_driver_trips_usecase.dart';
import '../../../../../base/base_cubit.dart';

class ScheduleViewModel extends BaseCubit
    implements ScheduleViewModelInput, ScheduleViewModelOutput {
  static ScheduleViewModel get(context) => BlocProvider.of(context);

  final BusesDriverTripsUseCase _busesDriverTripsUseCase;
  final UserManager _userManager = sl<UserManager>();

  DateTime _selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Stream<List<Future<TripBusModel>>>? _busesStream;

  ScheduleViewModel(this._busesDriverTripsUseCase);

  Future<void> _displayBuses() async {
    await _busesDriverTripsUseCase(
      BusesDriverTripsUseCaseInput(
        driverId: _userManager.getCurrentDriver!.uuid,
        date: _selectedDate,
      ),
    ).then(
      (value) {
        value.fold(
          (failure) {
            emit(
              ErrorState(
                failure: failure,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (stream) {
            _busesStream = stream;
            emit(ContentState());
          },
        );
      },
    );
  }

  @override
  void start() {
    _displayBuses();
  }

  @override
  set setDate(DateTime date) {
    _selectedDate = date;
    _displayBuses();
  }

  @override
  DateTime get getSelectedDate => _selectedDate!;

  @override
  Stream<List<Future<TripBusModel>>>? get getBusesStream => _busesStream;
}

abstract class ScheduleViewModelInput {
  set setDate(DateTime date);
}

abstract class ScheduleViewModelOutput {
  Stream<List<Future<TripBusModel>>>? get getBusesStream;

  DateTime get getSelectedDate;
}
