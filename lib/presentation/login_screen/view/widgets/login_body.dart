import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/widget/main_button.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/login_viewmodel.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.viewModel,
  });

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.infinity,
      height: AppSize.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.loginBackgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p100),
                child: SvgPicture.asset(IconsAssets.logo),
              ),
            ),
            LoginBox(
              viewModel: viewModel,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBox extends StatelessWidget {
  const LoginBox({
    super.key,
    required this.viewModel,
  });

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.m20,
        vertical: AppMargin.m40,
      ),
      padding: const EdgeInsets.all(AppPadding.p20),
      width: AppSize.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              AppStrings.loginScreenTitle.tr(),
              style: AppTextStyles.loginScreenTitleTextStyle(context),
            ),
          ),
          const SizedBox(height: AppSize.s20),
          LoginTypeSelector(viewModel: viewModel),
          const SizedBox(height: AppSize.s20),
          if (viewModel.getLoginType == LoginType.phoneNumber)
            ...phoneNumberLoginWidgets()
          else
            ...emailPasswordLoginWidgets(),
          const SizedBox(height: AppSize.s20),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.loginScreenDontHaveAccount.tr(),
                  style: AppTextStyles.loginScreenDontHaveAccountTextStyle(
                      context),
                ),
                const SizedBox(width: AppSize.s5),
                SizedBox(
                  height: AppSize.s20,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                      splashFactory: InkRipple.splashFactory,
                      foregroundColor: ColorManager.white.withOpacity(.1),
                    ),
                    child: Text(
                      AppStrings.loginScreenCreateAccount.tr(),
                      style: AppTextStyles.loginScreenCreateAccountTextStyle(
                          context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> phoneNumberLoginWidgets() {
    return [
      const SizedBox(
        height: AppSize.s40,
        child: Row(
          children: [
            CountryCodeInput(),
            SizedBox(width: AppSize.s10),
            PhoneNumberInput(),
          ],
        ),
      ),
      const SizedBox(height: AppSize.s20),
      AppButton(
        text: AppStrings.loginScreenSendCode.tr(),
        onPressed: () {},
      ),
    ];
  }

  List<Widget> emailPasswordLoginWidgets() {
    return [
      const Placeholder(
        fallbackHeight: AppSize.s40,
        color: ColorManager.white,
      ),
      const SizedBox(height: AppSize.s20),
      AppButton(
        text: AppStrings.loginScreenSendCode.tr(),
        onPressed: () {},
      ),
    ];
  }
}

class LoginTypeSelector extends StatelessWidget {
  const LoginTypeSelector({
    super.key,
    required this.viewModel,
  });

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s40,
      decoration: BoxDecoration(
        color: ColorManager.lightGrey,
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Row(
            children: [
              LoginTypeItem(
                type: LoginType.emailPassword,
                text: AppStrings.loginScreenSelectorEmail.tr(),
                viewModel: viewModel,
              ),
              LoginTypeItem(
                type: LoginType.phoneNumber,
                text: AppStrings.loginScreenSelectorPhoneNumber.tr(),
                viewModel: viewModel,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LoginTypeItem extends StatelessWidget {
  const LoginTypeItem({
    super.key,
    required this.type,
    required this.text,
    required this.viewModel,
  });

  final LoginType type;
  final String text;
  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    double itemWidth = (context.width() - AppSize.s80) / 2;
    return GestureDetector(
      onTap: () {
        viewModel.setLoginType(type);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: type == viewModel.getLoginType
              ? ColorManager.white
              : ColorManager.transparent,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.loginScreenSelectorTextStyle(
              context,
                type == viewModel.getLoginType
                    ? ColorManager.lightGrey
                    : ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CountryCodeInput extends StatefulWidget {
  const CountryCodeInput({super.key});

  @override
  State<CountryCodeInput> createState() => _CountryCodeInputState();
}

class _CountryCodeInputState extends State<CountryCodeInput> {
  final List<String> countryCodes = [
    '+20',
    '+966',
  ];

  late String selectedValue = countryCodes[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: ColorManager.white, width: AppSize.s0_5),
      ),
      child: Center(
        child: DropdownButton(
          value: selectedValue,
          items: countryCodes
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
          padding: const EdgeInsets.all(AppPadding.p4),
          dropdownColor: ColorManager.primary,
          iconEnabledColor: ColorManager.white,
          isExpanded: false,
          style: AppTextStyles.loginScreenCountryCodeValueTextStyle(context),
          underline: const SizedBox(height: AppSize.s0),
        ),
      ),
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        cursorColor: ColorManager.secondary,
        cursorRadius: const Radius.circular(AppSize.s1),
        style: AppTextStyles.loginScreenPhoneNumberValueTextStyle(context),
        cursorWidth: AppSize.s1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintStyle: AppTextStyles.loginScreenPhoneNumberHintTextStyle(context),
          hintText: AppStrings.loginScreenPhoneNumberHint.tr(),
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
              color: ColorManager.white,
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
        ),
      ),
    );
  }
}
