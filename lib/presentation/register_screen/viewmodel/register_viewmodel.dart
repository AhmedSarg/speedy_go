import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterViewModelInput, RegisterViewModelOutput {
  RegisterType _selection = RegisterType.passenger;

  static RegisterViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}

  @override
  RegisterType get getRegisterType => _selection;

  @override
  void setRegisterType(RegisterType loginType) {
    _selection = loginType;
    emit(ContentState());
  }
}

abstract class RegisterViewModelInput {
  void setRegisterType(RegisterType loginType);
}

abstract class RegisterViewModelOutput {
  RegisterType get getRegisterType;
}
