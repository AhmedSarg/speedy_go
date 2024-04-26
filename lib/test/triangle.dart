import 'package:flutter/material.dart';

import '../domain/models/enums.dart';

class SelectionTrianglePainter extends CustomPainter {
  final UserType type;
  final bool selected;

  SelectionTrianglePainter({
    required this.type,
    required this.selected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    print('redraw1');
    print(selected);
    // final double bluntHeight =
    //     height /* * 0.19*/; // Adjust the blunt height as per your requirement
    // final double bluntOffset =
    //     width * 0; // Adjust the blunt offset as per your requirement

    final path = Path();
    // path.moveTo(0, 0); // Top left corner

    path.moveTo(0, height); // Bottom left corner

    if (selected && type == UserType.passenger) {
      print('redraw2');
      path.lineTo(0, height * 1 / 3);
      path.lineTo(width * 1 / 3, 0);
    }

    if (selected && type == UserType.driver) {
        print('redraw3');
        path.lineTo(width * 2 / 3, height);
        path.lineTo(width, height * 2 / 3);
      }

    path.lineTo(width, 0); // Top right corner

    type == UserType.driver ? path.lineTo(0, 0) : path.lineTo(width, height);

    // path.moveTo(0, height); // Top right corner
    //
    // path.lineTo(width, 0); // Bottom left corner

    // path.moveTo(100, 0);
    // path.lineTo(100, 100);
    // path.lineTo(0, 100);

    // path.lineTo(width, height);

    // path.lineTo(width, height);
    // path.lineTo(width / 2 + bluntOffset, bluntHeight); // Top blunt corner
    // path.quadraticBezierTo(
    //   0,
    //   bluntHeight,
    //   0,
    //   bluntHeight,
    // ); // Curve the tip of the triangle
    // path.lineTo(0, 0); // Top left corner
    path.close();

    final paint = Paint()..color = type == UserType.driver ? Colors.blue : Colors.red;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
