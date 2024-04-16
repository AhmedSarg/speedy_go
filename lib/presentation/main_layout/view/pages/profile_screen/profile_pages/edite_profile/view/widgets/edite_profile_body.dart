import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/common/validators/validators.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/profile_pages/edite_profile/viewmodel/edite_profile_viwemmodel.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../../../../../../../common/widget/main_text_field.dart';
import '../../../../../../../../login_screen/view/widgets/login_body.dart';
import '../../../../../../../../resources/color_manager.dart';
import '../../../../../../../../resources/values_manager.dart';
import '../../../../view/widgets/google_map.dart';

class EditeProfileBody extends StatelessWidget {
  const EditeProfileBody({super.key, required this.viewModel});
  final EditeProileViewModel viewModel;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static FocusNode userNameFocusNode = FocusNode();
  static FocusNode emailFocusNode = FocusNode();
  static FocusNode phoneFocusNode = FocusNode();
  static FocusNode passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GoogleMapScreenProfile(),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .08),
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .75,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppSize.s18),
                  bottomRight: Radius.circular(AppSize.s18)),
              color: ColorManager.CharredGrey),
          child: Scaffold(
            backgroundColor: ColorManager.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s18,
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .15,
                        ),
                        const Center(
                          child: CircleAvatar(
                            radius: AppSize.s50,
                            child: Icon(
                              Icons.person,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16),
                      child: Text(
                        'Username',
                        style: AppTextStyles.profileItemUpdateFieldTextStyle(
                            context, ColorManager.offwhite),
                      ),
                    ),
                    CustomTextField(
                      nextFocus: emailFocusNode,
                      focusNode: userNameFocusNode,
                      controller: viewModel.getUserNameController,
                      validator: AppValidators.validateName,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                    ),
                   const SizedBox(height: AppSize.s8,),

                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16),
                      child: Text(
                        'Email',
                        style: AppTextStyles.profileItemUpdateFieldTextStyle(
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
                    const SizedBox(height: AppSize.s8,),

                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16),
                      child: Text(
                        'Phone Number',
                        style: AppTextStyles.profileItemUpdateFieldTextStyle(
                            context, ColorManager.offwhite),
                      ),
                    ),

                    CustomTextField(
                      nextFocus: passwordFocusNode,
                      focusNode: phoneFocusNode,
                      controller: viewModel.getPhoneController,
                      validator: AppValidators.validateName,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                    ),
                    const   SizedBox(height: AppSize.s5,),

                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16),
                      child: Text(
                        'Password',
                        style: AppTextStyles.profileItemUpdateFieldTextStyle(
                            context, ColorManager.offwhite),
                      ),
                    ),

                    CustomTextField(
                      nextFocus: passwordFocusNode,
                      focusNode: passwordFocusNode,
                      controller: viewModel.getPasswordController,
                      validator: AppValidators.validateName,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: AppSize.s12,),

                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*.6,
                        child: MainButton(bgcolor: ColorManager.lightBlue,text: 'Update', onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var snackBar = SnackBar(
                              backgroundColor: ColorManager.lightBlue.withOpacity(0.75),
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,


                              content: Text(
                                'Updated Successfully',textAlign: TextAlign.center,
                                style: AppTextStyles.profileItemUpdateFieldTextStyle(context,ColorManager.white),
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
                        },),
                      ),
                    )
                    // LoginTextField(nextFocus:emailFocusNode ,focusNode: userNameFocusNode, controller: viewModel.getUserNameController, validator: AppValidators.validateName, )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
