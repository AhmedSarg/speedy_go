import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/drawer_widget.dart';
import 'package:speedy_go/presentation/buses_screen/viewmodel/buses_viewmodel.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../register_screen/view/widgets/upload_field.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../view/widgets/buses_item.dart';

class AddBusScreen extends StatelessWidget {
  const AddBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BusesViewModel viewModel = BusesViewModel.get(context);
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: Column(
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
          AddNewBus(viewModel: viewModel,)
        ],
      ),
      drawer: const BusesDrawer(),
    );
  }
}

class AddNewBus extends StatelessWidget {
  AddNewBus({super.key, required this.viewModel});

  final BusesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.width() * .1),
      decoration: BoxDecoration(
        color: ColorManager.lightBlack,
        borderRadius: BorderRadius.circular(AppSize.s5),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              Divider(),
              BoxAddBus(viewModel: viewModel),
            ],
          ),
        ],
      ),
    );
  }
}

class BoxAddBus extends StatelessWidget {
  BoxAddBus({super.key, required this.viewModel});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BusesViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: addBusWidgets(context, viewModel, formKey),
    );
  }
}


List<Widget> addBusWidgets(BuildContext context,
    BusesViewModel viewModel, GlobalKey<FormState> formKey) {
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode nationalIDFocusNode = FocusNode();
  FocusNode seatsNumberFocusNode = FocusNode();
  return [
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
      hintText: AppStrings.registerScreenPhoneNumberHint.tr(),///TODO: Strings
      iconPath: SVGAssets.phone,
      validator: AppValidators.validatePhoneNumber,
      focusNode: nationalIDFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    AddBusTextFormField(
      controller: viewModel.getNationalIDController,
      keyboard: TextInputType.number,
      hintText: AppStrings.registerScreenNationalIdHint.tr(),
      iconPath: SVGAssets.id,
      validator: AppValidators.validateNationalID,
      focusNode: phoneNumberFocusNode,
    ),
    const SizedBox(height: AppSize.s20),
    Row(
      children: [
        Expanded(
          child: UploadField(
            hint: AppStrings.registerScreenCarLicenseHint.tr(),
            value: viewModel.getBusLicense.path,
            iconPath: SVGAssets.id,
            onPressed: (){},
          ),
        ),
        const SizedBox(width: AppSize.s20),
        Expanded(
          child: UploadField(
            hint: AppStrings.registerScreenDrivingLicenseHint.tr(),
            value: viewModel.getDrivingLicense.path,
            iconPath: SVGAssets.image,
            onPressed: (){},
            // onPressed: viewModel.chooseCarImage,
          ),
        ),
      ],
    ),
    Row(
      children: [
        Expanded(
          child: UploadField(
            hint: AppStrings.registerScreenCarImageHint.tr(),
            value: viewModel.getBusImage.path,
            iconPath: SVGAssets.image,
            onPressed: (){},
            // onPressed: viewModel.chooseCarImage,
          ),
        ),
        const SizedBox(width: AppSize.s20),

        AddBusTextFormField(
          controller: viewModel.getSeatsNumberController,
          keyboard: TextInputType.number,
          hintText: AppStrings.registerScreenPhoneNumberHint.tr(),///TODO: Strings
          iconPath: SVGAssets.busTrip,
          validator: AppValidators.validateNotEmpty,
          focusNode: seatsNumberFocusNode,
        ),
      ],
    ),
    SizedBox(
      height: AppSize.s40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorManager.lightBlue),
        onPressed: (){},
        child: Text('Add'),
      )
    ),
  ];
}

class AddBusTextFormField extends StatefulWidget {
  const AddBusTextFormField(
      {super.key,
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
