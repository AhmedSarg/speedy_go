import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/common/widget/bottom_curved_nav_bar.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/HomePage.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/book_trip_search.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page.dart';

import '../viewmodel/main_viewmodel.dart';

class MainLayoutBody extends StatelessWidget {
  const MainLayoutBody({
    super.key,
    required this.viewModel,
  });

  final MainViewModel viewModel;

  final double horizontalPadding = 50;
  final double horizontalMargin = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 375),
              curve: Curves.easeOut,
              child: PageView(
                controller: viewModel.getPageController,
                children: <Widget>[
                  HomePage(
                    viewModel: viewModel,
                  ),
                  BookTripSearchPage(
                    viewModel: viewModel,
                  ),
                  ProfilePage(
                    viewModel: viewModel,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: horizontalMargin,
            left: horizontalMargin,
            child: CustomBottomBar(pageController: viewModel.getPageController,),
            // child: NavigationBottomBar(viewModel: viewModel)
          ),
        ],
      ),
    );
  }
}
