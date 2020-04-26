import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

class TextInput extends StatelessWidget {
  final int lines;
  final String label;
  final String placeholder;
  final Function(String) validator;
  final Function(String) onSave;

  TextInput({
    Key key,
    this.label = 'Input Label',
    this.lines = 1,
    this.onSave,
    this.validator,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
        child: TextFormField(
          minLines: this.lines,
          maxLines: this.lines,
          onSaved: this.onSave,
          validator: this.validator,
          decoration: InputDecoration(
            labelText: this.label,
            hintText: this.placeholder,
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
