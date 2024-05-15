import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/common/validators/validators.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../../../../../../common/widget/main_text_field.dart';
import '../../../../../../../resources/assets_manager.dart';
import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/values_manager.dart';
import '../viewmodel/edit_profile_viewmodel.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key, required this.viewModel});

  final EditProfileViewModel viewModel;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final FocusNode firstNameFocusNode = FocusNode();
  static final FocusNode lastNameFocusNode = FocusNode();
  static final FocusNode emailFocusNode = FocusNode();
  static final FocusNode phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.CharredGrey,
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: AppSize.s30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: AppSize.s100,
                            height: AppSize.s100,
                            decoration: const BoxDecoration(
                              color: ColorManager.black,
                              shape: BoxShape.circle,
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                !viewModel.getImagePath.contains('https')
                                    ? Image.asset(
                                        ImageAssets.unknownUserImage,
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: viewModel.getImagePath,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) {
                                          return Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                AppPadding.p10,
                                              ),
                                              child: Lottie.asset(
                                                LottieAssets.loading,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                SizedBox(
                                  width: AppSize.infinity,
                                  height: AppSize.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.transparent,
                                      surfaceTintColor: ColorManager.black,
                                    ),
                                    onPressed: () {},
                                    child: const Icon(
                                      CupertinoIcons.camera,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p16),
                          child: Text(
                            'First Name',
                            style:
                                AppTextStyles.profileItemUpdateFieldTextStyle(
                                    context, ColorManager.offwhite),
                          ),
                        ),
                        CustomTextField(
                          focusNode: firstNameFocusNode,
                          nextFocus: lastNameFocusNode,
                          controller: viewModel.getFirstNameController,
                          validator: AppValidators.validateName,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: AppSize.s10),
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p16),
                          child: Text(
                            'Last Name',
                            style:
                                AppTextStyles.profileItemUpdateFieldTextStyle(
                                    context, ColorManager.offwhite),
                          ),
                        ),
                        CustomTextField(
                          focusNode: lastNameFocusNode,
                          nextFocus: emailFocusNode,
                          controller: viewModel.getLastNameController,
                          validator: AppValidators.validateName,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: AppSize.s10),
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p16),
                          child: Text(
                            'Email',
                            style:
                                AppTextStyles.profileItemUpdateFieldTextStyle(
                                    context, ColorManager.offwhite),
                          ),
                        ),
                        CustomTextField(
                          nextFocus: phoneFocusNode,
                          focusNode: emailFocusNode,
                          controller: viewModel.getEmailController,
                          validator: AppValidators.validateName,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSize.s10),
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p16),
                          child: Text(
                            'Phone Number',
                            style:
                                AppTextStyles.profileItemUpdateFieldTextStyle(
                                    context, ColorManager.offwhite),
                          ),
                        ),
                        CustomTextField(
                          focusNode: phoneFocusNode,
                          controller: viewModel.getPhoneController,
                          validator: AppValidators.validateName,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: AppSize.s30),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: MainButton(
                              bgcolor: ColorManager.lightBlue,
                              text: 'Update',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  var snackBar = SnackBar(
                                    backgroundColor: ColorManager.lightBlue
                                        .withOpacity(0.75),
                                    duration: const Duration(seconds: 3),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Updated Successfully',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles
                                          .profileItemUpdateFieldTextStyle(
                                              context, ColorManager.white),
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: snackBar.content,
                                      duration: snackBar.duration,
                                      backgroundColor: snackBar.backgroundColor,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.black, width: AppSize.s1_2),
                      shape: BoxShape.circle,
                      color: ColorManager.black.withOpacity(.4)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
