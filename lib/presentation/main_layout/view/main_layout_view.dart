import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppMargin.m16),
          child: Text(
            FirebaseAuth.instance.currentUser!.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}



class TripAppBar extends StatelessWidget {
  const TripAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50,
      decoration: BoxDecoration(
          color: ColorManager.transparent,
          borderRadius: BorderRadius.circular(AppSize.s10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: const CustomPaint(
        painter: MyCustomPainter(),
        child: SizedBox(
          width: AppSize.infinity,
          height: AppSize.infinity,
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  CupertinoIcons.home,
                  color: ColorManager.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppSize.s100),
                  child: Icon(
                    CupertinoIcons.bus,
                    color: ColorManager.white,
                  ),
                ),
              ),
              Expanded(
                child: Icon(
                  CupertinoIcons.person,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  const MyCustomPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.primary
      ..style = PaintingStyle.fill;

    int index = 1;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 3 * index, 0)
      ..quadraticBezierTo(size.width * (index * 2 + 1) / 6, size.height,
          size.width * (index + 1) / 3, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}