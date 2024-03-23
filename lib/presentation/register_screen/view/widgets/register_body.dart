import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/widget/main_button.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/register_viewmodel.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: RegisterBox(
          viewModel: viewModel,
        ),
      ),
    );
  }
}

class RegisterBox extends StatelessWidget {
  const RegisterBox({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    double boxHeight = viewModel.getRegisterType == RegisterType.passenger ? AppSize.s600 : AppSize.s360;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(
        right: AppMargin.m20,
        left: AppMargin.m20,
        top: context.height() - boxHeight - AppMargin.m40,
        bottom: AppMargin.m40
      ),
      padding: const EdgeInsets.all(AppPadding.p20),
      width: AppSize.infinity,
      height: boxHeight,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppSize.s40,
            child: Center(
              child: Text(
                AppStrings.registerScreenTitle.tr(),
                style: AppTextStyles.registerScreenTitleTextStyle(context),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s20),
          RegisterTypeSelector(viewModel: viewModel),
          const SizedBox(height: AppSize.s20),
          if (viewModel.getRegisterType == RegisterType.passenger)
            ...passengerRegisterWidgets()
          else
            ...driverRegisterWidgets(),
          const SizedBox(height: AppSize.s20),
          SizedBox(
            height: AppSize.s20,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.registerScreenAlreadyHaveAccount.tr(),
                    style:
                        AppTextStyles.registerScreenAlreadyHaveAccountTextStyle(
                            context),
                  ),
                  const SizedBox(width: AppSize.s5),
                  SizedBox(
                    height: AppSize.s20,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p4),
                        splashFactory: InkRipple.splashFactory,
                        foregroundColor: ColorManager.white.withOpacity(.1),
                      ),
                      child: Text(
                        AppStrings.registerScreenLogin.tr(),
                        style:
                            AppTextStyles.registerScreenLoginTextStyle(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> passengerRegisterWidgets() {
    return [
      Expanded(
        child: Row(
          children: [
            RegisterTextField(
              keyboard: TextInputType.text,
              hintText: AppStrings.registerScreenFirstNameHint.tr(),
              icon: CupertinoIcons.person,
            ),
            const SizedBox(width: AppSize.s20),
            RegisterTextField(
              keyboard: TextInputType.text,
              hintText: AppStrings.registerScreenLastNameHint.tr(),
              icon: CupertinoIcons.person,
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSize.s20),
      RegisterTextField(
        keyboard: TextInputType.number,
        hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
        icon: CupertinoIcons.phone,
      ),
      const SizedBox(height: AppSize.s20),
      const GenderInput(),
      const SizedBox(height: AppSize.s20),
      RegisterTextField(
        keyboard: TextInputType.emailAddress,
        hintText: AppStrings.registerScreenEmailHint.tr(),
        icon: CupertinoIcons.envelope,
      ),
      const SizedBox(height: AppSize.s20),
      RegisterTextField(
        keyboard: TextInputType.text,
        hintText: AppStrings.registerScreenPasswordHint.tr(),
        icon: CupertinoIcons.lock_fill,
        canObscure: true,
      ),
      const SizedBox(height: AppSize.s20),
      RegisterTextField(
        keyboard: TextInputType.text,
        hintText: AppStrings.registerScreenPasswordHint.tr(),
        icon: CupertinoIcons.lock_fill,
        canObscure: true,
      ),
      const SizedBox(height: AppSize.s20),
      SizedBox(
        height: AppSize.s40,
        child: AppButton(
          text: AppStrings.registerScreenSignUp.tr(),
          onPressed: () {},
        ),
      ),
    ];
  }

  List<Widget> driverRegisterWidgets() {
    return [
      // RegisterTextField(
      //   keyboard: TextInputType.emailAddress,
      //   hintText: AppStrings.registerScreenEmailHint.tr(),
      // ),
      // const SizedBox(height: AppSize.s20),
      // RegisterTextField(
      //   keyboard: TextInputType.text,
      //   hintText: AppStrings.registerScreenPasswordHint.tr(),
      //   canObscure: true,
      // ),
      // const SizedBox(height: AppSize.s20),
      // SizedBox(
      //   height: AppSize.s40,
      //   child: AppButton(
      //     text: AppStrings.registerScreenSignUp.tr(),
      //     onPressed: () {},
      //   ),
      // ),
    ];
  }
}

class RegisterTypeSelector extends StatelessWidget {
  const RegisterTypeSelector({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    double itemWidth = (context.width() - AppSize.s80) / 2;
    return Container(
      height: AppSize.s40,
      width: itemWidth * 2,
      decoration: BoxDecoration(
        color: ColorManager.lightGrey,
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            left: viewModel.getRegisterType == RegisterType.passenger
                ? 0
                : itemWidth,
            child: Container(
              width: itemWidth,
              height: AppSize.s40,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
            ),
          ),
          Row(
            children: [
              RegisterTypeItem(
                type: RegisterType.passenger,
                text: AppStrings.registerScreenSelectorPassenger.tr(),
                viewModel: viewModel,
              ),
              RegisterTypeItem(
                type: RegisterType.driver,
                text: AppStrings.registerScreenSelectorDriver.tr(),
                viewModel: viewModel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterTypeItem extends StatelessWidget {
  const RegisterTypeItem({
    super.key,
    required this.type,
    required this.text,
    required this.viewModel,
  });

  final RegisterType type;
  final String text;
  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    double itemWidth = (context.width() - AppSize.s80) / 2;
    return GestureDetector(
      onTap: () {
        viewModel.setRegisterType(type);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.registerScreenSelectorTextStyle(
              context,
              type == viewModel.getRegisterType
                  ? ColorManager.lightGrey
                  : ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterTextField extends StatefulWidget {
  const RegisterTextField({
    super.key,
    required this.keyboard,
    required this.hintText,
    required this.icon,
    this.canObscure = false,
  });

  final TextInputType keyboard;
  final String hintText;
  final bool canObscure;
  final IconData icon;

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  late bool hidden = widget.canObscure;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        cursorColor: ColorManager.secondary,
        cursorRadius: const Radius.circular(AppSize.s1),
        style: AppTextStyles.registerScreenTextFieldValueTextStyle(context),
        cursorWidth: AppSize.s1,
        obscureText: hidden,
        keyboardType: widget.keyboard,
        decoration: InputDecoration(
          hintStyle:
              AppTextStyles.registerScreenTextFieldHintTextStyle(context),
          hintText: widget.hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(AppPadding.p5),
            child: Icon(widget.icon, size: AppSize.s20),
          ),
          prefixIconColor: ColorManager.secondary,
          prefixIconConstraints: const BoxConstraints(
            maxWidth: AppSize.s30,
            minWidth: AppSize.s0,
            maxHeight: AppSize.s30,
            minHeight: AppSize.s0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: const BorderSide(
              color: ColorManager.white,
              width: AppSize.s0_5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: const BorderSide(
              color: ColorManager.secondary,
              width: AppSize.s0_5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: const BorderSide(
              color: ColorManager.error,
              width: AppSize.s0_5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: const BorderSide(
              color: ColorManager.error,
              width: AppSize.s0_5,
            ),
          ),
          suffixIcon: widget.canObscure
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  iconSize: AppSize.s20,
                  splashRadius: AppSize.s1,
                  isSelected: !hidden,
                  color: ColorManager.white,
                  selectedIcon: const Icon(CupertinoIcons.eye),
                  icon: const Icon(CupertinoIcons.eye_slash),
                )
              : null,
        ),
      ),
    );
  }
}

class GenderInput extends StatefulWidget {
  const GenderInput({super.key});

  @override
  State<GenderInput> createState() => _GenderInputState();
}

class _GenderInputState extends State<GenderInput> {
  final List<String> genders = [
    AppStrings.registerScreenGenderHint.tr(),
    AppStrings.registerScreenGenderMale.tr(),
    AppStrings.registerScreenGenderFemale.tr(),
  ];

  late String selectedValue = genders[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: ColorManager.white, width: AppSize.s0_5),
      ),
      child: Center(
        child: DropdownButton(
          value: selectedValue,
          items: genders
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          dropdownColor: ColorManager.primary,
          iconEnabledColor: ColorManager.white,
          isExpanded: true,
          isDense: true,
          style: AppTextStyles.registerScreenTextFieldHintTextStyle(context),
          underline: const SizedBox(height: AppSize.s0),
        ),
      ),
    );
  }
}
