import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/usecase/find_bus_trips_usecase.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';

import '../../../../../../../base/base_cubit.dart';
import '../states/book_trip_states.dart';

class BookTripViewModel extends BaseCubit
    implements BookTripViewModelInput, BookTripViewModelOutput {
  static BookTripViewModel get(context) => BlocProvider.of(context);

  final FindBusTripsUseCase _findBusTripsUseCase;

  BookTripViewModel(this._findBusTripsUseCase);

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedTo = '';
  String _selectedFrom = '';

  Future<void> findTrip() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _findBusTripsUseCase(
      FindBusTripsUseCaseInput(
        pickup: _fromController.text,
        destination: _toController.text,
        date: _selectedDate!,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            DataIntent.pushTripsStream(r);
            DataIntent.setBusPickup(_fromController.text);
            DataIntent.setBusDestination(_toController.text);
            DataIntent.setBusDepartureDate(_selectedDate!);
            emit(BusDataSuccessState());
          },
        );
      },
    );
  }

  @override
  void start() {}

  @override
  TextEditingController get getFromController => _fromController;

  @override
  TextEditingController get getToController => _toController;

  @override
  TextEditingController get getDateController => _dateController;

  DateTime? get getDate => _selectedDate;

  String get getTo => _selectedTo;

  String get getFrom => _selectedFrom;

  @override
  set setDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM d, yyyy');
    _selectedDate = date;
    _dateController.text = formatter.format(_selectedDate!);
  }

  set getTo(String toCity) {
    _selectedTo = toCity;
    _toController.text = _selectedTo;
  }

  set getFrom(String fromCity) {
    _selectedFrom = fromCity;
    _fromController.text = _selectedFrom;
  }

  @override
  set setFrom(String fromCity) {
    _selectedFrom = fromCity;
    _fromController.text = _selectedFrom;
  }

  @override
  set setTo(String toCity) {
    _selectedTo = toCity;
    _toController.text = _selectedTo;
  }
}

abstract class BookTripViewModelInput {
  set setDate(DateTime date);

  set setTo(String toCity);

  set setFrom(String fromCity);
}

abstract class BookTripViewModelOutput {
  TextEditingController get getFromController;

  TextEditingController get getToController;

  TextEditingController get getDateController;
}
