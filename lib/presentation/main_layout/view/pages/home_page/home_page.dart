import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../viewmodel/main_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static late MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = MainViewModel.get(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GoogleMap(
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          style: viewModel.getMapStyle,
          onMapCreated: (controller) {
            viewModel.setMapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: viewModel.getUserLocation,
            zoom: AppSize.s18,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p50,
              vertical: AppPadding.p20,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.passengerMapRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.black,
                elevation: AppSize.s10,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(SVGAssets.locationOutlined),
                  const SizedBox(width: AppSize.s10),
                  Text(
                    'Where to go?',
                    style: getRegularStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.f12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TripAppBar extends StatelessWidget {
  const TripAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50,
      decoration: BoxDecoration(
        color: ColorManager.transparent,
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: const SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: Row(
          children: [
            Expanded(
              child: Icon(
                CupertinoIcons.home,
                color: ColorManager.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: AppSize.s100),
                child: Icon(
                  CupertinoIcons.bus,
                  color: ColorManager.white,
                ),
              ),
            ),
            Expanded(
              child: Icon(
                CupertinoIcons.person,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
