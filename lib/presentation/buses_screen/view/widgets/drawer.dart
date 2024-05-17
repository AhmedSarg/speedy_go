import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/buses_screen/viewmodel/buses_viewmodel.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../../main_layout/view/pages/profile_page/view/widgets/profile_items.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class BusesScreenDrawer extends StatelessWidget {
  const BusesScreenDrawer({super.key});
  static late BusesViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = BusesViewModel.get(context);
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width * .8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s20),
          bottomRight: Radius.circular(AppSize.s20),
        ),
        color: ColorManager.CharredGrey,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Scaffold(
        backgroundColor: ColorManager.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s30),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.profileEditRoute)
                    .then((value) {
                  viewModel.start();
                  Scaffold.of(context).closeDrawer();
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                padding: const EdgeInsets.only(
                    right: AppPadding.p12,
                    top: AppPadding.p12,
                    bottom: AppPadding.p12),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s18),
                    ),
                    color: ColorManager.veryLightGrey),
                child: ListTile(
                  leading: Container(
                    width: AppSize.s60,
                    height: AppSize.s60,
                    decoration: const BoxDecoration(
                      color: ColorManager.black,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: !viewModel.getImagePath.contains('https')
                        ? Image.asset(
                            ImageAssets.unknownUserImage,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: viewModel.getImagePath,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return Center(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p10),
                                    child: Lottie.asset(LottieAssets.loading)),
                              );
                            },
                          ),
                  ),
                  title: Text(
                    viewModel.getName,
                    style: AppTextStyles.profileUserNameTextStyle(context),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Edit Profile',
                        style: AppTextStyles.profileSmallTextStyle(
                            context, ColorManager.grey),
                      ),
                      const SizedBox(
                        width: AppSize.s5,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: AppSize.s18,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s20),
            DrawerItem(
              onTap: () {
                Navigator.pushNamed(context, Routes.safetyRoute);
              },
              text: 'Safety',
              image: SVGAssets.safety,
            ),
            DrawerItem(
              onTap: () {
                Navigator.pushNamed(context, Routes.supportRoute);
              },
              text: 'Support',
              image: SVGAssets.support,
            ),
            const Spacer(),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .55,
                  height: AppSize.s50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorManager.white,
                      backgroundColor: ColorManager.lightBlue,
                    ),
                    onPressed: viewModel.logout,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(SVGAssets.halfCircle),
                        Text(
                          'Logout',
                          style: AppTextStyles.profileItemTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SVGAssets.faceBook),
                    const SizedBox(width: AppSize.s30),
                    SvgPicture.asset(SVGAssets.instagram),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSize.s30),
          ],
        ),
      ),
    );
  }
}
