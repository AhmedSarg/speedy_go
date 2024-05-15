import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../common/validators/validators.dart';
import '../../../../../register_screen/view/widgets/upload_field.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import '../../../../view/widgets/buses_logo_widget.dart';
import '../viewmodel/add_bus_viewmodel.dart';
import 'widgets/buses_item.dart';

class AddBusBody extends StatelessWidget {
  const AddBusBody({super.key});

  @override
  Widget build(BuildContext context) {
    AddBusViewModel viewModel = AddBusViewModel.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: context.height() * .1,
          ),
          const BusesLogoWidget(),
          BusesItem(
            textStyle: AppTextStyles.busesSubItemTextStyle(context),
            imageIconColor: ColorManager.white.withOpacity(.8),
            imageIcon: SVGAssets.addBus_1,
            title: AppStrings.busesAddBus.tr(),
            backgroundColor: ColorManager.lightBlue,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          AddNewBus(
            viewModel: viewModel,
          )
        ],
      ),
    );
  }
}

class AddNewBus extends StatelessWidget {
  const AddNewBus({super.key, required this.viewModel});

  final AddBusViewModel viewModel;

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final FocusNode firstNameFocusNode = FocusNode();
  static final FocusNode lastNameFocusNode = FocusNode();
  static final FocusNode phoneNumberFocusNode = FocusNode();
  static final FocusNode nationalIDFocusNode = FocusNode();
  static final FocusNode seatsNumberFocusNode = FocusNode();
  static final FocusNode busPlateFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: EdgeInsets.all(context.width() * .1),
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          color: ColorManager.lightBlack,
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: AppSize.s30,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: AppSize.s20),
            Row(
              children: [
                Expanded(
                  child: AddBusTextFormField(
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
                  child: AddBusTextFormField(
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
            AddBusTextFormField(
              controller: viewModel.getPhoneNumberController,
              keyboard: TextInputType.number,
              hintText: AppStrings.registerScreenPhoneNumberHint.tr(),
              iconPath: SVGAssets.phone,
              validator: AppValidators.validatePhoneNumber,
              focusNode: phoneNumberFocusNode,
              nextFocusNode: nationalIDFocusNode,
            ),
            const SizedBox(height: AppSize.s20),
            AddBusTextFormField(
              controller: viewModel.getNationalIDController,
              keyboard: TextInputType.number,
              hintText: AppStrings.registerScreenNationalIdHint.tr(),
              iconPath: SVGAssets.id,
              validator: AppValidators.validateNationalID,
              focusNode: nationalIDFocusNode,
            ),
            const SizedBox(height: AppSize.s20),
            Row(
              children: [
                Expanded(
                  child: UploadField(
                    hint: 'Bus License',
                    value: viewModel.getBusLicense?.path,
                    iconPath: SVGAssets.id,
                    onPressed: viewModel.chooseBusLicenseFile,
                  ),
                ),
                const SizedBox(width: AppSize.s20),
                Expanded(
                  child: UploadField(
                    hint: AppStrings.registerScreenDrivingLicenseHint.tr(),
                    value: viewModel.getDrivingLicense?.path,
                    iconPath: SVGAssets.id,
                    onPressed: viewModel.chooseDrivingLicenseFile,
                    // onPressed: viewModel.chooseCarImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            Row(
              children: [
                Expanded(
                  child: UploadField(
                    hint: 'Bus Image',
                    value: viewModel.getBusImage?.path,
                    iconPath: SVGAssets.image,
                    onPressed: viewModel.chooseBusImageFile,
                  ),
                ),
                const SizedBox(width: AppSize.s20),
                Expanded(
                  child: AddBusTextFormField(
                    controller: viewModel.getSeatsNumberController,
                    keyboard: TextInputType.number,
                    hintText: 'Seats Number',
                    iconPath: SVGAssets.seatsIcon,
                    validator: AppValidators.validateName,
                    focusNode: seatsNumberFocusNode,
                    nextFocusNode: busPlateFocusNode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            AddBusTextFormField(
              controller: viewModel.getBusPlateController,
              keyboard: TextInputType.text,
              hintText: 'Bus Plate',
              iconPath: SVGAssets.id,
              validator: AppValidators.validateName,
              focusNode: busPlateFocusNode,
            ),
            const SizedBox(height: AppSize.s20),
            SizedBox(
              height: AppSize.s40,
              width: context.width() * .5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    )),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    viewModel.addBus();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBusTextFormField extends StatefulWidget {
  const AddBusTextFormField({
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
  State<AddBusTextFormField> createState() => _AddBusTextFormFieldState();
}

class _AddBusTextFormFieldState extends State<AddBusTextFormField> {
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
