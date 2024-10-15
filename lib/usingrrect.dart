import 'package:flutter/material.dart';

class RoundedSquareClipper extends CustomClipper<Path> {
  final double radius;

  RoundedSquareClipper({this.radius = 10});

  @override
  Path getClip(Size size) {
    final path = Path();
    final cornerRadius = Radius.circular(radius);

    // Start from the top-left corner
    path.moveTo(radius, 0);

    // Top-right corner
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: cornerRadius,
      clockwise: true,
    );

    // Bottom-right corner
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: cornerRadius,
      clockwise: true,
    );

    // Bottom-left corner
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: cornerRadius,
      clockwise: true,
    );

    // Top-left corner
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: cornerRadius,
      clockwise: true,
    );

    path.close(); // Close the path to connect the last point to the starting point

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class RoundedSquareCustomClipper extends StatelessWidget {
  final double size;
  final Color color;
  final double borderRadius;

  const RoundedSquareCustomClipper({
    Key? key,
    required this.size,
    this.color = Colors.blue,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: RoundedSquareClipper(radius: borderRadius),
          child: Container(
            width: size,
            height: size,
            color: color,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RoundedSquareCustomClipper(size: 100),
  ));
}