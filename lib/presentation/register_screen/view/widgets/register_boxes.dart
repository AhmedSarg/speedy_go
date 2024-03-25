import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/common/validators/validators.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/register_viewmodel.dart';
import 'register_body.dart';

List<Widget> passengerRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  return [
    Row(
      children: [
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getFirstNameController,
            keyboard: TextInputType.text,
            hintText: AppStrings.registerScreenFirstNameHint.tr(),
            icon: CupertinoIcons.person,
            validator: AppValidators.validateName,
            focusNode: firstNameFocusNode,
            nextFocusNode: lastNameFocusNode,
          ),
        ),
        const SizedBox(width: AppSize.s20),
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getLastNameController,
            keyboard: TextInputType.text,
            hintText: AppStrings.registerScreenLastNameHint.tr(),
            icon: CupertinoIcons.person,
            validator: AppValidators.validateName,
            focusNode: lastNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getPhoneNumberController,
      keyboard: TextInputType.number,
      hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
      icon: CupertinoIcons.phone,
      validator: AppValidators.validatePhoneNumber,
      focusNode: phoneNumberFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    GenderInput(viewModel: viewModel),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getEmailController,
      keyboard: TextInputType.emailAddress,
      hintText: AppStrings.registerScreenEmailHint.tr(),
      icon: CupertinoIcons.envelope,
      validator: AppValidators.validateEmail,
      focusNode: emailFocusNode,
      nextFocusNode: passwordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenPasswordHint.tr(),
      icon: CupertinoIcons.lock_fill,
      canObscure: true,
      validator: AppValidators.validatePassword,
      focusNode: passwordFocusNode,
      nextFocusNode: confirmPasswordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getConfirmPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenPasswordHint.tr(),
      icon: CupertinoIcons.lock_fill,
      canObscure: true,
      validator: (v) {
        return AppValidators.validateConfirmPassword(
          v,
          viewModel.getPasswordController.text,
        );
      },
      focusNode: confirmPasswordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    SizedBox(
      height: AppSize.s40,
      child: AppButton(
        text: AppStrings.registerScreenSignUp.tr(),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('validated'),
              ),
            );
          }
        },
      ),
    ),
  ];
}

List<Widget> carRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {
  return [
    const Text('car'),
  ];
}

List<Widget> tuktukRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {
  return [
    const Text('tuktuk'),
  ];
}

List<Widget> busRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {
  return [
    const Text('bus'),
  ];
}
