import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'register_body.dart';

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

List<Widget> carRegisterWidgets() {
  return [
    const Text('car'),
  ];
}

List<Widget> tuktukRegisterWidgets() {
  return [
    const Text('tuktuk'),
  ];
}

List<Widget> busRegisterWidgets() {
  return [
    const Text('bus'),
  ];
}