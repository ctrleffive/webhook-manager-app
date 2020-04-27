import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

class TextInput extends StatefulWidget {
  final int lines;
  final String label;
  final String placeholder;
  final String initialValue;
  final Function(String) validator;
  final Function(String) onSave;
  final Function(String) onChange;

  TextInput({
    Key key,
    this.label = 'Input Label',
    this.lines = 1,
    this.onSave,
    this.onChange,
    this.validator,
    this.placeholder,
    this.initialValue,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (this.widget.initialValue != null) {
      this._controller.text = this.widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
        child: TextFormField(
          controller: this._controller,
          minLines: this.widget.lines,
          maxLines: this.widget.lines,
          onSaved: this.widget.onSave,
          onChanged: this.widget.onChange,
          validator: this.widget.validator,
          decoration: InputDecoration(
            labelText: this.widget.label,
            hintText: this.widget.placeholder,
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
