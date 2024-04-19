import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../base/base_cubit.dart';

class EditProfileViewModel extends BaseCubit
    implements EditProfileViewModelInput, EditProfileViewModelOutput {
  static EditProfileViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  void start() {}

  @override
  TextEditingController get getUserNameController => _userNameController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getPhoneController => _phoneController;

  @override
  TextEditingController get getPasswordController => _passwordController;
}

abstract class EditProfileViewModelInput {}

abstract class EditProfileViewModelOutput {
  TextEditingController get getUserNameController;

  TextEditingController get getEmailController;

  TextEditingController get getPhoneController;

  TextEditingController get getPasswordController;
}
