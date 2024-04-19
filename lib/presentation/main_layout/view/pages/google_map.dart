import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:speedy_go/presentation/main_layout/viewmodel/main_viewmodel.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class GoogleMapScreenProfile extends StatelessWidget {
  const GoogleMapScreenProfile({
    super.key,
    required this.viewModel,
  });

  final MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      compassEnabled: false,
      buildingsEnabled: false,
      scrollGesturesEnabled: false,
      myLocationEnabled: false,
      zoomControlsEnabled: false,

      mapType: MapType.normal,
      style: viewModel.getMapStyle,
      onMapCreated: (controller) {
        viewModel.setMapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: viewModel.getUserLocation,
        zoom: AppSize.s14,
      ),
    );
  }
}
