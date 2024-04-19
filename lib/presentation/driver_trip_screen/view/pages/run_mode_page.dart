import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/driver_trip_screen/viewmodel/driver_trip_viewmodel.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../resources/text_styles.dart';

class RunMode extends StatelessWidget {
  const RunMode({super.key, required this.viewModel});

  final DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: GestureDetector(
              onTap: (){
                viewModel.toggleShowContainer();
              },
              child: ShowMode(
                  mode: mode(viewModel.getMode),
                  color: colorMode(viewModel.getMode)),
            ),
          ),
        ),
        SizedBox(
          height: context.height() / 3.5,
        ),
        viewModel.getShowContainer ? TurnOn(viewModel: viewModel) : const SizedBox(),
      ],
    );
  }
}

class ShowMode extends StatelessWidget {
  const ShowMode({super.key, required this.mode, required this.color});

  final String mode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() / 5,
      height: AppSize.s30,
      decoration: BoxDecoration(
        color: color,
        border: const Border(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          mode,
          style: AppTextStyles.runModeScreenModeTextStyle(context),
        ),
      ),
    );
  }
}

class TurnOn extends StatelessWidget {
  const TurnOn({super.key, required this.viewModel});
  final DriverTripViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() / 1.7,
      height: context.height() / 5,
      decoration: const BoxDecoration(
        color: ColorManager.grey,
        border: Border(),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.runModeScreenTitleContainer.tr(),
            style: AppTextStyles.runModeScreenTitleContainerTextStyle(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.runModeScreenTurnInto.tr(),
                style: AppTextStyles.runModeScreenTurnIntoTextStyle(context),
              ),
              Container(
                width: context.width() / 4,
                height: AppSize.s25,
                decoration: BoxDecoration(
                  color: colorMode(viewModel.getMode),
                  border: const Border(),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: GestureDetector(
                      onTap: () {
                        viewModel.toggleMode();
                        if (viewModel.getMode) {
                          // Navigator.pushNamed(context, Routes.wait);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p5),
                        child: Text(
                          "${mode(viewModel.getMode)} mode",
                          style:
                              AppTextStyles.runModeScreenModeTextStyle(context),
                        ),
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            width: context.width() / 4.7,
            height: context.height() / 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.error,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(AppStrings.runModeScreenButtonClose.tr(),
                  style:
                      AppTextStyles.runModeScreenButtonCloseTextStyle(context)),
            ),
          ),
        ],
      ),
    );
  }
}

String mode(bool ok) {
  return ok
      ? AppStrings.runModeScreenOnlineMode.tr()
      : AppStrings.runModeScreenOfflineMode.tr();
}

Color colorMode(bool ok) {
  return ok ? ColorManager.lightGreen : ColorManager.error;
}
