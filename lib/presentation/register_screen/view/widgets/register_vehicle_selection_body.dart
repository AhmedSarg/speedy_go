import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/register_viewmodel.dart';

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
                onPressed: viewModel.selectionCanceled,
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
              AppStrings.registerScreenSelectionTitle.tr(),
              style:
                  AppTextStyles.registerScreenSelectionTitleTextStyle(context),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: (viewModel.getSelectionIndex != 0)
                  ? () => viewModel.indexHandle(0)
                  : null,
              color: ColorManager.white,
              padding: const EdgeInsets.only(left: AppPadding.p8),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            const SizedBox(width: AppSize.s5),
            SelectVehicle(viewModel: viewModel),
            const SizedBox(width: AppSize.s5),
            IconButton(
              onPressed: (viewModel.getSelectionIndex !=
                      viewModel.getSelectionVehicles.length - 1)
                  ? () => viewModel.indexHandle(1)
                  : null,
              hoverColor: Colors.transparent,
              color: ColorManager.white,
              icon: (viewModel.getSelectionIndex !=
                      viewModel.getSelectionVehicles.length)
                  ? const Icon(Icons.arrow_forward_ios)
                  : const Icon(null),
            ),
          ],
        ),
        Text(
          viewModel.getSelectionVehicles[viewModel.getSelectionIndex].name.tr(),
          style: AppTextStyles.registerScreenSelectionTextStyle(context),
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
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (viewModel.getSelectionIndex == 0) {
            viewModel.setRegisterBoxType = RegisterType.car;
          } else if (viewModel.getSelectionIndex == 1) {
            viewModel.setRegisterBoxType = RegisterType.tuktuk;
          } else {
            viewModel.setRegisterBoxType = RegisterType.bus;
          }
        },
        child: Container(
          height: AppSize.s200,
          padding: const EdgeInsets.all(AppPadding.p20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            color: ColorManager.blueWithOpacity0_5,
          ),
          child: SvgPicture.asset(
            viewModel.getSelectionVehicles[viewModel.getSelectionIndex].icon,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
