import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class GoogleMapScreenProfile extends StatefulWidget {
  const GoogleMapScreenProfile({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreenProfile> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreenProfile> {
  GoogleMapController? googleMapController;
  LatLng? initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    initMapStyle();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Denied'),
            content:
                Text('Please enable location services to use this feature.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (permission == LocationPermission.deniedForever) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Denied'),
            content: Text(
                'Location permission is permanently denied. Please go to app settings to enable it.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Geolocator.openAppSettings();
                },
                child: Text('App Settings'),
              ),
            ],
          ),
        );
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          initialCameraPosition = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {
      print('Error getting user location: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialCameraPosition != null
          ? GoogleMap(
        compassEnabled: false,
        // fortyFiveDegreeImageryEnabled: false,
        buildingsEnabled: false,
        scrollGesturesEnabled: false,
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          googleMapController = controller;
          initMapStyle();
        },
        initialCameraPosition: CameraPosition(
          target: initialCameraPosition!,
          zoom: 17.0,
        ),
      )
          : const Center(
        child: SizedBox(
            width: AppSize.s20,
            height: AppSize.s20,
            child: CircularProgressIndicator(color: ColorManager.offwhite,)),
      ),
    );
  }
  void initMapStyle() async {
    String mapNightStyle = await DefaultAssetBundle.of(context).loadString('assets/maps/dark_map.json');
    googleMapController?.setMapStyle(mapNightStyle);
  }


}
