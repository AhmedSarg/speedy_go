import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/common/widget/navigation_bar_widget.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/HomePage.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/book_trip_search.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          PageView(
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
          Positioned(
              left: AppSize.s0,
              right: AppSize.s0,
              bottom: AppSize.s10,
              child: NavigationBottomBar(viewModel: viewModel)),
        ],
      ),
    );
  }
}





