import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/buses_screen/pages/schedule_screen/view/widgets/sehedule_body.dart';
import '../../../../resources/color_manager.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SehedualBodyScreen(),
    );
  }
}
