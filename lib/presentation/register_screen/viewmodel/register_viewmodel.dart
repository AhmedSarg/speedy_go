import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/data/network/error_handler.dart';

import '../../../app/functions.dart';
import '../../../data/network/failure.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/usecase/authenticate_usecase.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../../domain/usecase/verify_phone_number_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../../resources/strings_manager.dart';
import '../view/states/register_states.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final AuthenticateUseCase _authenticateUseCase;
  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;
  final RegisterUseCase _registerCarDriverUseCase;

  RegisterViewModel(
    this._authenticateUseCase,
    this._verifyPhoneNumberUseCase,
    this._registerCarDriverUseCase,
  );

  late Selection _registerType;

  late Selection _oldRegisterType = Selection.driver;

  late RegisterType _registerBoxType;

  late List<Widget> _boxContent;

  late Widget _content;

  static RegisterViewModel get(context) => BlocProvider.of(context);

  late User user;

  final StreamController<String?> _otpStreamController =
      StreamController<String?>();
  late final Stream<FirebaseAuthException?> _verificationErrorStream;

  final TextEditingController _firstNameController =
      TextEditingController();
  final TextEditingController _lastNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nationalIdController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _otpController =
      TextEditingController(text: '      ');

  File? _drivingLicense;
  File? _carLicense;
  File? _carImage;
  File? _tukTukImage;
  Gender? _gender;

  @override
  void start() {
    _registerType = DataIntent.getSelection();
    if (_registerType == Selection.driver) {
      emit(RegisterVehicleSelectionState());
    } else {
      emit(RegisterPassengerState());
    }
  }

  @override
  Selection get getRegisterType => _registerType;

  @override
  RegisterType get getRegisterBoxType => _registerBoxType;

  @override
  List<Widget> get getBoxContent => _boxContent;

  @override
  Widget get getContent => _content;

  @override
  TextEditingController get getFirstNameController => _firstNameController;

  @override
  TextEditingController get getLastNameController => _lastNameController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  TextEditingController get getConfirmPasswordController =>
      _confirmPasswordController;

  @override
  TextEditingController get getNationalIdController => _nationalIdController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getOtpController => _otpController;

  @override
  File? get getDrivingLicense => _drivingLicense;

  @override
  File? get getCarLicense => _carLicense;

  @override
  File? get getCarImage => _carImage;

  @override
  File? get getTukTukImage => _tukTukImage;

  @override
  Gender? get getGender => _gender;

  @override
  set setRegisterType(Selection registerType) {
    _oldRegisterType = _registerType;
    _registerType = registerType;
    if (registerType == Selection.driver) {
      emit(RegisterVehicleSelectionState());
    } else {
      setRegisterBoxType = RegisterType.passenger;
      emit(ContentState());
    }
  }

  @override
  set setRegisterBoxType(RegisterType registerBoxType) {
    _registerBoxType = registerBoxType;
    if (registerBoxType == RegisterType.car) {
      emit(RegisterCarState());
    } else if (registerBoxType == RegisterType.tuktuk) {
      emit(RegisterTukTukState());
    } else if (registerBoxType == RegisterType.bus) {
      emit(RegisterBusState());
    } else {
      emit(RegisterPassengerState());
    }
  }

  @override
  set setBoxContent(List<Widget> content) {
    _boxContent = content;
    emit(ContentState());
  }

  @override
  set setContent(Widget content) {
    _content = content;
  }

  @override
  set setGender(String gender) {
    if (gender == AppStrings.registerScreenGenderFemale.tr()) {
      _gender = Gender.female;
    } else if (gender == AppStrings.registerScreenGenderMale.tr()) {
      _gender = Gender.male;
    } else {
      _gender = null;
    }
  }

  void animateToDriver() {
    _registerType = _oldRegisterType;
    Future.delayed(const Duration(milliseconds: 10), () {
      _registerType = Selection.driver;
      emit(ContentState());
    });
  }

  void chooseDrivingLicense() async {
    try {
      String path = await getImagesFromGallery();
      _drivingLicense = File(path);
      // _drivingLicense = renameFile(_drivingLicense!, 'driving_license.jpg');
      emit(RegisterImagePickSuccessState(image: _drivingLicense!));
      _oldRegisterType = Selection.driver;
      setRegisterBoxType = _registerBoxType;
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  void chooseCarLicense() async {
    try {
      String path = await getImagesFromGallery();
      _carLicense = File(path);
      // _carLicense = renameFile(_carLicense!, 'car_license.jpg');
      emit(RegisterImagePickSuccessState(image: _carLicense!));
      _oldRegisterType = Selection.driver;
      setRegisterBoxType = _registerBoxType;
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  void chooseCarImage() async {
    try {
      String path = await getImagesFromGallery();
      _carImage = File(path);
      // _carImage = renameFile(_carImage!, 'car_image.jpg');
      emit(RegisterImagePickSuccessState(image: _carImage!));
      _oldRegisterType = Selection.driver;
      setRegisterBoxType = _registerBoxType;
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  void chooseTukTukImage() async {
    try {
      String path = await getImagesFromGallery();
      _tukTukImage = File(path);
      emit(RegisterImagePickSuccessState(image: _tukTukImage!));
      _oldRegisterType = Selection.driver;
      setRegisterBoxType = _registerBoxType;
    } catch (e) {
      emit(
        RegisterImagePickFailedState(
          failure: ErrorHandler.handle(e).failure,
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  Future<void> authenticate() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _authenticateUseCase(AuthenticateUseCaseInput(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      registerType: _registerBoxType,
      otpStream: _otpStreamController.stream,
    )).then((value) {
      value.fold(
        (l) {
          emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
        },
        (r) {
          _verificationErrorStream = r;
          emit(RegisterVerifyPhoneNumberState());
        },
      );
    });
  }

  Future<void> verify() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _verifyPhoneNumberUseCase(
      VerifyPhoneNumberUseCaseInput(
        errorStream: _verificationErrorStream,
        otpStreamController: _otpStreamController,
        otp: _otpController.text.trim(),
        registerType: _registerBoxType,
      ),
    ).then((value) {
      value.fold(
        (l) {
          emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
        },
        (r) {
          register();
        },
      );
    });
  }

  Future<void> register() async {
    _registerCarDriverUseCase(
      RegisterUseCaseInput(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _gender,
        phoneNumber: _phoneNumberController.text.trim(),
        email: _emailController.text.trim(),
        nationalId: _nationalIdController.text.trim() == ''
            ? null
            : _nationalIdController.text.trim(),
        drivingLicense: _drivingLicense,
        carLicense: _carLicense,
        carImage: _carImage,
        tukTukImage: _tukTukImage,
        password: _passwordController.text.trim(),
        registerType: _registerBoxType,
      ),
    ).then((value) {
      value.fold(
        (l) {
          emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
        },
        (r) {
          emit(SuccessState(AppStrings.registerScreenSuccessMessage));
        },
      );
    });
  }

// Future<void> startVerifyPhoneNumber() async {
//   print('in verify');
//   _streamController.add(_otpController.text.trim());
//   _verifyPhoneNumberUseCase(
//     VerifyPhoneNumberUseCaseInput(
//       phoneNumber: _phoneNumberController.text.trim(),
//       user: user,
//       otp: _streamController.stream,
//     ),
//   ).then((value) {
//     print('in value');
//     value.fold(
//       (l) {
//         emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
//       },
//       (r) {
//         if (r) {
//           switch (_registerBoxType) {
//             case RegisterType.passenger:
//               // TODO: Handle this case.
//               break;
//             case RegisterType.car:
//               _registerCarDriver();
//               break;
//             case RegisterType.tuktuk:
//               // TODO: Handle this case.
//               break;
//             case RegisterType.bus:
//               // TODO: Handle this case.
//               break;
//           }
//         }
//       },
//     );
//   });
// }
//
// Future<void> onVerify() async {
//   emit(LoadingState());
//   print('in add');
//   print(_otpController.text.trim());
//   _streamController.add(_otpController.text.trim());
// }
//
// bool isVerified(BuildContext context) {
//   if (user.phoneNumber == null) {
//     return true;
//   } else {
//     return false;
//   }
// }
//
// void _registerCarDriver() {
//   emit(LoadingState(displayType: DisplayType.popUpDialog));
//   _registerCarDriverUseCase(
//     RegisterCarDriverUseCaseInput(
//       firstName: _firstNameController.text.trim(),
//       lastName: _lastNameController.text.trim(),
//       phoneNumber: _phoneNumberController.text.trim(),
//       email: _emailController.text.trim(),
//       nationalId: _nationalIdController.text.trim(),
//       drivingLicense: _drivingLicense!,
//       carLicense: _carLicense!,
//       carImage: _carImage!,
//       password: _passwordController.text.trim(),
//     ),
//   ).then(
//     (value) {
//       value.fold(
//         (l) {
//           emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
//         },
//         (r) {
//           emit(SuccessState(AppStrings.registerScreenSuccessMessage.tr()));
//         },
//       );
//     },
//   );
// }
}

abstract class RegisterViewModelInput {
  set setRegisterType(Selection registerType);

  set setRegisterBoxType(RegisterType registerBoxType);

  set setBoxContent(List<Widget> content);

  set setContent(Widget content);

  set setGender(String gender);
}

abstract class RegisterViewModelOutput {
  Selection get getRegisterType;

  RegisterType get getRegisterBoxType;

  List<Widget> get getBoxContent;

  Widget get getContent;

  TextEditingController get getFirstNameController;

  TextEditingController get getLastNameController;

  TextEditingController get getPhoneNumberController;

  TextEditingController get getPasswordController;

  TextEditingController get getConfirmPasswordController;

  TextEditingController get getNationalIdController;

  TextEditingController get getEmailController;

  TextEditingController get getOtpController;

  File? get getDrivingLicense;

  File? get getCarLicense;

  File? get getCarImage;

  File? get getTukTukImage;

  Gender? get getGender;
}
