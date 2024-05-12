import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/buses_screen/pages/drawer/viewmodel/drawer_viewmodel.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../../app/sl.dart';
import '../../../../../../domain/models/user_manager.dart';
import '../../../../../login_screen/view/login_view.dart';
import '../../../../../main_layout/view/pages/profile_page/view/widgets/profile_items.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/text_styles.dart';


class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key, required this.viewModel});
  static UserManager _userManager = sl<UserManager>();
final DrawerViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .75,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppSize.s18),
                  bottomRight: Radius.circular(AppSize.s18)),
              color: ColorManager.CharredGrey),
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
                        leading: const CircleAvatar(
                          radius: AppSize.s30,
                          child: Center(child: Icon(Icons.person)),
                        ),
                        title: Text(
                          _userManager.getCurrentDriver!.firstName,
                          style: AppTextStyles.profileUserNameTextStyle(context),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Edit profie',
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
                                  ColorManager
                                      .lightBlue),
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
        ),
      ],
    );  }
}
