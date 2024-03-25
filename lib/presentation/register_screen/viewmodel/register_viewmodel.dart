import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../view/states/register_states.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterViewModelInput, RegisterViewModelOutput {
  Selection _registerType = Selection.passenger;

  RegisterType _registerBoxType = RegisterType.passenger;

  late double _boxHeight;

  late List<Widget> _boxContent;

  static RegisterViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {
    emit(RegisterPassengerState());
  }

  @override
  Selection get getRegisterType => _registerType;

  @override
  RegisterType get getRegisterBoxType => _registerBoxType;

  @override
  double get getBoxHeight => _boxHeight;

  @override
  List<Widget> get getBoxContent => _boxContent;

  @override
  set setRegisterType(Selection registerType) {
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
    emit(ContentState());
  }

  @override
  set setBoxHeight(double value) {
    _boxHeight = value;
    emit(ContentState());
  }

  @override
  set setBoxContent(List<Widget> content) {
    _boxContent = content;
    emit(ContentState());
  }
}

abstract class RegisterViewModelInput {
  set setRegisterType(Selection registerType);

  set setRegisterBoxType(RegisterType registerBoxType);

  set setBoxHeight(double value);

  set setBoxContent(List<Widget> content);
}

abstract class RegisterViewModelOutput {
  Selection get getRegisterType;

  RegisterType get getRegisterBoxType;

  double get getBoxHeight;

  List<Widget> get getBoxContent;
}
