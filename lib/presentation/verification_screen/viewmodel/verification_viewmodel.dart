import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/usecase/start_verify_usecase.dart';
import '../../../domain/usecase/verify_otp_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';

class VerificationViewModel extends BaseCubit
    implements VerificationViewModelInput, VerificationViewModelOutput {
  final StartVerifyUseCase _startVerifyUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  VerificationViewModel(
    this._startVerifyUseCase,
    this._verifyOtpUseCase,
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
    ).then((value) {
      value.fold(
        (l) {
          emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
        },
        (r) {
          _verificationErrorStream = r;
        },
      );
    });
  }

  Future<void> verifyOtp() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _verifyOtpUseCase(
      VerifyOtpUseCaseInput(
        otpStreamController: _otpStreamController,
        errorStream: _verificationErrorStream,
        otp: _otpController.text.trim(),
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) async {
            emit(await _onVerified());
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
