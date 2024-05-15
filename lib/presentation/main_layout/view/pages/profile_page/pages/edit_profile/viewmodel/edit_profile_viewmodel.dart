import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/domain/models/user_manager.dart';

import '../../../../../../../../app/sl.dart';
import '../../../../../../../base/base_cubit.dart';

class EditProfileViewModel extends BaseCubit
    implements EditProfileViewModelInput, EditProfileViewModelOutput {
  static EditProfileViewModel get(context) => BlocProvider.of(context);

  final UserManager _userManager = sl<UserManager>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late String _imagePath;

  @override
  void start() {
    UserModel userModel = _userManager.getCurrentUserType == UserType.driver
        ? _userManager.getCurrentDriver!
        : _userManager.getCurrentPassenger!;
    _firstNameController.text = userModel.firstName;
    _lastNameController.text = userModel.lastName;
    _emailController.text = userModel.email;
    _phoneController.text = userModel.phoneNumber;
    _imagePath = userModel.imagePath;
  }

  @override
  TextEditingController get getFirstNameController => _firstNameController;

  @override
  TextEditingController get getLastNameController => _lastNameController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getPhoneController => _phoneController;

  @override
  String get getImagePath => _imagePath;
}

abstract class EditProfileViewModelInput {}

abstract class EditProfileViewModelOutput {
  TextEditingController get getFirstNameController;

  TextEditingController get getLastNameController;

  TextEditingController get getEmailController;

  TextEditingController get getPhoneController;

  String get getImagePath;
}
