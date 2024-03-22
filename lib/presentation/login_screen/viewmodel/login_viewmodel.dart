import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';

class LoginViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {
  LoginType _selection = LoginType.phoneNumber;

  static LoginViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}

  @override
  LoginType get getLoginType => _selection;

  @override
  void setLoginType(LoginType loginType) {
    _selection = loginType;
    emit(ContentState());
  }
}

abstract class LoginViewModelInput {
  void setLoginType(LoginType loginType);
}

abstract class LoginViewModelOutput {
  LoginType get getLoginType;
}
