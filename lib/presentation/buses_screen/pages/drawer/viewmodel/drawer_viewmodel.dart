
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import '../../../../../app/sl.dart';
import '../../../../../domain/usecase/logout_usecase.dart';
import '../../../../../domain/usecase/show_buses_usecase.dart';
import '../../../../base/base_cubit.dart';
import '../states/logoutstates.dart';

class DrawerViewModel extends BaseCubit
    implements DrawerViewModelInput, DrawerViewModelOutput {
  static DrawerViewModel get(context) => BlocProvider.of(context);

  final LogoutUseCase _logoutUseCase;

  DrawerViewModel(this._logoutUseCase);

  @override
  Future<void> logout() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _logoutUseCase.call(null).then((value) {
      value.fold(
            (l) {
          emit(ErrorState(
            failure: l,
            displayType: DisplayType.popUpDialog,
          ));
        },
            (r) {
          emit(LogoutSuccessState());
        },
      );
    });
  }

  @override
  void start() {
  }
}


abstract class DrawerViewModelInput {
  void logout();

}

abstract class DrawerViewModelOutput {


}
