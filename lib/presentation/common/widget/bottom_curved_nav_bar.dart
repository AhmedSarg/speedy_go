import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';




class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key,required this.pageController});

  late PageController pageController = PageController();

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with TickerProviderStateMixin {
  late double pos = 20;

  double horizontalPadding = 50;
  double horizontalMargin = 20;

  int noOfIcons = 3;

  int selected = 0;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 375));
    controller.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animation = Tween<double>(begin: getEndPosition(0), end: getEndPosition(2))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    pos = getEndPosition(0);
    super.didChangeDependencies();
  }

  List<String> icons = [
    SVGAssets.home,
    SVGAssets.busTrip,
    SVGAssets.profile,
  ];

  double getEndPosition(int index) {
    double totalMargin = 2 * horizontalMargin;
    double totalPadding = 2 * horizontalPadding;
    double valueToOmit = totalPadding + totalMargin;
    return (((MediaQuery.of(context).size.width - valueToOmit) / noOfIcons) * index + horizontalPadding) +
        ((MediaQuery.of(context).size.width - valueToOmit) / noOfIcons / 2) - 70;
  }

  void animateDrop(int index) {
    animation = Tween<double>(begin: pos, end: getEndPosition(index)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    controller.forward().then((value) {
      pos = getEndPosition(index);
      controller.dispose();
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 375));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: PathPainter(animation.value),
            size: Size(
                MediaQuery.of(context).size.width - (2 * horizontalMargin), 80),
            child: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width - (2 * horizontalMargin),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: icons.map<Widget>((icon) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          animateDrop(icons.indexOf(icon));
                          selected = icons.indexOf(icon);
                          widget.pageController.animateToPage(selected,
                              duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 575),
                        curve: Curves.easeOut,
                        height: 105,
                        width: (MediaQuery.of(context).size.width -
                                (2 * horizontalMargin) -
                                (2 * horizontalPadding)) / 3,
                        padding: const EdgeInsets.only(bottom: 17.5, top: 22.5),
                        alignment: selected == icons.indexOf(icon)
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 375),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeOut,
                              child: SvgPicture.asset(
                                icon,
                                width: 30,
                                key: ValueKey("colorName$icon"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }
}

class PathPainter extends CustomPainter {
  PathPainter(this.x);

  double x;
  double height = 80;
  double start = 40;
  double end = 120;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorManager.charcoalGrey
      ..style = PaintingStyle.fill;

    double w = size.width;

    Path path = Path();
    path.moveTo(0, start);

    path.lineTo(x < 20 ? 20 : x, start);

    path.quadraticBezierTo(20 + x, start, 30 + x, start + 30);
    path.quadraticBezierTo(40 + x, start + 55, 70 + x, start + 55);
    path.quadraticBezierTo(100 + x, start + 55, 110 + x, start + 30);
    path.quadraticBezierTo(
        120 + x, start, (140 + x) > (w - 20) ? (w - 20) : 140 + x, start);

    path.lineTo(w - 20, start);

    path.quadraticBezierTo(w, start, w, start + 25);
    path.lineTo(w, end - 25);
    path.quadraticBezierTo(w, end, w - 25, end);
    path.lineTo(25, end);
    path.quadraticBezierTo(0, end, 0, end - 25);
    path.lineTo(0, start + 25);
    path.quadraticBezierTo(0, start, 20, start);
    path.close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(70 + x, 50), 35, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
