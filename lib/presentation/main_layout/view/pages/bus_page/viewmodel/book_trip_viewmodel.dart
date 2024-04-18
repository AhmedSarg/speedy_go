import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/states/add_trip_states.dart';

import '../../../../../base/base_cubit.dart';


class BookTripViewModel extends BaseCubit
    implements AddTripViewModelInput, AddTripViewModelOutput {
  static BookTripViewModel get(context) => BlocProvider.of(context);


  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String _selectedDate = '';
  String _selectedTo = '';
  String _selectedFrom = '';

  @override
  void start() {}



  @override
  TextEditingController get getFromController => _fromController;

  @override
  TextEditingController get getToController => _toController;



  @override
  TextEditingController get getDateController => _dateController;


  String get getDate => _selectedDate;
  String get getTo => _selectedTo;
  String get getFrom => _selectedFrom;

  @override

  @override
  set setDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM d, yyyy');

    _selectedDate = formatter.format(date);
    _dateController.text = _selectedDate;
  }

  set getTo(String toCity) {
    _selectedTo = toCity;
    _toController.text = _selectedTo;
  }

  set getFrom(String fromCity) {
    _selectedFrom = fromCity;
    _fromController.text = _selectedFrom;
  }


  Future<void> searchTrip() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));


  }



  @override
  set setFrom(String fromCity) {
    _selectedFrom = fromCity;
    _fromController.text = _selectedFrom;  }

  @override
  set setTo(String toCity) {
    _selectedTo = toCity;
    _toController.text = _selectedTo;   }
}

abstract class AddTripViewModelInput {

  set setDate(DateTime date);
  set setTo(String toCity);
  set setFrom(String fromCity);
}

abstract class AddTripViewModelOutput {


  TextEditingController get getFromController;

  TextEditingController get getToController;


  TextEditingController get getDateController;
}
