import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import 'widgets/my_current_trip.dart';
import 'widgets/my_past_trip.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

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
            style: AppTextStyles.profileGeneralItemTextStyle(
                context, FontSize.f22),
          ),
          scrolledUnderElevation: AppSize.s0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(AppSize.s1_2),
            child: Container(
              color: ColorManager.white,
              height: AppSize.s1_1,
            ),
          ),
          toolbarHeight: AppSize.s80,
          backgroundColor: ColorManager.bgColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
        ),
      body: Column(
        children: [
          const SizedBox(height: AppSize.s25,),
          SizedBox(
            width: double.infinity,
            height: AppSize.s62,
            child: Stack(
              children: [
                Positioned(
                  left:MediaQuery.of(context).size.width*.15,
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Center(
                      child: Text(
                        'Current',
                        style: AppTextStyles.profileTripsItemTextStyle(context,  _currentPageIndex == 0
                            ? ColorManager.blue
                            : ColorManager.white,),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width*.15,
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      'Past',
                      style: AppTextStyles.profileTripsItemTextStyle(context,  _currentPageIndex == 1
                          ? ColorManager.blue
                          : ColorManager.white,),
                    ),
                  ),
                ),
                Positioned(
                  left: _currentPageIndex == 0 ? 0 : null,
                  right: _currentPageIndex == 1 ? 0 : null,
                  bottom: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: AppSize.s2,
                    color: ColorManager.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: const [
                MyCurrentTrip(),
                MyPastTrip()
              ],
            ),
          ),
        ],
      ),
    );


  }
}
