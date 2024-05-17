import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import '../../main_layout/view/pages/bus_page/pages/book_trip_page/view/book_trip_view.dart';
import '../../main_layout/view/pages/home_page/home_page.dart';
import '../../main_layout/view/pages/profile_page/view/profile_page.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/driver_trip_viewmodel.dart';
import 'driver_trip_view.dart';
import 'widgets/status_button.dart';
import 'widgets/action_button.dart';

class DriverTripBody extends StatefulWidget {
  const DriverTripBody({
    super.key,
    required this.viewModel,
  });

  final DriverTripViewModel viewModel;

  @override
  State<DriverTripBody> createState() => _DriverTripBodyState();
}

class _DriverTripBodyState extends State<DriverTripBody> {
  int selectedTabIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        print(88);
      },
      child: Scaffold(
        bottomNavigationBar: (tabs.length <= maxCount)
            ? AnimatedNotchBottomBar(
          elevation: AppSize.s10,
          notchBottomBarController: _controller,
          shadowElevation: AppSize.s10,
          color: ColorManager.primary,
          showLabel: false,
          notchColor: ColorManager.primary,
          removeMargins: false,
          showTopRadius: true,
          durationInMilliSeconds: 2,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                SVGAssets.home,
                colorFilter: const ColorFilter.mode(
                  ColorManager.offwhite,
                  BlendMode.srcIn,
                ),
              ),
              activeItem: SvgPicture.asset(
                SVGAssets.home,
                colorFilter: const ColorFilter.mode(
                  ColorManager.offwhite,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                SVGAssets.profile,
                colorFilter: const ColorFilter.mode(
                  ColorManager.offwhite,
                  BlendMode.srcIn,
                ),
              ),
              activeItem: SvgPicture.asset(
                SVGAssets.profile,
                colorFilter: const ColorFilter.mode(
                  ColorManager.offwhite,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            setState(() {
              selectedTabIndex = index;
            });
          },
          kIconSize: AppSize.s26,
          kBottomRadius: AppSize.s35,
        )
            : null,
        body: SafeArea(
          child: SizedBox(
            height: AppSize.infinity,
            width: AppSize.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    children: tabs,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: widget.viewModel.getUserLocation,
                          zoom: AppSize.s18,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        polylines: widget.viewModel.getPolyline,
                        markers: widget.viewModel.getMarkers,
                        style: widget.viewModel.getMapStyle,
                        onMapCreated: (controller) {
                          widget.viewModel.setMapController = controller;
                        },
                      ),
                      widget.viewModel.getPageIndex <= 0
                          ? const StatusButton()
                          : const SizedBox(),
                    ],
                  ),
                ),
                widget.viewModel.getDriverStatus
                    ? Container(
                  width: AppSize.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p20,
                    horizontal: AppSize.s0,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorManager.lightBlack,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s20),
                      topRight: Radius.circular(AppSize.s20),
                    ),
                  ),
                  child: widget.viewModel.getPage,
                )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> tabs = [
    const DriverTripScreen(),
    const ProfilePage(),
  ];
}

