import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:speedy_go/app/extensions.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/main_viewmodel.dart';
import 'pages/bus_page/pages/book_trip_page/view/book_trip_view.dart';
import 'pages/google_map.dart';
import 'pages/home_page/home_page.dart';
import 'pages/profile_page/view/profile_page.dart';

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
          body: Stack(
            children: [
              GoogleMapScreenProfile(viewModel: widget.viewModel),
              PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  tabs.length,
                  (index) => tabs[index],
                ),
              ),
            ],
          ),
          backgroundColor: ColorManager.bgColor,
          extendBody: selectedTabIndex != 1,
          bottomNavigationBar: (tabs.length <= maxCount)
              ? AnimatedNotchBottomBar(
                  notchBottomBarController: _controller,
                  color: ColorManager.bgColor,
                  showLabel: false,
                  notchColor: ColorManager.bgColor,
                  removeMargins: false,
                  showTopRadius: true,
                  bottomBarWidth: context.width() * 0.8,
                  durationInMilliSeconds: 3,
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

  List<Widget> tabs = [
    const HomePage(),
    const BookTripScreen(),
    const ProfilePage(),
  ];
}
