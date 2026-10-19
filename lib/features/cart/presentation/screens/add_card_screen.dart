import 'package:flutter/material.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _name = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  final _zip = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    for (final c in [_number, _name, _expiry, _cvv, _zip]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _number.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String? required(String? v) => Validators.required(v)?.localize(l10n);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addCard)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _number,
                label: l10n.cardNumber,
                keyboardType: TextInputType.number,
                validator: (v) => Validators.cardNumber(v)?.localize(l10n),
              ),
              const SizedBox(height: 12),
              AppTextField(
                  controller: _name, label: l10n.cardName, validator: required),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                        controller: _expiry,
                        label: l10n.expiry,
                        validator: required),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppTextField(
                        controller: _cvv,
                        label: l10n.cvv,
                        keyboardType: TextInputType.number,
                        validator: required),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppTextField(
                        controller: _zip,
                        label: l10n.zip,
                        keyboardType: TextInputType.number,
                        validator: required),
                  ),
                ],
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _isDefault,
                onChanged: (v) => setState(() => _isDefault = v ?? false),
                title: Text(l10n.defaultPaymentMethod),
              ),
              const SizedBox(height: 16),
              PrimaryButton(label: l10n.continueLabel, onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
