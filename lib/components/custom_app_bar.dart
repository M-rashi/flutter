import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Curvy background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: CurvedAppBarClipper(),
            child: Container(
              height: 100,
              color: Colors.blue[800],
            ),
          ),
        ),
        // AppBar content
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "AUTO",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 24,
                  ),
                ),
                TextSpan(
                  text: "bse",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ],
    );
  }
}

// Custom Clipper for the curved background
class CurvedAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30); // Start point
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20, // Control point for curve
      size.width,
      size.height - 30, // End point
    );
    path.lineTo(size.width, 0); // Complete path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
