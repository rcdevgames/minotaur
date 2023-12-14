
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constant/text_styles.dart';

import 'package:temres_apps/app/modules/pendukung/provider/kecamatan_model.dart';
class FormOptionKec extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final List<KecamatanModel> options;
  final onChangedCallback;
  FormOptionKec(
      {required this.title, required this.controller, required this.options,required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
    print('form_option_cb');
    print(options.map((e) => e.nama));
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
          items: options.map((item) => DropdownMenuItem<String>(
                    value: item.nama,
                    child: Text(item.nama, style: mLabelStyle),
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
            onChangedCallback(value);
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
