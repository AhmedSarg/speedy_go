import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/common/widget/bottom_curved_nav_bar.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/HomePage.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/book_trip_search.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/profile_page.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/widgets/google_map.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../viewmodel/main_viewmodel.dart';

class MainLayoutBody extends StatefulWidget {
  MainLayoutBody({
    super.key,
    required this.viewModel,
  });

  final MainViewModel viewModel;

  @override
  State<MainLayoutBody> createState() => _MainLayoutBodyState();
}

class _MainLayoutBodyState extends State<MainLayoutBody> {
  int selectedTabIndex = 0;

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
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: ColorManager.lightGrey,
            items: <Widget>[
              SvgPicture.asset(SVGAssets.home),
              SvgPicture.asset(SVGAssets.busTrip),
              SvgPicture.asset(SVGAssets.profile),

            ],
            onTap: (index) {
              //Handle button tap
            },
          ),
          key: _key,
          resizeToAvoidBottomInset:
              false, // Ensure bottom navigation is not cut off

          body: Stack(
            children: [
              const GoogleMapScreenProfile(),
              // tabs[selectedTabIndex],

            ],
          ),
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










// Positioned(
//   left: 20,
//   right: 20,
//   bottom: 40,
//   child: Container(
//     height: 60,
//     child: ClipRRect(
//
//       borderRadius: BorderRadius.circular(AppSize.s28),
//       child: Column(
//         children: [
//           Container(
//             child:BottomNavigationBar(
//                              backgroundColor: ColorManager.CharredGrey,
//                              showUnselectedLabels: false,
//                              enableFeedback: false,
//                              onTap: (index) {
//                                setState(() {
//                                  selectedTabIndex = index;
//                                });
//                              },
//                              currentIndex: selectedTabIndex,
//                              items: [
//                                BottomNavigationBarItem(
//                                  backgroundColor: ColorManager.lightGrey,
//                                  icon: SvgPicture.asset(
//                                    SVGAssets.home,
//                                    colorFilter: const ColorFilter.mode(
//                                      ColorManager.offwhite,
//                                      BlendMode.srcIn,
//                                    ),
//                                  ),
//                                  activeIcon: SvgPicture.asset(
//                                    SVGAssets.home,
//                                    colorFilter: const ColorFilter.mode(
//                                      ColorManager.offwhite,
//                                      BlendMode.srcIn,
//                                    ),
//                                  ),
//                                  label: '',
//                                ),
//
//                                BottomNavigationBarItem(
//                                  backgroundColor: ColorManager.lightGrey,
//                                  icon: SvgPicture.asset(
//                                    SVGAssets.busTrip,
//                                    colorFilter: const ColorFilter.mode(
//                                      ColorManager.offwhite,
//                                      BlendMode.srcIn,
//                                    ),
//                                  ),
//                                  activeIcon: SvgPicture.asset(
//                                    SVGAssets.busTrip,
//                                    colorFilter: const ColorFilter.mode(
//                                      ColorManager.offwhite,
//                                      BlendMode.srcIn,
//                                    ),
//                                  ),
//                                  label: '',
//                                ),
//                                BottomNavigationBarItem(
//                                  backgroundColor: ColorManager.lightGrey,
//                                  icon: SvgPicture.asset(
//                                    SVGAssets.profile,
//                                    colorFilter: const ColorFilter.mode(
//                                      ColorManager.offwhite,
//                                      BlendMode.srcIn,
//                                    ),
//                                  ),
//                                  activeIcon: SvgPicture.asset(
//                                    SVGAssets.profile,
//                                    colorFilter: const ColorFilter.mode(
//                                      ColorManager.offwhite,
//                                      BlendMode.srcIn,
//                                    ),
//                                  ),
//                                  label: '',
//                                ),
//
//                              ],
//                            )
//           ),
//         ],
//       ),
//     ),
//   ),
// ),