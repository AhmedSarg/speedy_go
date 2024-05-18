import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/base/cubit_builder.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/request_history/view/request_history_body.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/request_history/viewmodel/request_history_viewmodel.dart';

import '../../../../../../../../app/sl.dart';
import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/font_manager.dart';
import '../../../../../../../resources/styles_manager.dart';
import '../../../../../../../resources/values_manager.dart';

class RequestHistoryScreen extends StatelessWidget {
  const RequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        elevation: AppSize.s0,
        title: Text(
          'Request History',
          style: getSemiBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.f20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide(
                color: ColorManager.black,
                width: AppSize.s1_2,
              ),
            ),
            backgroundColor: ColorManager.black.withOpacity(.4),
          ),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorManager.white,
            size: AppSize.s20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s0_5),
          child: Container(
            color: ColorManager.white,
            height: AppSize.s0_5,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => RequestHistoryViewModel(sl())..start(),
        child: BlocConsumer<RequestHistoryViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              const RequestHistoryBody(),
            );
          },
        ),
      ),
    );
  }
}
