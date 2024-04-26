import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/selection_old_screen/view/widgets/states/selection_states.dart';

import '../../base/base_cubit.dart';

class SelectionViewModel extends BaseCubit
    implements SelectionViewModelInput, SelectionViewModelOutput {
  UserType select = UserType.none;

  static SelectionViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}

  void setSelected(UserType s){
    select = s;
    emit(ChangeSelectState());
  }



}

abstract class SelectionViewModelInput {}

abstract class SelectionViewModelOutput {}
