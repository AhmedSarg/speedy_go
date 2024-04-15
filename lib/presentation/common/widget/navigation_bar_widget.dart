import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/main_layout/viewmodel/main_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key, required this.viewModel});

  final MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: ColorManager.transparent,
      buttonBackgroundColor: ColorManager.charcoalGrey,
      color: ColorManager.charcoalGrey,
      height: AppSize.s75,
      items: <Widget>[
        Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: SvgPicture.asset(
            SVGAssets.home,
            height: 30,
            width: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: SvgPicture.asset(
            SVGAssets.busTrip,
            height: 30,
            width: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: SvgPicture.asset(
            SVGAssets.profile,
            height: 30,
            width: 30,
          ),
        ),
      ],
      onTap: (index) {
        viewModel.getPageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      },
    );
  }
}

///pages
//         PageView(
//           controller: pageController,
//           children: const <Widget>[
//             HomePage(),
//             BookTripSearchPage(),
//             ProfilePage(),
//           ],
//         ),
