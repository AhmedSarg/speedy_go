import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../main_layout/view/pages/profile_page/view/widgets/profile_items.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import '../viewmodel/drawer_viewmodel.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key, required this.viewModel});

  final DrawerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
      height: MediaQuery.of(context).size.height * .70,
      width: MediaQuery.of(context).size.width * .8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s18),
          bottomRight: Radius.circular(AppSize.s18),
        ),
        color: ColorManager.CharredGrey,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profileEditRoute);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      top: AppMargin.m12,
                      left: AppMargin.m20,
                      right: AppMargin.m20),
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
                                    padding: const EdgeInsets.all(AppPadding.p10),
                                    child: Lottie.asset(LottieAssets.loading)
                                  ),
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
              const SizedBox(
                height: AppSize.s18,
              ),
              ProfileItems(
                onTap: () {
                  Navigator.pushNamed(context, Routes.safetyRoute);
                },
                text: 'Safety',
                image: SVGAssets.safety,
              ),
              ProfileItems(
                onTap: () {
                  Navigator.pushNamed(context, Routes.supportRoute);
                },
                text: 'Support',
                image: SVGAssets.support,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .55,
                      height: AppSize.s50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorManager.lightBlue),
                        ),
                        onPressed: () {
                          viewModel.logout();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(SVGAssets.halfCircle),
                            Text(
                              'log out',
                              style:
                                  AppTextStyles.profileItemTextStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SVGAssets.faceBook),
                        const SizedBox(
                          width: AppSize.s32,
                        ),
                        SvgPicture.asset(SVGAssets.instagram),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
