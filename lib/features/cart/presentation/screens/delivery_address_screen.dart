import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/delivery_address.dart';
import '../cubit/address_cubit.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _address;
  late final TextEditingController _apartment;
  late final TextEditingController _comment;

  @override
  void initState() {
    super.initState();
    final saved = context.read<AddressCubit>().state;
    _address = TextEditingController(text: saved.address);
    _apartment = TextEditingController(text: saved.apartment);
    _comment = TextEditingController(text: saved.comment);
  }

  @override
  void dispose() {
    _address.dispose();
    _apartment.dispose();
    _comment.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<AddressCubit>().save(DeliveryAddress(
          address: _address.text.trim(),
          apartment: _apartment.text.trim(),
          comment: _comment.text.trim(),
        ));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.deliveryAddress)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _address,
                label: l10n.address,
                validator: (v) => Validators.required(v)?.localize(l10n),
              ),
              const SizedBox(height: 12),
              AppTextField(controller: _apartment, label: l10n.apartment),
              const SizedBox(height: 12),
              AppTextField(
                controller: _comment,
                label: l10n.comment,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              PrimaryButton(label: l10n.save, onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
