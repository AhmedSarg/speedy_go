import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';
import 'package:speedy_go/test/triangle.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(child: WidgetTest()),
    ),
  );
}

class WidgetTest extends StatefulWidget {
  const WidgetTest({super.key});

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  @override
  Widget build(BuildContext context) {
    Selection selection = DataIntent.getSelection();
    // Selection selection = Selection.none;
    double w = context.width();
    double h = context.height();
    String sd = 'Driver';
    String sp = 'Passenger';
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          selection == Selection.passenger
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    DataIntent.setSelection(Selection.driver);
                    print(sd);
                    setState(() {});
                  },
                  child: CustomPaint(
                    painter: SelectionTrianglePainter(
                      type: Selection.driver,
                      selected: selection == Selection.driver,
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.height() * .1,
                          horizontal: context.width() * .2,
                        ),
                        child: Text(sd),
                      ),
                    ),
                  ),
                ),
          selection == Selection.driver
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    DataIntent.setSelection(Selection.passenger);
                    print(sp);
                    setState(() {});
                  },
                  child: CustomPaint(
                    painter: SelectionTrianglePainter(
                      type: Selection.passenger,
                      selected: selection == Selection.passenger,
                    ),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.height() * .1,
                          horizontal: context.width() * .2,
                        ),
                        child: Text(sp),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

// Container(
// width: w,
// height: h,
// color: Colors.green,
// child: Stack(
// children: [
// Positioned(
// height: 500,
// width: 50,
// right: w,
// bottom: 0,
// child: OverflowBox(
// maxHeight: 90000,
// maxWidth: 50,
// child: RotationTransition(
// turns: const AlwaysStoppedAnimation(45 / 360),
// child: Container(
// width: AppSize.infinity,
// height: AppSize.infinity,
// color: Colors.red,
// child: const Icon(Icons.arrow_back),
// ),
// ),
// ),
// ),
// ],
// ),
// ),

// RotationTransition(
// turns: const AlwaysStoppedAnimation(45 / 360),
// child: Row(
// children: [
// GestureDetector(
// onTap: () {
// setState(() {
// DataIntent.setSelection(Selection.driver);
// });
// },
// child: AnimatedContainer(
// duration: const Duration(milliseconds: 300),
// width: selection == Selection.none
// ? context.width() / 2
//     : (selection == Selection.driver
// ? context.width() * .9
//     : context.width() * .1),
// alignment: Alignment.center,
// color: Colors.red,
// child: Transform.rotate(
// angle: -.5,
// child: const Text("driver"),
// ),
// ),
// ),
// GestureDetector(
// onTap: () {
// setState(() {
// DataIntent.setSelection(Selection.passenger);
// });
// },
// child: AnimatedContainer(
// duration: const Duration(milliseconds: 300),
// width: selection == Selection.none
// ? context.width()
//     : (selection == Selection.passenger
// ? context.width() * .9
//     : context.width() * .1),
// alignment: Alignment.center,
// color: Colors.blue,
// child: Transform.rotate(
// angle: -.5,
// child: const Text("passenger"),
// ),
// ),
// )
// ],
// ),
// ),
