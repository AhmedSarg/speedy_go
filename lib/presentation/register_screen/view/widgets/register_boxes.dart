import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/register_viewmodel.dart';
import 'register_body.dart';
import 'upload_field.dart';

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
            iconPath: SVGAssets.person,
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
            iconPath: SVGAssets.person,
            validator: AppValidators.validateName,
            focusNode: lastNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    Row(
      children: [
        CountryCodeInput(viewModel: viewModel),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getPhoneNumberController,
            keyboard: TextInputType.number,
            hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
            iconPath: SVGAssets.phone,
            validator: AppValidators.validatePhoneNumber,
            focusNode: phoneNumberFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    GenderInput(viewModel: viewModel),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getEmailController,
      keyboard: TextInputType.emailAddress,
      hintText: AppStrings.registerScreenEmailHint.tr(),
      iconPath: SVGAssets.email,
      validator: AppValidators.validateEmail,
      focusNode: emailFocusNode,
      nextFocusNode: passwordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenPasswordHint.tr(),
      iconPath: SVGAssets.password,
      canObscure: true,
      validator: AppValidators.validatePassword,
      focusNode: passwordFocusNode,
      nextFocusNode: confirmPasswordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getConfirmPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenConfirmPasswordHint.tr(),
      iconPath: SVGAssets.password,
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
            viewModel.authenticate();
          }
        },
      ),
    ),
  ];
}

List<Widget> carRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nationalIdFocusNode = FocusNode();
  FocusNode carModelFocusNode = FocusNode();
  FocusNode carColorFocusNode = FocusNode();
  FocusNode carPlateFocusNode = FocusNode();
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
            iconPath: SVGAssets.person,
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
            iconPath: SVGAssets.person,
            validator: AppValidators.validateName,
            focusNode: lastNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    Row(
      children: [
        CountryCodeInput(viewModel: viewModel),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getPhoneNumberController,
            keyboard: TextInputType.number,
            hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
            iconPath: SVGAssets.phone,
            validator: AppValidators.validatePhoneNumber,
            focusNode: phoneNumberFocusNode,
            nextFocusNode: emailFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getEmailController,
      keyboard: TextInputType.emailAddress,
      hintText: AppStrings.registerScreenEmailHint.tr(),
      iconPath: SVGAssets.email,
      validator: AppValidators.validateEmail,
      focusNode: emailFocusNode,
      nextFocusNode: nationalIdFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getNationalIdController,
      keyboard: TextInputType.number,
      hintText: AppStrings.registerScreenNationalIdHint.tr(),
      iconPath: SVGAssets.id,
      validator: AppValidators.validateNationalID,
      focusNode: nationalIdFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    UploadField(
      hint: AppStrings.registerScreenDrivingLicenseHint.tr(),
      value: viewModel.getDrivingLicense?.path,
      iconPath: SVGAssets.id,
      onPressed: viewModel.chooseDrivingLicense,
    ),
    const SizedBox(height: AppSize.s20),
    Row(
      children: [
        Expanded(
          child: UploadField(
            hint: AppStrings.registerScreenCarLicenseHint.tr(),
            value: viewModel.getCarLicense?.path,
            iconPath: SVGAssets.id,
            onPressed: viewModel.chooseCarLicense,
          ),
        ),
        const SizedBox(width: AppSize.s20),
        Expanded(
          child: UploadField(
            hint: AppStrings.registerScreenCarImageHint.tr(),
            value: viewModel.getCarImage?.path,
            iconPath: SVGAssets.image,
            onPressed: viewModel.chooseCarImage,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getVehicleModelController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenCarModelHint.tr(),
      iconPath: SVGAssets.carLeadingIcon,
      validator: AppValidators.validateName,
      focusNode: carModelFocusNode,
      nextFocusNode: carColorFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getVehicleColorController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenCarColorHint.tr(),
      iconPath: SVGAssets.carLeadingIcon,
      validator: AppValidators.validateName,
      focusNode: carColorFocusNode,
      nextFocusNode: carPlateFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getVehiclePlateController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenCarPlateHint.tr(),
      iconPath: SVGAssets.id,
      validator: AppValidators.validateName,
      focusNode: carPlateFocusNode,
      nextFocusNode: passwordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenPasswordHint.tr(),
      iconPath: SVGAssets.password,
      canObscure: true,
      validator: AppValidators.validatePassword,
      focusNode: passwordFocusNode,
      nextFocusNode: confirmPasswordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getConfirmPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenConfirmPasswordHint.tr(),
      iconPath: SVGAssets.password,
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
            viewModel.authenticate();
          }
        },
      ),
    ),
  ];
}

List<Widget> tukTukRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nationalIdFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode tuktukColorFocusNode = FocusNode();
  FocusNode tuktukPlateFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  return [
    Row(
      children: [
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getFirstNameController,
            keyboard: TextInputType.text,
            hintText: AppStrings.registerScreenFirstNameHint.tr(),
            iconPath: SVGAssets.person,
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
            iconPath: SVGAssets.person,
            validator: AppValidators.validateName,
            focusNode: lastNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    Row(
      children: [
        CountryCodeInput(viewModel: viewModel),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getPhoneNumberController,
            keyboard: TextInputType.number,
            hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
            iconPath: SVGAssets.phone,
            validator: AppValidators.validatePhoneNumber,
            focusNode: phoneNumberFocusNode,
            nextFocusNode: emailFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getEmailController,
      keyboard: TextInputType.emailAddress,
      hintText: AppStrings.registerScreenEmailHint.tr(),
      iconPath: SVGAssets.email,
      validator: AppValidators.validateEmail,
      focusNode: emailFocusNode,
      nextFocusNode: nationalIdFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getNationalIdController,
      keyboard: TextInputType.number,
      hintText: AppStrings.registerScreenNationalIdHint.tr(),
      iconPath: SVGAssets.id,
      validator: AppValidators.validateNationalID,
      focusNode: nationalIdFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    UploadField(
      hint: AppStrings.registerScreenTukTukImageHint.tr(),
      value: viewModel.getTukTukImage?.path,
      iconPath: SVGAssets.image,
      onPressed: viewModel.chooseTukTukImage,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getVehicleColorController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenTukTukColorHint.tr(),
      iconPath: SVGAssets.carLeadingIcon,
      validator: AppValidators.validateName,
      focusNode: tuktukColorFocusNode,
      nextFocusNode: tuktukPlateFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getVehiclePlateController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenTukTukPlateHint.tr(),
      iconPath: SVGAssets.id,
      validator: AppValidators.validateName,
      focusNode: tuktukPlateFocusNode,
      nextFocusNode: passwordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenPasswordHint.tr(),
      iconPath: SVGAssets.password,
      canObscure: true,
      validator: AppValidators.validatePassword,
      focusNode: passwordFocusNode,
      nextFocusNode: confirmPasswordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getConfirmPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenConfirmPasswordHint.tr(),
      iconPath: SVGAssets.password,
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
            viewModel.authenticate();
          }
        },
      ),
    ),
  ];
}

List<Widget> busRegisterWidgets(BuildContext context,
    RegisterViewModel viewModel, GlobalKey<FormState> formKey) {
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nationalIdFocusNode = FocusNode();
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
            iconPath: SVGAssets.person,
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
            iconPath: SVGAssets.person,
            validator: AppValidators.validateName,
            focusNode: lastNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    Row(
      children: [
        CountryCodeInput(viewModel: viewModel),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: RegisterTextField(
            controller: viewModel.getPhoneNumberController,
            keyboard: TextInputType.number,
            hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
            iconPath: SVGAssets.phone,
            validator: AppValidators.validatePhoneNumber,
            focusNode: phoneNumberFocusNode,
            nextFocusNode: emailFocusNode,
          ),
        ),
      ],
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getEmailController,
      keyboard: TextInputType.emailAddress,
      hintText: AppStrings.registerScreenEmailHint.tr(),
      iconPath: SVGAssets.email,
      validator: AppValidators.validateEmail,
      focusNode: emailFocusNode,
      nextFocusNode: nationalIdFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getNationalIdController,
      keyboard: TextInputType.number,
      hintText: AppStrings.registerScreenNationalIdHint.tr(),
      iconPath: SVGAssets.id,
      validator: AppValidators.validateNationalID,
      focusNode: nationalIdFocusNode,
      nextFocusNode: passwordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenPasswordHint.tr(),
      iconPath: SVGAssets.password,
      canObscure: true,
      validator: AppValidators.validatePassword,
      focusNode: passwordFocusNode,
      nextFocusNode: confirmPasswordFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    RegisterTextField(
      controller: viewModel.getConfirmPasswordController,
      keyboard: TextInputType.text,
      hintText: AppStrings.registerScreenConfirmPasswordHint.tr(),
      iconPath: SVGAssets.password,
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
            viewModel.authenticate();
          }
        },
      ),
    ),
  ];
}
