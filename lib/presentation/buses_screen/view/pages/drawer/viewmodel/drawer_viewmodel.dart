import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import '../../../../../../app/sl.dart';
import '../../../../../../domain/usecase/logout_usecase.dart';
import '../../../../../base/base_cubit.dart';
import '../states/logout_states.dart';

class DrawerViewModel extends BaseCubit
    implements DrawerViewModelInput, DrawerViewModelOutput {
  static DrawerViewModel get(context) => BlocProvider.of(context);

  final LogoutUseCase _logoutUseCase;
  final UserManager _userManager = sl<UserManager>();

  DrawerViewModel(this._logoutUseCase);

  late String _name;
  late String _imagePath;

  @override
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
            emit(LogoutSuccessState());
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

abstract class DrawerViewModelInput {
  void logout();
}

abstract class DrawerViewModelOutput {
  String get getName;
  String get getImagePath;
}
