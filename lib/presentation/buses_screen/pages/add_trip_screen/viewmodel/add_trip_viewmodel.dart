import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/states/add_trip_states.dart';

import '../../../../../app/sl.dart';
import '../../../../../domain/models/user_manager.dart';
import '../../../../../domain/usecase/add_trip_bus.dart';
import '../../../../base/base_cubit.dart';

class AddTripViewModel extends BaseCubit
    implements AddTripViewModelInput, AddTripViewModelOutput {
  static AddTripViewModel get(context) => BlocProvider.of(context);
  final AddBusTripUseCase _addBusTripUseCase;

  AddTripViewModel(this._addBusTripUseCase);
  final UserManager _userManager = sl<UserManager>();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _toSearchController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String _num = '1';
  DateTime? _selectedDate;

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

  DateTime get getDate => _selectedDate!;

  @override
  set setNum(String number) {
    _num = number;
    _numController.text = _num;
  }

  Future<void> addTrip() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));

    DateTime selectedDate = DateFormat('MMM d, yyyy').parse(_dateController.text);
    double? price = double.tryParse(_priceController.text);

    await _addBusTripUseCase(
      AddBusTripUseCaseInput(
        driverId:_userManager.getCurrentDriver!.uuid,
        numberOfBus: int.parse(_num),
        price: price ?? 0.0,
        pickupLocation: _toController.text.trim().toLowerCase(),
        destinationLocation: _fromController.text.trim().toLowerCase(),
        calendar: selectedDate,
      ),
    ).then(
          (value) {
        value.fold(
              (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
              (r) {
            emit(SuccessState(' Trip added Successfully'));
          },
        );
      },
    );


  }
  Future<void> clear() async {
    _numController.clear();
    _priceController.clear();
    _fromController.clear();
    _toController.clear();
    _toSearchController.clear();
    _dateController.clear();
    _num = '1';
    _selectedDate = null;
  }

  @override
  set setDate(DateTime date) {
    // DateFormat formatter = DateFormat('MMM d, yyyy');
    // _selectedDate = formatter.format(date);

    _dateController.text = DateFormat('EEE, MMM d yyyy hh:mm a').format(date);
  }
}


abstract class AddTripViewModelInput {
  set setNum(String number);

  set setDate(DateTime date);
}

abstract class AddTripViewModelOutput {
  TextEditingController get getNumController;

  TextEditingController get getPriceController;

  TextEditingController get getFromController;

  TextEditingController get getToController;

  TextEditingController get getToSearchController;

  TextEditingController get getDateController;
}
