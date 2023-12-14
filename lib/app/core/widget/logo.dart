import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  final double size;
  logo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/png/logo.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
