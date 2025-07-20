import 'package:flutter/material.dart';

class BezierCurveTwo extends CustomClipper<Path> {
  final double? height;

  BezierCurveTwo({required this.height});
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = height ?? 0.8;
    path.lineTo(412 * xScaling, 122.135 * yScaling);
    path.cubicTo(
      365.333 * xScaling,
      134.049 * yScaling,
      330.003 * xScaling,
      191.798 * yScaling,
      270.5 * xScaling,
      190.256 * yScaling,
    );
    path.cubicTo(
      199.699 * xScaling,
      188.42 * yScaling,
      171.542 * xScaling,
      118.559 * yScaling,
      101 * xScaling,
      124.961 * yScaling,
    );
    path.cubicTo(
      67.1807 * xScaling,
      128.03 * yScaling,
      27.1445 * xScaling,
      150.209 * yScaling,
      0 * xScaling,
      167.878 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      167.878 * yScaling,
      0 * xScaling,
      -506 * yScaling,
      0 * xScaling,
      -506 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      -506 * yScaling,
      412 * xScaling,
      -506 * yScaling,
      412 * xScaling,
      -506 * yScaling,
    );
    path.cubicTo(
      412 * xScaling,
      -506 * yScaling,
      412 * xScaling,
      122.135 * yScaling,
      412 * xScaling,
      122.135 * yScaling,
    );
    path.cubicTo(
      412 * xScaling,
      122.135 * yScaling,
      412 * xScaling,
      122.135 * yScaling,
      412 * xScaling,
      122.135 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
