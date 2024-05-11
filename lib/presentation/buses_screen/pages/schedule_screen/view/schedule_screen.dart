import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_bus_screen/view/widgets/buses_item.dart';
import 'package:speedy_go/presentation/buses_screen/pages/schedule_screen/view/widgets/sehedule_body.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

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
