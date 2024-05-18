import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/user_manager.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../../resources/strings_manager.dart';
import '../states/login_states.dart';

class LoginViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {
  final LoginUseCase _loginUseCase;
  final UserManager _userManager;

  LoginViewModel(this._loginUseCase, this._userManager);

  LoginType _selection = LoginType.phoneNumber;

  static LoginViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _countryCodes = [
    '---',
    '+20',
    '+966',
  ];

  late String _countryCode = _countryCodes[0];

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
    await _loginUseCase(
      LoginUseCaseInput(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            emit(SuccessState(
                message: AppStrings.verificationScreenLoginSuccessMessage));
            if (_userManager.getCurrentUserType == UserType.driver &&
                _userManager.getCurrentDriver!.vehicleType == VehicleType.bus) {
              emit(UserIsBusDriverState());
            } else if (_userManager.getCurrentUserType == UserType.driver) {
              emit(UserIsDriverState());
            } else {
              emit(UserIsPassengerState());
            }
          },
        );
      },
    );
  }

  void loginWithPhoneNumber() {
    String phoneNumber =
        _countryCode + _phoneNumberController.text.trim().substring(1);
    DataIntent.pushPhoneNumber(phoneNumber);
    DataIntent.setAuthType(AuthType.login);
    DataIntent.setOnVerified(() {
      return SuccessState(
          message: AppStrings.verificationScreenLoginSuccessMessage);
    });
    emit(LoginVerifyPhoneNumberState());
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
  List<String> get getCountryCodes => _countryCodes;

  @override
  void setCountryCode(String countryCode) {
    _countryCode = countryCode;
    emit(ContentState());
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

  List<String> get getCountryCodes;
}
