// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../constant/text_styles.dart';

class Forms extends StatelessWidget {
  final TextEditingController contrroler;
  final String label;
  final String hintext;
  final TextInputType typeKeyboard;
  final bool enable;
  bool obscureText = false;
  final String suffixText;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  Forms({
    required this.contrroler,
    required this.label,
    required this.hintext,
    required this.typeKeyboard,
    required this.enable,
    this.suffixIcon,
    required this.obscureText,
    required this.suffixText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: contrroler,
        validator: validator,
        obscureText: obscureText,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: label,
            labelStyle: mLabelStyle,
            hintText: hintext,
            hintStyle: kHintTextStyle,
            suffixText: suffixText,
            suffixIcon: suffixIcon),
        style: mLabelStyle,
        keyboardType: typeKeyboard,
        enabled: enable,
      ),
    );
  }
}
