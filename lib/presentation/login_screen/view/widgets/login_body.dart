import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/widget/main_button.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
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
                child: SvgPicture.asset(SVGAssets.logo),
              ),
            ),
            LoginBox(
              viewModel: viewModel,
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 200))
                .moveY(
                  begin: AppSize.s100,
                  end: AppSize.s0,
                  duration: const Duration(milliseconds: 200),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.m20,
        vertical: AppMargin.m40,
      ),
      padding: const EdgeInsets.all(AppPadding.p20),
      width: AppSize.infinity,
      height: viewModel.getLoginType == LoginType.phoneNumber
          ? AppSize.s300
          : AppSize.s360,
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
                AppStrings.loginScreenTitle.tr(),
                style: AppTextStyles.loginScreenTitleTextStyle(context),
              ),
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
          SizedBox(
            height: AppSize.s20,
            child: FittedBox(
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
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.selectionRoute);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p4),
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
          ),
        ],
      ),
    );
  }

  List<Widget> phoneNumberLoginWidgets() {
    FocusNode phoneNumberFocusNode = FocusNode();
    return [
      Expanded(
        child: Row(
          children: [
            CountryCodeInput(viewModel: viewModel),
            const SizedBox(width: AppSize.s10),
            LoginTextField(
              controller: viewModel.getPhoneNumberController,
              focusNode: phoneNumberFocusNode,
              keyboard: TextInputType.number,
              hintText: AppStrings.loginScreenPhoneNumberHint.tr(),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSize.s20),
      SizedBox(
        height: AppSize.s40,
        child: AppButton(
          text: AppStrings.loginScreenSendCode.tr(),
          onPressed: () {
            viewModel.loginWithPhoneNumber();
          },
        ),
      ),
    ];
  }

  List<Widget> emailPasswordLoginWidgets() {
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    return [
      LoginTextField(
        controller: viewModel.getEmailController,
        focusNode: emailFocusNode,
        nextFocusNode: passwordFocusNode,
        keyboard: TextInputType.emailAddress,
        hintText: AppStrings.loginScreenEmailHint.tr(),
      ),
      const SizedBox(height: AppSize.s20),
      LoginTextField(
        controller: viewModel.getPasswordController,
        focusNode: passwordFocusNode,
        keyboard: TextInputType.text,
        hintText: AppStrings.loginScreenPasswordHint.tr(),
        canObscure: true,
      ),
      const SizedBox(height: AppSize.s20),
      SizedBox(
        height: AppSize.s40,
        child: AppButton(
          text: AppStrings.loginScreenLogin.tr(),
          onPressed: () {
            viewModel.loginWithEmailAndPassword();
          },
        ),
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
            left: viewModel.getLoginType == LoginType.emailPassword
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
          ),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: itemWidth,
        decoration: BoxDecoration(
          // color: type == viewModel.getLoginType
          //     ? ColorManager.white
          //     : ColorManager.lightGrey,
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
  const CountryCodeInput({
    super.key,
    required this.viewModel,
  });

  final LoginViewModel viewModel;

  @override
  State<CountryCodeInput> createState() => _CountryCodeInputState();
}

class _CountryCodeInputState extends State<CountryCodeInput> {
  final List<String> countryCodes = [
    '---',
    '+20',
    '+966',
  ];

  late String selectedValue = countryCodes[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s80,
      height: AppSize.s40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: ColorManager.white, width: AppSize.s0_5),
      ),
      child: Center(
        child: DropdownButton(
          value: widget.viewModel.getCountryCode,
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
              widget.viewModel.setCountryCode(value!);
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

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.keyboard,
    required this.hintText,
    this.canObscure = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboard;
  final String hintText;
  final bool canObscure;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  late bool hidden = widget.canObscure;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        cursorColor: ColorManager.secondary,
        cursorRadius: const Radius.circular(AppSize.s1),
        style: AppTextStyles.loginScreenTextFieldValueTextStyle(context),
        cursorWidth: AppSize.s1,
        obscureText: hidden,
        keyboardType: widget.keyboard,
        textInputAction: widget.nextFocusNode == null
            ? TextInputAction.done
            : TextInputAction.next,
        onEditingComplete: () {
          widget.focusNode.unfocus();
          if (widget.nextFocusNode != null) {
            widget.nextFocusNode!.requestFocus();
          }
        },
        decoration: InputDecoration(
          hintStyle: AppTextStyles.loginScreenTextFieldHintTextStyle(context),
          hintText: widget.hintText,
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
