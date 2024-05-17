import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/widget/options_menu.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.transparent,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p20,
                  horizontal: context.width() * .25,
                ),
                child: SvgPicture.asset(SVGAssets.logo),
              ),
              RegisterBox(
                viewModel: viewModel,
              ),
              const SizedBox(height: AppSize.s40),
            ],
          ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      width: AppSize.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSize.s20),
        children: [
          Center(
            child: Text(
              AppStrings.registerScreenTitle.tr(),
              style: AppTextStyles.registerScreenTitleTextStyle(context),
            ),
          ),
          const SizedBox(height: AppSize.s20),
          RegisterTypeSelector(viewModel: viewModel),
          const SizedBox(height: AppSize.s20),
          ...viewModel.getBoxContent,
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
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.loginRoute,
                          ModalRoute.withName('/'),
                        );
                      },
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
            left:
                viewModel.getRegisterType == UserType.passenger ? 0 : itemWidth,
            child: Container(
              width: itemWidth,
              height: AppSize.s40,
              decoration: BoxDecoration(
                color: ColorManager.secondary,
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
            ),
          ),
          Row(
            children: [
              RegisterTypeItem(
                type: UserType.passenger,
                text: AppStrings.registerScreenSelectorPassenger.tr(),
                viewModel: viewModel,
              ),
              RegisterTypeItem(
                type: UserType.driver,
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

  final UserType type;
  final String text;
  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    double itemWidth = (context.width() - AppSize.s80) / 2;
    return GestureDetector(
      onTap: () {
        viewModel.setRegisterType = type;
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
    required this.controller,
    required this.keyboard,
    required this.hintText,
    required this.iconPath,
    required this.focusNode,
    required this.validator,
    this.nextFocusNode,
    this.canObscure = false,
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String hintText;
  final bool canObscure;
  final String iconPath;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String? Function(String? value) validator;

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  late bool hidden = widget.canObscure;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.s50,
          child: TextFormField(
            controller: widget.controller,
            cursorColor: ColorManager.secondary,
            // cursorErrorColor: ColorManager.secondary,
            cursorRadius: const Radius.circular(AppSize.s1),
            focusNode: widget.focusNode,
            textInputAction: widget.nextFocusNode != null
                ? TextInputAction.next
                : TextInputAction.done,
            validator: (value) {
              setState(() {
                errorText = widget.validator(value);
              });
              return widget.validator(value);
            },
            onEditingComplete: () {
              widget.focusNode.unfocus();
              if (widget.nextFocusNode != null) {
                widget.nextFocusNode!.requestFocus();
              }
            },
            style: AppTextStyles.registerScreenTextFieldValueTextStyle(context),
            cursorWidth: AppSize.s1,
            obscureText: hidden,
            keyboardType: widget.keyboard,
            decoration: InputDecoration(
              hintStyle:
                  AppTextStyles.registerScreenTextFieldHintTextStyle(context),
              hintText: widget.hintText,
              errorStyle: const TextStyle(
                fontSize: AppSize.s0,
                color: ColorManager.transparent,
              ),
              prefixIcon: SizedBox(
                width: AppSize.s30,
                child: SvgPicture.asset(widget.iconPath),
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
        ),
        SizedBox(
          height: errorText == null ? AppSize.s0 : AppSize.s8,
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Text(
                  errorText!,
                  style: AppTextStyles.textFieldErrorTextStyle(context),
                ),
              ),
      ],
    );
  }
}

class GenderInput extends StatefulWidget {
  const GenderInput({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

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
    return FormField(
      validator: (value) {
        if (widget.viewModel.getGender == null) {
          return AppStrings.validationsFieldRequired.tr();
        }
        return null;
      },
      initialValue: null,
      builder: (errorContext) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSize.s50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              border: Border.all(
                  color: errorContext.hasError
                      ? ColorManager.error
                      : ColorManager.white,
                  width: AppSize.s0_5),
            ),
            child: Center(
              child: DropdownButton(
                value: selectedValue,
                alignment: Alignment.centerLeft,
                icon: const Icon(CupertinoIcons.chevron_down),
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
                    // print(selectedValue);
                    widget.viewModel.setGender = value;
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                dropdownColor: ColorManager.primary,
                iconEnabledColor: ColorManager.white,
                isExpanded: true,
                isDense: true,
                style:
                    AppTextStyles.registerScreenTextFieldHintTextStyle(context),
                underline: const SizedBox(height: AppSize.s0),
              ),
            ),
          ),
          SizedBox(
            height: errorContext.errorText == null ? AppSize.s0 : AppSize.s8,
          ),
          errorContext.errorText == null
              ? const SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  child: Text(
                    errorContext.errorText!,
                    style: AppTextStyles.textFieldErrorTextStyle(context),
                  ),
                ),
        ],
      ),
    );
  }
}

class CountryCodeInput extends StatelessWidget {
  const CountryCodeInput({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (v) {
        if (viewModel.getCountryCode == viewModel.getCountryCodes[0]) {
          return AppStrings.validationsFieldRequired.tr();
        }
        return null;
      },
      initialValue: null,
      builder: (error) => Container(
        width: AppSize.s80,
        height: AppSize.s50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          border: Border.all(
            color: error.hasError ? ColorManager.error : ColorManager.white,
            width: AppSize.s0_5,
          ),
        ),
        child: OptionMenu(
          selectedValue: viewModel.getCountryCode,
          items: viewModel.getCountryCodes
              .map(
                (e) => OptionMenuItem(
                  text: e,
                  onPressed: () {
                    viewModel.setCountryCode = e;
                  },
                ),
              )
              .toList(),
          mainIcon: Icons.arrow_drop_down_outlined,
        ),
      ),
    );
  }
}
