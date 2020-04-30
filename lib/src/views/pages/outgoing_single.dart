import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/helpers.dart';
import 'package:webhook_manager/src/services/outgoing.dart';
import 'package:webhook_manager/src/services/validators.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/button.dart';

class OutgoingSingle extends StatelessWidget {
  final OutgoingData data;

  OutgoingSingle(this.data);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OutgoingService _service = OutgoingService();

  Future<void> _saveChanges(BuildContext context) async {
    try {
      this._formKey.currentState.save();
      final bool _isValidated = this._formKey.currentState.validate();
      if (_isValidated) {
        await this._service.update(this.data);
        Navigator.of(context).pop();
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Error saving updates!'),
        ),
      );
    }
  }

  Future<void> _deleteItem(BuildContext context) async {
    try {
      await this._service.deleteItem(this.data);
      Navigator.of(context).pop();
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Error deleting!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: this.data.eventName,
      child: Form(
        key: this._formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextInput(
                    label: 'Event Name',
                    validator: Validators.required,
                    placeholder: 'eg. build_status',
                    initialValue: this.data.eventName,
                    onSave: (value) => this.data.eventName = value,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextInput(
                    label: 'Method',
                    validator: Validators.required,
                    placeholder: 'eg. post',
                    initialValue:
                        Helpers.methodFormaterReverse(this.data.method),
                    onSave: (value) =>
                        this.data.method = Helpers.methodFormater(value),
                  ),
                ),
              ],
            ),
            TextInput(
              label: 'URL',
              validator: Validators.required,
              initialValue: this.data.url,
              placeholder: 'eg. https://api.google.com/..',
              onSave: (value) => this.data.url = value,
            ),
            TextInput(
              lines: 4,
              label: 'Headers',
              initialValue: this.data.headers,
              placeholder: 'eg. {}',
              onSave: (value) => this.data.headers = value,
            ),
            TextInput(
              lines: 4,
              label: 'Payload',
              initialValue: this.data.payload,
              placeholder: 'eg. {\n\t"build":true\n}',
              onSave: (value) => this.data.payload = value,
            ),
            SizedBox(height: 40),
            Builder(
              builder: (BuildContext context) {
                return Button(
                  label: 'Update',
                  isBlock: true,
                  onTap: () => this._saveChanges(context),
                );
              },
            ),
            Button(
              label: 'Delete',
              isBlock: true,
              isFlat: true,
              color: Colors.redAccent,
              onTap: () => this._deleteItem(context),
            ),
          ],
        ),
      ),
    );
  }
}
