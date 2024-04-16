import 'package:flutter/material.dart';

class CenteredSnackBar extends StatelessWidget {
  final Widget content;
  final Duration duration;
  final Color backgroundColor;

  const CenteredSnackBar({
    Key? key,
    required this.content,
    this.duration = const Duration(seconds: 3),
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: content,
      ),
    );
  }

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(),
        duration: duration,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
