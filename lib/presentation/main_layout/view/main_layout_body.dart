import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/view/widgets/profile_items.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../common/widget/main_drawer.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/main_viewmodel.dart';
import 'pages/bus_page/pages/book_trip_page/view/book_trip_view.dart';
import 'pages/home_page/home_page.dart';

class MainLayoutBody extends StatefulWidget {
  const MainLayoutBody({
    super.key,
    required this.viewModel,
  });

  final MainViewModel viewModel;

  @override
  State<MainLayoutBody> createState() => _MainLayoutBodyState();
}

class _MainLayoutBodyState extends State<MainLayoutBody> {
  int selectedTabIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      const HomePage(),
      const BookTripScreen(),
      MainDrawer(
          drawerItems: [
            DrawerItem(
              text: 'My Trips',
              image: SVGAssets.myTrips,
              onTap: () {
                Navigator.pushNamed(context, Routes.myTripsRoute);
              },
            ),
            DrawerItem(
              text: 'Request History',
              image: SVGAssets.history,
              onTap: () {
                Navigator.pushNamed(context, Routes.requestHistoryRoute);
              },
            ),
          ],
          name: widget.viewModel.getName,
          start: () {
            widget.viewModel.start();
          },
          logOut: () {
            widget.viewModel.logout();
          },
          imagePath: widget.viewModel.getImagePath),
    ];

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
          backgroundColor: ColorManager.bgColor,
          extendBody: selectedTabIndex != 1,

          bottomNavigationBar: (tabs.length <= maxCount)

              ? AnimatedNotchBottomBar(
                  elevation: AppSize.s10,
                  notchBottomBarController: _controller,
                   color: ColorManager.primary,
                  showLabel: false,
                  notchColor: ColorManager.primary,
                  removeMargins: false,
                  showTopRadius: true,
              bottomBarWidth: context.width()*.99,
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
                        SVGAssets.busTrip,
                        colorFilter: const ColorFilter.mode(
                          ColorManager.offwhite,
                          BlendMode.srcIn,
                        ),
                      ),
                      activeItem: SvgPicture.asset(
                        SVGAssets.busTrip,
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
