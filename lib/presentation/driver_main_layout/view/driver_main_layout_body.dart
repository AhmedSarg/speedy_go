import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/common/widget/main_drawer.dart';
import 'package:speedy_go/presentation/driver_main_layout/view/pages/driver_trip_page/view/driver_trip_page_view.dart';
import 'package:speedy_go/presentation/driver_main_layout/view/pages/driver_trip_page/viewmodel/driver_trip_page_viewmodel.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/driver_main_layout_viewmodel.dart';

class DriverMainScreenBody extends StatefulWidget {
  const DriverMainScreenBody({
    super.key,
    required this.viewModel,
  });

  final DriverMainViewModel viewModel;

  @override
  State<DriverMainScreenBody> createState() => _DriverMainScreenBodyState();
}

class _DriverMainScreenBodyState extends State<DriverMainScreenBody> {
  int selectedTabIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;
  late DriverTripViewModel bodyViewModel;

  List<Widget> get tabs => [
        DriverTripScreen(
          onChange: () {
            setState(() {});
          },
        ),
        MainDrawer(
            name: widget.viewModel.getName,
            start: () {
              widget.viewModel.start();
            },
            logOut: () {
              widget.viewModel.logout();
            },
            imagePath: widget.viewModel.getImagePath),
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    bodyViewModel = DriverTripViewModel.get(context);
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) {
          if (selectedTabIndex == 0) {
            if (!_key.currentState!.isDrawerOpen) {
              SystemNavigator.pop();
            }
          } else {
            setState(() {
              selectedTabIndex = 0;
            });
          }
        },
        child: Scaffold(
          key: _key,
          resizeToAvoidBottomInset: false,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              tabs.length,
              (index) => tabs[index],
            ),
          ),
          extendBody: true,
          bottomNavigationBar:
              (tabs.length <= maxCount) && !bodyViewModel.getDriverStatus
                  ? AnimatedNotchBottomBar(
                      elevation: AppSize.s10,
                      notchBottomBarController: _controller,
                      shadowElevation: AppSize.s10,
                      color: ColorManager.primary,
                      showLabel: false,
                bottomBarWidth: context.width()*.99,

                notchColor: ColorManager.primary,
                      removeMargins: false,
                      showTopRadius: true,
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
        ),
      ),
    );
  }
}
