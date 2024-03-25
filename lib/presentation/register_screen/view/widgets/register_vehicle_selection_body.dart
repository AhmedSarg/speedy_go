import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/register_screen/viewmodel/register_viewmodel.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../resources/font_manager.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset('assets/svg/logo.svg'),
        Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p10, right: AppPadding.p80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: AppSize.s18,
                backgroundColor: ColorManager.grey,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  color: ColorManager.white,
                  iconSize: 12,
                ),
              ),
              Text(
                "Choose your vehicle",
                style: AppTextStyles.registerVehicleSelectionBodyTextStyle(
                    context, ColorManager.white, FontSize.f22),
              ),
            ],
          ),
        ),
        Row(
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
            GestureDetector(
              onTap: () {
                if (index == 0) {
                  widget.viewModel.setRegisterBoxType = RegisterType.car;
                } else if (index == 1) {
                  widget.viewModel.setRegisterBoxType = RegisterType.tuktuk;
                } else {
                  widget.viewModel.setRegisterBoxType = RegisterType.bus;
                }
              },
              child: Container(
                height: 200,
                width: 300,
                padding: const EdgeInsets.all(AppPadding.p20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    color: ColorManager.blueWithOpacity0_5),
                child: selectIcon(index),
              ),
            ),
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
        Text(
          selectName(index),
          style: AppTextStyles.registerVehicleSelectionBodyTextStyle(
              context, ColorManager.white, FontSize.f32),
        )
      ],
    );
  }
}

selectIcon(int index) {
  List<SvgPicture> img = [
    SvgPicture.asset('assets/svg/car.svg'),
    SvgPicture.asset('assets/svg/tuktuk.svg'),
    SvgPicture.asset('assets/svg/bus.svg')
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
