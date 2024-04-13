import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';
import 'package:speedy_go/presentation/trip_screen/view/pages/map_pages/viewmodel/trip_map_viewmodel.dart';

class TripMapBody extends StatelessWidget {
  const TripMapBody({
    super.key,
    required this.viewModel,
  });

  final TripMapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 14.4746,
          ),
          // style: viewModel.mapStyle,
          onMapCreated: (mapController) async {
            viewModel.getMapStyle();
            viewModel.setMapController = mapController;
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p50,
              vertical: AppPadding.p20,
            ),
            child: ElevatedButton(
              onPressed: () {},
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
