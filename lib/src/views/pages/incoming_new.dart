import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/services/incoming.dart';
import 'package:webhook_manager/src/services/validators.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/inputs.dart';

class IncomingNew extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final IncomingService _service = IncomingService();
  final IncomingData _data = IncomingData();
  final String _hookId = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _saveChanges(BuildContext context) async {
    try {
      this._formKey.currentState.save();
      final bool _isValidated = this._formKey.currentState.validate();
      if (_isValidated) {
        this._data.hookId = this._hookId;
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
      title: 'Add Incoming',
      noLoader: true,
      child: Form(
        key: this._formKey,
        child: Column(
          children: <Widget>[
            TextInput(
              label: 'Event Name',
              validator: Validators.required,
              placeholder: 'eg. build_status',
              onSave: (value) => this._data.eventName = value,
            ),
            TextInput(
              lines: 2,
              label: 'Webhook URL',
              initialValue: '${KeysConstant.api}/hooks/${this._hookId}',
              readOnly: true,
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
