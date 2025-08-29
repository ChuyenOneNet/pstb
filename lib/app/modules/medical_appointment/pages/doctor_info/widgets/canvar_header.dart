import 'package:flutter/material.dart';

class CustomShapeClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var maxHeight = size.height * 0.6;
    var path = new Path();
    path.lineTo(0, maxHeight);
    var firstControlPoint = new Offset(0 - size.width * 0.05, maxHeight * 0.4);
    var firstEndPoint = new Offset(size.width * 0.5, maxHeight * 0.43);
    var secondControlPoint =
        new Offset(size.width + size.width * 0.05, maxHeight * 0.5);
    var secondEndPoint = new Offset(size.width, 0);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
