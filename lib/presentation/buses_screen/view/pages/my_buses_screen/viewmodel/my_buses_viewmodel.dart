import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import '../../../../../../app/sl.dart';
import '../../../../../../domain/usecase/show_buses_usecase.dart';
import '../../../../../base/base_cubit.dart';

class MyBusesViewModel extends BaseCubit
    implements MyBusesViewModelInput, MyBusesViewModelOutput {
  static MyBusesViewModel get(context) => BlocProvider.of(context);

  final DisplayBusesUseCase _displayBusesUseCase;

  MyBusesViewModel(this._displayBusesUseCase);

  final UserManager _userManager = sl<UserManager>();
    Stream<List<BusModel>>? _busesStream;
  Future<void> _displayBuses() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _displayBusesUseCase(DisplayBusesUseCaseInput(
            driverId: _userManager.getCurrentDriver!.uuid))
        .then(
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
  Stream<List<BusModel>>? get getBusesStream => _busesStream;

}

abstract class MyBusesViewModelInput {}

abstract class MyBusesViewModelOutput {


   Stream<List<BusModel>>? get getBusesStream;
}
