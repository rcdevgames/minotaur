import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constant/text_styles.dart';

class ButtonFill extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Color color;
  ButtonFill(
      {required this.label, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: color,
        child: Text(label, style: mBtn),
      ),
    );
  }
}
