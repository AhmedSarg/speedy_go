import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/base/cubit_builder.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/my_trips/view/pages/no_trips.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/my_trips/viewmodel/my_trips_viewmodel.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import 'pages/current_trip.dart';
import 'pages/past_trip.dart';

class MyTripsBody extends StatefulWidget {
  const MyTripsBody({super.key});

  @override
  State<MyTripsBody> createState() => _MyTripsBodyState();
}

class _MyTripsBodyState extends State<MyTripsBody>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      appBar: AppBar(
        title: Text(
          'My Trips',
          style:
              AppTextStyles.profileGeneralItemTextStyle(context, FontSize.f22),
        ),
        scrolledUnderElevation: AppSize.s0,
        bottom: TabBar(
          controller: _tabController,
          dividerColor: ColorManager.transparent,
          indicatorColor: ColorManager.blue,
          indicatorWeight: AppSize.s1,
          labelColor: ColorManager.blue,
          labelStyle: getSemiBoldStyle(
            color: ColorManager.blue,
            fontSize: FontSize.f16,
          ),
          unselectedLabelColor: ColorManager.white,
          tabs: const [
            SizedBox(
              height: AppSize.s50,
              child: Center(
                child: Text('Current'),
              ),
            ),
            SizedBox(
              height: AppSize.s50,
              child: Center(
                child: Text('Past'),
              ),
            ),
          ],
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
        toolbarHeight: AppSize.s80,
        backgroundColor: ColorManager.bgColor,
        elevation: AppSize.s0,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p12),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MyTripsViewModel, BaseStates>(
              listener: (context, state) {
                baseListener(context, state);
              },
              builder: (context, state) {
                return baseBuilder(context, state, buildContent(context));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    MyTripsViewModel viewModel = MyTripsViewModel.get(context);
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _tabController.index = index;
        });
      },
      children: [
        viewModel.getCurrentTrips.isNotEmpty
            ? const CurrentTrips()
            : const NoTrips(),
        viewModel.getPastTrips.isNotEmpty ? const PastTrips() : const NoTrips(),
      ],
    );
  }
}
