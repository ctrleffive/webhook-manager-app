import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/services/incoming.dart';
import 'package:webhook_manager/src/services/validators.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/button.dart';

class IncomingSingle extends StatelessWidget {
  final IncomingData data;

  IncomingSingle(this.data);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final IncomingService _service = IncomingService();

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
            TextInput(
              label: 'Event Name',
              validator: Validators.required,
              placeholder: 'eg. build_status',
              initialValue: this.data.eventName,
              onSave: (value) => this.data.eventName = value,
            ),
            TextInput(
              lines: 2,
              label: 'Webhook URL',
              initialValue: '${KeysConstant.api}/hooks/${this.data.hookId}',
              readOnly: true,
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
