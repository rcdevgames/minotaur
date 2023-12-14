import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextForm extends StatelessWidget {
  const TextForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Silahkan Masuk',
      style: TextStyle(
        color: Color(0xFF59676C),
        fontSize: 25,
        fontFamily: 'Sen',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
