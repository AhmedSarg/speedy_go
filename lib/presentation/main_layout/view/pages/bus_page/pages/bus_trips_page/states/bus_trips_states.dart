import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

class TripTappedState extends BaseStates {
  final TripBusModel trip;
  final bool priceChange;

  TripTappedState(this.trip, this.priceChange);
}
