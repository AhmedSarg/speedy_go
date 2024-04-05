import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/usecase/login_usecase.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';

class LoginViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  LoginType _selection = LoginType.phoneNumber;

  static LoginViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryCode = '---';

  @override
  void start() {}

  @override
  LoginType get getLoginType => _selection;

  @override
  void setLoginType(LoginType loginType) {
    _selection = loginType;
    emit(ContentState());
  }

  Future<void> loginWithEmailAndPassword() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _loginUseCase(
      LoginUseCaseInput(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        loginType: LoginType.emailPassword,
        otpStream: null,
      ),
    ).then((value) {
      value.fold(
        (l) {
          emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
        },
        (r) {
          emit(SuccessState('Login Success'));
        },
      );
    });
  }

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  String get getCountryCode => _countryCode;

  @override
  void setCountryCode(String countryCode) {
    _countryCode = countryCode;
  }
}

abstract class LoginViewModelInput {
  void setLoginType(LoginType loginType);

  void setCountryCode(String countryCode);
}

abstract class LoginViewModelOutput {
  LoginType get getLoginType;

  TextEditingController get getPhoneNumberController;

  TextEditingController get getEmailController;

  TextEditingController get getPasswordController;

  String get getCountryCode;
}
