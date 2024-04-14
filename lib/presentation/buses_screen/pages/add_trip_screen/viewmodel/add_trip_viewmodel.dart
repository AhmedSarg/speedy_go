import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/base_cubit.dart';


class AddTripViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {

  static AddTripViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _numController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _toSearchController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String _num = '1';
  String _toCity = '';

  @override
  void start() {}

  @override
  TextEditingController get getNumController => _numController;

  @override
  TextEditingController get getPriceController => _priceController;

  @override
  TextEditingController get getFromController => _fromController;

  @override
  TextEditingController get getToController => _toController;

  @override
  TextEditingController get getToSearchController => _toSearchController;

  @override
  TextEditingController get getDateController => _dateController;

  @override
  String get getNum => _num;
  String get getToCity => _toCity;

  @override
  void setNum(String number) {
    _num = number;
    getNumController.text= _num;

  }



  @override
  void setTo(String toCity) {
    _toCity = toCity;
    getToSearchController.text = _toCity;
    getToController.text= getToSearchController.text;
  }
}

abstract class LoginViewModelInput {
  void setNum(String number);
  void setTo(String toCity);

}

abstract class LoginViewModelOutput {

  TextEditingController get getNumController;

  TextEditingController get getPriceController;

  TextEditingController get getFromController;

  TextEditingController get getToController;

  TextEditingController get getToSearchController;

  TextEditingController get getDateController;
}
