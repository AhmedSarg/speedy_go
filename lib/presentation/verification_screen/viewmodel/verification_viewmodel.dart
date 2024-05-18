import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/data/network/error_handler.dart';
import 'package:speedy_go/domain/models/user_manager.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/usecase/start_verify_usecase.dart';
import '../../../domain/usecase/verify_otp_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../states/verification_states.dart';

class VerificationViewModel extends BaseCubit
    implements VerificationViewModelInput, VerificationViewModelOutput {
  final StartVerifyUseCase _startVerifyUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final UserManager _userManager;

  VerificationViewModel(
    this._startVerifyUseCase,
    this._verifyOtpUseCase,
    this._userManager,
  );

  static VerificationViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _otpController =
      TextEditingController(text: '      ');

  late final String _phoneNumber;
  late final String? _email;
  late final String? _password;
  late final AuthType _authType;
  late final Function() _onVerified;
  final StreamController<String?> _otpStreamController =
      StreamController<String?>();
  late final Stream<FirebaseAuthException?> _verificationErrorStream;

  @override
  void start() {
    _phoneNumber = DataIntent.popPhoneNumber();
    _email = DataIntent.popEmail();
    _password = DataIntent.popPassword();
    _authType = DataIntent.getAuthType();
    _onVerified = DataIntent.getOnVerified();
    _startVerify();
  }

  @override
  TextEditingController get getOtpController => _otpController;

  Future<void> _startVerify() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _startVerifyUseCase(
      StartVerifyUseCaseInput(
        phoneNumber: _phoneNumber,
        email: _email,
        password: _password,
        otpStreamController: _otpStreamController,
        authType: _authType,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            _verificationErrorStream = r;
            _verificationErrorStream.listen(
              (error) {
                if (error != null) {
                  emit(
                    ErrorState(
                      failure: ErrorHandler.handle(error).failure,
                      displayType: DisplayType.popUpDialog,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  Future<void> verifyOtp() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _verifyOtpUseCase(
      VerifyOtpUseCaseInput(
        otpStreamController: _otpStreamController,
        errorStream: _verificationErrorStream,
        otp: _otpController.text.trim(),
        phoneNumber: _phoneNumber,
        authType: _authType,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) async {
            emit(await _onVerified());
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
}

abstract class VerificationViewModelInput {}

abstract class VerificationViewModelOutput {
  TextEditingController get getOtpController;
}
