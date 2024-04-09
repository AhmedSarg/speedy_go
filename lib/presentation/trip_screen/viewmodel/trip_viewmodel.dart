import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/trip_screen/view/states/trip_states.dart';

import '../../base/base_cubit.dart';

class TripViewModel extends BaseCubit
    implements TripViewModelInput, TripViewModelOutput {
  TripViewModel();
  int indexPage = 0;
  bool selectCar = false;
  bool selectTuktuk = false;
  Color colorItemCar = ColorManager.transparent;
  Color colorItemTuktuk = ColorManager.transparent;
  Color colorCard = ColorManager.transparent;
  Color textColorCard = ColorManager.black;
  int selectedCard = 0;
  late TripType selectedName = TripType.tuktuk;
  late String selectedAsset = SVGAssets.tuktuk;
  late int price = 50;
  TextEditingController newPrice = TextEditingController();

  static TripViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}

  pageChange(int index) {
    indexPage = index;
    emit(ChangePageState());
  }

  selectionCard(int index) {
    if (selectedCard == index) {
      selectedCard = -1;
    } else {
      selectedCard = index;
    }
    emit(SelectDriverState());
  }

  colorCardChange(int index) {
    if (index == selectedCard) {
      return ColorManager.darkBlack;
    } else {
      return ColorManager.transparent;
    }
    emit(ChangeColorCardState());
  }

  textColorCardChange(int index) {
    if (index == selectedCard) {
      return ColorManager.white;
    } else {
      return ColorManager.black;
    }
    emit(ChangeTextColorCardState());
  }

  selectionItem(bool i) {
    if (i) {
      selectCar = !selectCar;
      selectTuktuk = false;
    } else {
      selectTuktuk = !selectTuktuk;
      selectCar = false;
    }
    // print("$selectCar c");
    // print("$selectTuktuk t");
    emit(SelectTripState());
    setColor();
  }

  setColor() {
    if (selectCar) {
      selectedName = TripType.car;
      selectedAsset = SVGAssets.car;
      colorItemCar = ColorManager.darkBlack;
      colorItemTuktuk = ColorManager.transparent;
      emit(TripCarState());
    } else if (selectTuktuk) {
      selectedName = TripType.tuktuk;
      selectedAsset = SVGAssets.tuktuk;
      colorItemCar = ColorManager.transparent;
      colorItemTuktuk = ColorManager.darkBlack;
      emit(TripTukTukState());
    } else {
      colorItemCar = ColorManager.transparent;
      colorItemTuktuk = ColorManager.transparent;
    }
    // print(colorTuktuk);
    // print(colorCar);
  }
}

abstract class TripViewModelInput {
  // set setTripType(Selection TripType);
}

abstract class TripViewModelOutput {
  // Selection get getTripType;
}
