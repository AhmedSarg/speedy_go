import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class TripBody extends StatelessWidget {
  const TripBody({
    super.key,
    required this.viewModel,
  });

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        viewModel.prevPage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Back(onTap: viewModel.prevPage),
            ),
          ),
          Container(
            width: AppSize.infinity,
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: const BoxDecoration(
              color: ColorManager.lightBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s20),
                topRight: Radius.circular(AppSize.s20),
              ),
            ),
            child: viewModel.getPage,
          ),
        ],
      ),
    );
  }
}

class Back extends StatelessWidget {
  const Back({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s18,
      backgroundColor: ColorManager.grey,
      child: IconButton(
        onPressed: onTap,
        padding: const EdgeInsets.only(left: AppPadding.p4),
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        color: ColorManager.white,
        iconSize: AppSize.s12,
      ),
    );
  }
}
