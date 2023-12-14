import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constant/strings.dart';
import '../constant/text_styles.dart';

class FormOption extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final List<String> options;
  FormOption(
      {required this.title, required this.controller, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              title,
              style: mLabelStyle,
            )),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          hint: Text(
            title,
            style: mLabelStyle,
          ),
          items: options
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: mLabelStyle),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return title;
            }
            return null;
          },
          onChanged: (value) {
            controller.text = value.toString();
            //Do something when selected item is changed.
          },
          onSaved: (value) {
            controller.text = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
          ),
        )
      ],
    );
  }
}
