import 'package:flutter/material.dart';

class BezierCurveOne extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 400;
    final double yScaling = 0.8;
    path.lineTo(412 * xScaling, 377.135 * yScaling);
    path.cubicTo(
      365.333 * xScaling,
      389.049 * yScaling,
      330.003 * xScaling,
      446.798 * yScaling,
      270.5 * xScaling,
      445.256 * yScaling,
    );
    path.cubicTo(
      199.699 * xScaling,
      443.42 * yScaling,
      171.542 * xScaling,
      373.559 * yScaling,
      101 * xScaling,
      379.961 * yScaling,
    );
    path.cubicTo(
      67.1807 * xScaling,
      383.03 * yScaling,
      27.1445 * xScaling,
      405.209 * yScaling,
      0 * xScaling,
      422.878 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      422.878 * yScaling,
      0 * xScaling,
      -3 * yScaling,
      0 * xScaling,
      -3 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      -3 * yScaling,
      412 * xScaling,
      -3 * yScaling,
      412 * xScaling,
      -3 * yScaling,
    );
    path.cubicTo(
      412 * xScaling,
      -3 * yScaling,
      412 * xScaling,
      377.135 * yScaling,
      412 * xScaling,
      377.135 * yScaling,
    );
    path.cubicTo(
      412 * xScaling,
      377.135 * yScaling,
      412 * xScaling,
      377.135 * yScaling,
      412 * xScaling,
      377.135 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
