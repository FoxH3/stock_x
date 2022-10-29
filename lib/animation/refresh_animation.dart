import 'dart:math';

import 'package:flutter/material.dart';

class WidgetCircularAnimator extends StatefulWidget {
  const WidgetCircularAnimator({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  WidgetAnimatorState createState() => WidgetAnimatorState();
}

class WidgetAnimatorState extends State<WidgetCircularAnimator>
    with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late AnimationController controller1;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          _firstArc(),
          _child(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  Center _child() {
    return Center(
      child: SizedBox(
        width: 200 * 0.7,
        height: 200 * 0.7,
        child: widget.child,
      ),
    );
  }

  Center _firstArc() {
    return Center(
      child: RotationTransition(
        turns: animation1,
        child: CustomPaint(
          painter: Arc1Painter(color: Colors.red, iconsSize: 3),
          child: const SizedBox(
            width: 0.85 * 200,
            height: 0.85 * 200,
          ),
        ),
      ),
    );
  }

  void initAnimations() {
    controller1 =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller1,
        curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    controller1.repeat();
  }
}

class Arc1Painter extends CustomPainter {
  Arc1Painter({required this.color, this.iconsSize = 3});

  final Color color;
  final double iconsSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // draw the two arcs
    canvas.drawArc(rect, 0.15, 0.9 * pi, false, p);
    canvas.drawArc(rect, 1.05 * pi, 0.9 * pi, false, p);

    // draw the cross
    final centerY = size.width / 2;
    canvas.drawLine(Offset(-iconsSize, centerY - iconsSize),
        Offset(iconsSize, centerY + iconsSize), p);
    canvas.drawLine(Offset(iconsSize, centerY - iconsSize),
        Offset(-iconsSize, centerY + iconsSize), p);

    // draw the circle
    canvas.drawCircle(Offset(size.width, centerY), iconsSize, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
