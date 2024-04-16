import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/widgets/google_map.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/widgets/profile_screen_body.dart';


import '../../../../viewmodel/main_viewmodel.dart';
import '../profile_pages/edite_profile/view/edite_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key,});

  // final MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.topLeft,
      children: [
        ProfileScreenBody(),

      ],
    );
  }
}
