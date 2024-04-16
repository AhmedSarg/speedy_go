import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/HomePage.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/book_trip_search.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/profile_page.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/widgets/google_map.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';
import '../viewmodel/main_viewmodel.dart';

class MainLayoutBody extends StatefulWidget {
  MainLayoutBody({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

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
              const GoogleMapScreenProfile(),
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
          backgroundColor: ColorManager.lightGrey,
          extendBody: selectedTabIndex != 1, // Check if second tab is selected
          bottomNavigationBar: (tabs.length <= maxCount)
              ? AnimatedNotchBottomBar(
            notchBottomBarController: _controller,
            color: ColorManager.lightGrey,
            showLabel: false,
            notchColor: ColorManager.CharredGrey,
            removeMargins: false,
            showTopRadius: true,
            bottomBarWidth: MediaQuery.of(context).size.width * 0.8,
            durationInMilliSeconds: 1,
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
              _pageController.jumpToPage(index);
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
    const BookTripSearchPage(),
    const ProfilePage(),
  ];
}
