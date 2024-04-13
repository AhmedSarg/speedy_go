import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/register_screen/viewmodel/register_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../resources/routes_manager.dart';

import '../../../resources/strings_manager.dart';

class RegisterVehicleSelectionBody extends StatelessWidget {
  const RegisterVehicleSelectionBody({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.registerRoute),
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
              style: AppTextStyles.chooseVehicleTextStyle(context),
            ),
          ],
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (viewModel.index != 0)
                    ? () => viewModel.indexHandel(0)
                    : null,
                color: ColorManager.white,
                icon: const Icon(Icons.arrow_back_ios),
              ),
              SelectVehicle(
                viewModel: viewModel,
              ),
              IconButton(
                onPressed: (viewModel.index != 2)
                    ? () => viewModel.indexHandel(1)
                    : null,
                hoverColor: Colors.transparent,
                color: ColorManager.white,
                icon: (viewModel.index != 2)
                    ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(null),
              ),
            ],
          ),
        ),
        Text(
          viewModel.nameVehicle,
          style: AppTextStyles.selectVehicleTextStyle(context),
        )
      ],
    );
  }
}

class SelectVehicle extends StatelessWidget {
  const SelectVehicle({super.key, required this.viewModel});

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (viewModel.index == 0) {
          viewModel.setRegisterBoxType = RegisterType.car;
        } else if (viewModel.index == 1) {
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
        child: viewModel.icon,
      ),
    );
  }
}
