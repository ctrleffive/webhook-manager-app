import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/helpers.dart';
import 'package:webhook_manager/src/services/outgoing.dart';
import 'package:webhook_manager/src/services/validators.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/inputs.dart';

class OutgoingNew extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OutgoingService _service = OutgoingService();
  final OutgoingData _data = OutgoingData();

  Future<void> _saveChanges(BuildContext context) async {
    try {
      this._formKey.currentState.save();
      final bool _isValidated = this._formKey.currentState.validate();
      if (_isValidated) {
        await this._service.update(this._data);
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

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: 'Add Outgoing',
      noLoader: true,
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
                    onSave: (value) => this._data.eventName = value,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextInput(
                    label: 'Method',
                    validator: Validators.required,
                    placeholder: 'eg. post',
                    onSave: (value) =>
                        this._data.method = Helpers.methodFormater(value),
                  ),
                ),
              ],
            ),
            TextInput(
              label: 'URL',
              validator: Validators.required,
              placeholder: 'eg. https://api.google.com/..',
              onSave: (value) => this._data.url = value,
            ),
            TextInput(
              lines: 4,
              label: 'Heders',
              placeholder: 'eg. {}',
              onSave: (value) => this._data.headers = value,
            ),
            TextInput(
              lines: 4,
              label: 'Payload',
              placeholder: 'eg. {\n\t"build":true\n}',
              onSave: (value) => this._data.payload = value,
            ),
            SizedBox(height: 40),
            Builder(
              builder: (BuildContext context) {
                return Button(
                  label: 'Save Changes',
                  isBlock: true,
                  onTap: () => this._saveChanges(context),
                );
              },
            ),
            Button(
              label: 'Cancel',
              isBlock: true,
              isFlat: true,
              color: Colors.redAccent,
              onTap: Navigator.of(context).pop,
            ),
          ],
        ),
      ),
    );
  }
}
