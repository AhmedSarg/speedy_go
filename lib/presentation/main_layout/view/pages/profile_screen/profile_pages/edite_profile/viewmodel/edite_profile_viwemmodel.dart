import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/states/add_trip_states.dart';

import '../../../../../../../base/base_cubit.dart';

class EditeProileViewModel extends BaseCubit
    implements EditeProileViewModelInput, EditeProileViewModelOutput {
  static EditeProileViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _num = '1';
  String _selectedDate = '';

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

abstract class EditeProileViewModelInput {

}

abstract class EditeProileViewModelOutput {
  TextEditingController get getUserNameController;

  TextEditingController get getEmailController;

  TextEditingController get getPhoneController;

  TextEditingController get getPasswordController;


}
