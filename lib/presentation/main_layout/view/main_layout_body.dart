import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/presentation/passenger_trip_screen/view/passenger_trip_view.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/main_viewmodel.dart';

class MainLayoutBody extends StatelessWidget {
  const MainLayoutBody({
    super.key,
    required this.viewModel,
  });

  final MainViewModel viewModel;

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
              onPressed: () {
                Navigator.pushNamed(context, Routes.passengerTripRoute);
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
          borderRadius: BorderRadius.circular(AppSize.s10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: const CustomPaint(
        painter: MyCustomPainter(),
        child: SizedBox(
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
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  const MyCustomPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.primary
      ..style = PaintingStyle.fill;

    int index = 1;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 3 * index, 0)
      ..quadraticBezierTo(size.width * (index * 2 + 1) / 6, size.height,
          size.width * (index + 1) / 3, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
