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

  ScheduleViewModel(this._busesDriverTripsUseCase);
   DateTime? _selectedDate;

  final UserManager _userManager = sl<UserManager>();
  Stream<List<BusModel>>? _busesStream;
  Future<void> _displayBuses() async {
    // emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _busesDriverTripsUseCase(BusesDriverTripsUseCaseInput(
      driverId: _userManager.getCurrentDriver!.uuid,
      date: _selectedDate!,
    )).then(
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
            _busesStream = r;
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
  }



  @override
  Stream<List<BusModel>>? get getBusesStream => _busesStream;

}

abstract class ScheduleViewModelInput {
  set setDate(DateTime date);
}

abstract class ScheduleViewModelOutput {
  Stream<List<BusModel>>? get getBusesStream;

}
