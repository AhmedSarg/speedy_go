import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

class MainViewModel extends BaseCubit
    implements MainViewModelInput, MainViewModelOutput {
  static MainViewModel get(context) => BlocProvider.of(context);

  late GoogleMapController _mapController;

  String? mapStyle;

  @override
  set setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> getMapStyle() async {
    mapStyle = await rootBundle.loadString('assets/maps/dark_map.json');
    emit(ContentState());
  }

  @override
  void start() {}
}

abstract class MainViewModelInput {
  set setMapController(GoogleMapController mapController);
}

abstract class MainViewModelOutput {}
