import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final Function(String) validator;
  final Function(String) onSave;

  TextInput({
    Key key,
    this.label = 'Input Label',
    this.onSave,
    this.validator,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: TextFormField(
          onSaved: this.onSave,
          validator: this.validator,
          decoration: InputDecoration(
            labelText: this.label,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: StylesConstant.accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
