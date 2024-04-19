import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../data/network/error_handler.dart';
import '../../../../../../../base/base_cubit.dart';
import '../../../../../../../base/base_states.dart';

class SupportViewModel extends BaseCubit
    implements EditProfileViewModelInput, EditProfileViewModelOutput {
  static SupportViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> sendMessage() async {
    final userName = _userNameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (userName.isEmpty || email.isEmpty || message.isEmpty) {
      emit(ErrorState(
        failure: ErrorHandler.handle("Some fields are empty").failure,
        displayType: DisplayType.popUpDialog,
      ));
      return;
    }

    try {
      await _sendMessageToServer(userName, email, message);

      emit(LoadingState(displayType: DisplayType.popUpDialog));

    } catch (error) {
      emit(ErrorState(
        failure: ErrorHandler.handle(error).failure,
        displayType: DisplayType.popUpDialog,
      ));
    }
  }

  Future<void> _sendMessageToServer(String userName, String email, String message) async {

    await Future.delayed(const Duration(seconds: 1));

  }


  @override
  void start() {}

  @override
  TextEditingController get getUserNameController => _userNameController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getMessageController => _messageController;
}

abstract class EditProfileViewModelInput {}

abstract class EditProfileViewModelOutput {
  TextEditingController get getUserNameController;

  TextEditingController get getEmailController;

  TextEditingController get getMessageController;
}
