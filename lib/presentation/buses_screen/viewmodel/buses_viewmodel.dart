import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/buses_screen/states/buses_states.dart';

import '../../../app/sl.dart';
import '../../../domain/models/user_manager.dart';
import '../../../domain/usecase/logout_usecase.dart';
import '../../base/base_states.dart';

class BusesViewModel extends BaseCubit
    implements BusesViewModelInput, BusesViewModelOutput {
  static BusesViewModel get(context) => BlocProvider.of(context);

  final LogoutUseCase _logoutUseCase;

  BusesViewModel(this._logoutUseCase);
  final UserManager _userManager = sl<UserManager>();

  late String _name;
  late String _imagePath;

  Future<void> logout() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _logoutUseCase.call(null).then(
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
            emit(LogoutState());
          },
        );
      },
    );
  }

  @override
  void start() {
    _name = _userManager.getCurrentDriver!.firstName;
    _imagePath = _userManager.getCurrentDriver!.imagePath;
  }

  @override
  String get getName => _name;

  @override
  String get getImagePath => _imagePath;
}

abstract class BusesViewModelInput {}

abstract class BusesViewModelOutput {
  String get getName;

  String get getImagePath;
}
