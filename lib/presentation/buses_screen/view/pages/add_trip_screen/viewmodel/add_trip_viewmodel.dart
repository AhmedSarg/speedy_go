import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/sl.dart';
import '../../../../../../domain/models/user_manager.dart';
import '../../../../../../domain/usecase/add_bus_trip_usecase.dart';
import '../../../../../base/base_cubit.dart';
import '../../../../../base/base_states.dart';

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

  int? _busNumber;
  late int _numberOfBuses;
  DateTime? _selectedDate;

  Future<void> addTrip() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));

    DateTime selectedDate =
        DateFormat('EEE, MMM d yyyy hh:mm a').parse(_dateController.text);
    double? price = double.tryParse(_priceController.text);

    await _addBusTripUseCase(
      AddBusTripUseCaseInput(
        driverId: _userManager.getCurrentDriver!.uuid,
        busId: _userManager.getCurrentDriver!.buses![_busNumber! - 1],
        price: price ?? 0.0,
        pickupLocation: _fromController.text.trim().toLowerCase(),
        destinationLocation: _toController.text.trim().toLowerCase(),
        calendar: selectedDate,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            emit(SuccessState(message: 'Trip Added Successfully'));
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
    _busNumber = null;
    _selectedDate = null;
  }

  @override
  void start() {
    emit(LoadingState());
    _numberOfBuses = _userManager.getCurrentDriver!.buses!.length;
    emit(ContentState());
  }

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
  int? get getBusNumber => _busNumber;

  @override
  int get getNumberOfBuses => _numberOfBuses;

  @override
  DateTime get getDate => _selectedDate!;

  @override
  set setBusNumber(int number) {
    _busNumber = number;
    _numController.text = _busNumber.toString();
  }

  @override
  set setDate(DateTime date) {
    _dateController.text = DateFormat('EEE, MMM d yyyy hh:mm a').format(date);
  }
}

abstract class AddTripViewModelInput {
  set setBusNumber(int number);

  set setDate(DateTime date);
}

abstract class AddTripViewModelOutput {
  TextEditingController get getNumController;

  TextEditingController get getPriceController;

  TextEditingController get getFromController;

  TextEditingController get getToController;

  TextEditingController get getToSearchController;

  TextEditingController get getDateController;

  int? get getBusNumber;

  int get getNumberOfBuses;

  DateTime get getDate;
}
