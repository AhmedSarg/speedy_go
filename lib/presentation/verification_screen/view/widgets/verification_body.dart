import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/verification_viewmodel.dart';

class VerificationBody extends StatelessWidget {
  VerificationBody({
    super.key,
    required this.viewModel,
  });

  final VerificationViewModel viewModel;

  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s25),
              ),
              padding: const EdgeInsets.all(AppSize.s20),
              margin: const EdgeInsets.all(AppSize.s20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      AppStrings.verificationScreenTitle.tr(),
                      style:
                          AppTextStyles.registerScreenTitleTextStyle(context),
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  FormField(
                    initialValue: null,
                    validator: (_) {
                      if (viewModel.getOtpController.text.contains(' ') ||
                          viewModel.getOtpController.text.isEmpty ||
                          viewModel.getOtpController.text.length < 6 ||
                          !isNumeric(viewModel.getOtpController.text)) {
                        return AppStrings.validationsFieldRequired.tr();
                      }
                      return null;
                    },
                    builder: (formState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              VerificationTextField(
                                controller: viewModel.getOtpController,
                                position: 0,
                                focusNodes: focusNodes,
                              ),
                              const SizedBox(width: AppSize.s10),
                              VerificationTextField(
                                controller: viewModel.getOtpController,
                                position: 1,
                                focusNodes: focusNodes,
                              ),
                              const SizedBox(width: AppSize.s10),
                              VerificationTextField(
                                controller: viewModel.getOtpController,
                                position: 2,
                                focusNodes: focusNodes,
                              ),
                              const SizedBox(width: AppSize.s10),
                              VerificationTextField(
                                controller: viewModel.getOtpController,
                                position: 3,
                                focusNodes: focusNodes,
                              ),
                              const SizedBox(width: AppSize.s10),
                              VerificationTextField(
                                controller: viewModel.getOtpController,
                                position: 4,
                                focusNodes: focusNodes,
                              ),
                              const SizedBox(width: AppSize.s10),
                              VerificationTextField(
                                controller: viewModel.getOtpController,
                                position: 5,
                                focusNodes: focusNodes,
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                !formState.hasError ? AppSize.s0 : AppSize.s8,
                          ),
                          !formState.hasError
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p8),
                                  child: Text(
                                    formState.errorText!,
                                    style:
                                        AppTextStyles.textFieldErrorTextStyle(
                                            context),
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s10),
                  Text(
                    AppStrings.verificationScreenDescription.tr(),
                    style:
                        AppTextStyles.registerScreenVerifyDescriptionTextStyle(
                            context),
                  ),
                  const SizedBox(height: AppSize.s20),
                  SizedBox(
                    height: AppSize.s40,
                    child: AppButton(
                      text: AppStrings.verificationScreenButton.tr(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.verifyOtp();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationTextField extends StatefulWidget {
  const VerificationTextField({
    super.key,
    required this.controller,
    required this.position,
    required this.focusNodes,
  });

  final TextEditingController controller;
  final int position;
  final List<FocusNode> focusNodes;

  @override
  State<VerificationTextField> createState() => _VerificationTextFieldState();
}

class _VerificationTextFieldState extends State<VerificationTextField> {
  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  late final TextEditingController thisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: AppSize.s50,
        child: TextFormField(
          controller: thisController,
          textAlign: TextAlign.center,
          cursorHeight: AppSize.s0,
          focusNode: widget.focusNodes[widget.position],
          enableInteractiveSelection: false,
          textInputAction:
              widget.position < 5 ? TextInputAction.next : TextInputAction.done,
          onTap: () {
            thisController.text = ' ';
            widget.controller.text =
                replaceCharAt(widget.controller.text, widget.position, ' ');
          },
          onChanged: (v) {
            if (v != '') {
              v = v.characters.last;
              thisController.text = v;
              if (widget.controller.text.length < widget.position + 1) {
                widget.controller.text += v;
              } else {
                widget.controller.text =
                    replaceCharAt(widget.controller.text, widget.position, v);
              }
              widget.focusNodes[widget.position].unfocus();
              if (widget.position < 5) {
                widget.focusNodes[widget.position + 1].requestFocus();
              }
            } else {
              thisController.text = ' ';
              widget.focusNodes[widget.position].unfocus();
              if (widget.position > 0) {
                widget.focusNodes[widget.position - 1].requestFocus();
              }
            }
          },
          style: AppTextStyles.registerScreenTextFieldValueTextStyle(context),
          cursorWidth: AppSize.s1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorStyle: const TextStyle(
              fontSize: AppSize.s0,
              color: ColorManager.transparent,
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
          ),
        ),
      ),
    );
  }
}
