import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/common/validators/validators.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/support/viewmodel/support_viewmodel.dart';

import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../resources/color_manager.dart';
import '../../../../../../../../resources/values_manager.dart';

class SupportBodyScreen extends StatelessWidget {
  const SupportBodyScreen({
    super.key, required this.viewModel,
  });
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController messageController = TextEditingController();
final SupportViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.CharredGrey,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSize.s20,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Container(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.black,
                                    width: AppSize.s1_2),
                                shape: BoxShape.circle,
                                color: ColorManager.black.withOpacity(.4)),
                            child: const Icon(
                              Icons.arrow_back,
                              color: ColorManager.white,
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Center(
                  child: CircleAvatar(
                    radius: AppSize.s60,
                    backgroundColor: ColorManager.cyan,
                    child: SvgPicture.asset(
                      width: AppSize.s40,
                      SVGAssets.support,
                      colorFilter: const ColorFilter.mode(
                        ColorManager.blue,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p30,
                  ),
                  child: Text(
                    'Name',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f17, ColorManager.offwhite),
                  ),
                ),
                 SupportTextField(
                   controller: viewModel.getUserNameController,

                   validator: AppValidators.validateNotEmpty,
                ),
                const SizedBox(
                  height: AppSize.s26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p30,
                  ),
                  child: Text(
                    'Email address',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f17, ColorManager.offwhite),
                  ),
                ),
                 SupportTextField(
                  controller: viewModel.getEmailController,

                  validator: AppValidators.validateNotEmpty,
                ),
                const SizedBox(
                  height: AppSize.s26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p30,
                  ),
                  child: Text(
                    'Message',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f17, ColorManager.offwhite),
                  ),
                ),
                 SupportTextField(
                  controller: viewModel.getMessageController,
                  validator: AppValidators.validateNotEmpty,
                ),
                const SizedBox(
                  height: AppSize.s26,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: MainButton(
                      text: 'Send',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.sendMessage();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SupportTextField extends StatelessWidget {
  const SupportTextField(
      {super.key,
      this.hintText,
      this.keyboardType,
      this.controller,
      this.validator});
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p40,
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: ColorManager.offwhite,
        style: AppTextStyles.profileSmallTextStyle(context,  ColorManager.lightBlack),
        keyboardType: TextInputType.text,
        validator: validator,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.offwhite, width: AppSize.s2),
          ),
          border: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.offwhite, width: AppSize.s4),
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.profileGeneralTextStyle(
            context,
            FontSize.f16,
            ColorManager.grey,
          ),
        ),
      ),
    );
  }
}
