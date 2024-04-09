import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/register_screen/viewmodel/register_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../resources/font_manager.dart';
import '../../../resources/routes_manager.dart';
import 'package:animations/animations.dart';

import '../../../resources/strings_manager.dart';

class RegisterVehicleSelectionBody extends StatefulWidget {
  const RegisterVehicleSelectionBody({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  State<RegisterVehicleSelectionBody> createState() =>
      _RegisterVehicleSelectionBodyState();
}

class _RegisterVehicleSelectionBodyState
    extends State<RegisterVehicleSelectionBody> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // bool _onFirstPage = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(SVGAssets.logo),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSize.s18,
              backgroundColor: ColorManager.grey,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registerRoute);
                },
                padding: const EdgeInsets.only(left: AppPadding.p4),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                color: ColorManager.white,
                iconSize: AppSize.s12,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Text(
              AppStrings.chooseYourVehicle,
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.white, FontSize.f22),
            ),
          ],
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (index != 0)
                    ? () {
                        setState(() {
                          index = indexHandel(index, 0);
                        });
                      }
                    : null,
                color: ColorManager.white,
                icon: const Icon(Icons.arrow_back_ios),
              ),
              PageTransitionSwitcher(
                    duration: const Duration(seconds: 5),
                    // reverse: !_onFirstPage,
                    transitionBuilder: (Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset.zero,
                          end: const Offset(1.5, 0.0),
                        ).animate(secondaryAnimation),
                        child: FadeTransition(
                          opacity: Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child:  fun(index,widget.viewModel)
              ),
              // ),
              IconButton(
                onPressed: (index != 2)
                    ? () {
                        setState(() {
                          index = indexHandel(index, 1);
                        });
                      }
                    : null,
                hoverColor: Colors.transparent,
                color: ColorManager.white,
                icon: (index != 2)
                    ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(null),
              ),
            ],
          ),
        ),
        Text(
          selectName(index),
          style: AppTextStyles.SelectionTextStyle(
              context, ColorManager.white, FontSize.f32),
        )
      ],
    );
  }
}

selectIcon(int index) {
  List<SvgPicture> img = [
    SvgPicture.asset(SVGAssets.car),
    SvgPicture.asset(SVGAssets.tuktuk),
    SvgPicture.asset(SVGAssets.bus)
  ];
  return img[index];
}

selectName(int index) {
  List<String> name = ['car', 'tuk-tuk', 'bus'];
  return name[index];
}

indexHandel(int index, int select) {
  if (select == 0) {
    index--;
  } else {
    index++;
  }
  index = (index > 0) ? index % 3 : 0;
  return index;
}


Widget fun(int index,RegisterViewModel viewModel){
  return GestureDetector(
    onTap: () {
      if (index == 0) {
        viewModel.setRegisterBoxType = RegisterType.car;
      } else if (index == 1) {
        viewModel.setRegisterBoxType = RegisterType.tuktuk;
      } else {
        viewModel.setRegisterBoxType = RegisterType.bus;
      }
    },
    child: Container(
      height: 200,
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          color: ColorManager.blueWithOpacity0_5),
      child:selectIcon(index),
    ),
  );
}