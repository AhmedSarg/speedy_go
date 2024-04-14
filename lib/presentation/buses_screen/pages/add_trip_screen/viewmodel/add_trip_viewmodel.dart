import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

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
  String _toCity = 'daly__________';
  String _selectedDate = '';

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

  String get getNum => _num;
  String get getDate => _selectedDate;
  String get getToCity => _toCity;

  @override
  void setNum(String number) {
    _num = number;
    _numController.text= _num;

  }
@override
  void setDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM d, yyyy');

    _selectedDate = formatter.format(date);
    _dateController.text = _selectedDate;
  }


  @override
  set setTo(String toCity) {
    _toCity = toCity;
     _toSearchController.text = _toCity;
     _toController.text= toCity;

      emit(ContentState());
  }
}

abstract class LoginViewModelInput {
  void setNum(String number);
  set setTo(String toCity);
  void setDate(DateTime date);

}

abstract class LoginViewModelOutput {

  TextEditingController get getNumController;

  TextEditingController get getPriceController;

  TextEditingController get getFromController;

  TextEditingController get getToController;

  TextEditingController get getToSearchController;

  TextEditingController get getDateController;
}
