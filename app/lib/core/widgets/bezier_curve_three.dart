import 'package:flutter/material.dart';

class BezierCurveThree extends CustomClipper<Path> {
  const BezierCurveThree();
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = 0.8;
    path.lineTo(412 * xScaling, 280.135 * yScaling);
    path.cubicTo(
      365.333 * xScaling,
      292.049 * yScaling,
      330.003 * xScaling,
      349.798 * yScaling,
      270.5 * xScaling,
      348.256 * yScaling,
    );
    path.cubicTo(
      199.699 * xScaling,
      346.42 * yScaling,
      171.542 * xScaling,
      276.559 * yScaling,
      101 * xScaling,
      282.961 * yScaling,
    );
    path.cubicTo(
      67.1807 * xScaling,
      286.03 * yScaling,
      27.1445 * xScaling,
      308.209 * yScaling,
      0 * xScaling,
      325.878 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      325.878 * yScaling,
      0 * xScaling,
      -348 * yScaling,
      0 * xScaling,
      -348 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      -348 * yScaling,
      412 * xScaling,
      -348 * yScaling,
      412 * xScaling,
      -348 * yScaling,
    );
    path.cubicTo(
      412 * xScaling,
      -348 * yScaling,
      412 * xScaling,
      280.135 * yScaling,
      412 * xScaling,
      280.135 * yScaling,
    );
    path.cubicTo(
      412 * xScaling,
      280.135 * yScaling,
      412 * xScaling,
      280.135 * yScaling,
      412 * xScaling,
      280.135 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
