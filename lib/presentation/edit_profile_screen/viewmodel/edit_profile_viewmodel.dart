import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/edit_profile_screen/states/edit_profile_states.dart';

import '../../../app/functions.dart';
import '../../../app/sl.dart';
import '../../../data/network/failure.dart';
import '../../../domain/usecase/change_account_info_usecase.dart';
import '../../base/base_cubit.dart';

class EditProfileViewModel extends BaseCubit
    implements EditProfileViewModelInput, EditProfileViewModelOutput {
  static EditProfileViewModel get(context) => BlocProvider.of(context);

  final UserManager _userManager = sl<UserManager>();

  final ChangeAccountInfoUseCase _changeAccountInfoUseCase;

  EditProfileViewModel(this._changeAccountInfoUseCase);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late UserModel _userModel;

  late String _imagePath;

  bool _pictureChanged = false;

  File? _picture;

  Future<void> update() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _changeAccountInfoUseCase(
      ChangeAccountInfoUseCaseInput(
        userId: _userModel.uuid,
        firstName: _firstNameController.text.trim().isEmpty
            ? _userModel.firstName
            : _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim().isEmpty
            ? _userModel.lastName
            : _lastNameController.text.trim(),
        emailChanged: _emailController.text.trim() != _userModel.email,
        email: _emailController.text.trim().isEmpty
            ? _userModel.email
            : _emailController.text.trim(),
        phoneNumber: _userModel.phoneNumber,
        pictureChanged: _pictureChanged,
        picture: _picture,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            String successMessage = 'Profile Updated Successfully';
            if (_userModel.email != _emailController.text.trim()) {
              successMessage +=
                  '\nPlease Verify email for changes to be applied';
            }
            emit(
              SuccessState(message: successMessage),
            );
          },
        );
      },
    );
  }

  chooseNewPicture() async {
    try {
      String path = await getImagesFromGallery();
      _picture = File(path);
      _pictureChanged = true;
      emit(PictureSelectedState(image: _picture!));
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  @override
  void start() {
    _userModel = _userManager.getCurrentUserType == UserType.driver
        ? _userManager.getCurrentDriver!
        : _userManager.getCurrentPassenger!;
    _firstNameController.text = _userModel.firstName;
    _lastNameController.text = _userModel.lastName;
    _emailController.text = _userModel.email;
    _imagePath = _userModel.imagePath;
  }

  @override
  TextEditingController get getFirstNameController => _firstNameController;

  @override
  TextEditingController get getLastNameController => _lastNameController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  String get getImagePath => _imagePath;

  @override
  bool get getPictureChanged => _pictureChanged;

  @override
  File get getSelectedPicture => _picture!;
}

abstract class EditProfileViewModelInput {}

abstract class EditProfileViewModelOutput {
  TextEditingController get getFirstNameController;

  TextEditingController get getLastNameController;

  TextEditingController get getEmailController;

  String get getImagePath;

  bool get getPictureChanged;

  File get getSelectedPicture;
}
