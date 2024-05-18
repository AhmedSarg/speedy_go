import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import 'widgets/current_trip.dart';
import 'widgets/past_trip.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
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
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _tabController.index = index;
                  _currentPageIndex = index;
                });
              },
              children: const [
                CurrentTrips(),
                PastTrips(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
