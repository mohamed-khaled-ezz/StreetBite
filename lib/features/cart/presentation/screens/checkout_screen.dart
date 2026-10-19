import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/selectable_tile.dart';
import '../../../../core/widgets/summary_row.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/delivery_address.dart';
import '../../domain/payment/card_payment.dart';
import '../../domain/payment/cash_payment.dart';
import '../cubit/address_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _express = false;
  bool _useCard = false;
  String? _cardNumber;

  Future<void> _selectCard() async {
    final number =
        await Navigator.pushNamed<String>(context, AppRoutes.addCard);
    if (number != null) {
      setState(() {
        _cardNumber = number;
        _useCard = true;
      });
    }
  }

  void _placeOrder() {
    final uid = context.read<AuthCubit>().userId;
    final address = context.read<AddressCubit>().state;
    if (uid == null) return;
    if (address.isEmpty) {
      Navigator.pushNamed(context, AppRoutes.address);
      return;
    }
    if (_useCard && _cardNumber == null) {
      _selectCard();
      return;
    }
    // Both payment classes implement PaymentMethod (SOLID).
    final payment =
        _useCard ? CardPayment(cardNumber: _cardNumber!) : CashPayment();
    context.read<CartCubit>().placeOrder(
          userId: uid,
          payment: payment,
          address: address,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String price(double v) => l10n.priceLabel(v.toStringAsFixed(2));
    final maskedCard = _cardNumber == null
        ? null
        : '•••• ${_cardNumber!.replaceAll(' ', '').substring(12)}';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.checkout)),
      body: BlocConsumer<CartCubit, CartState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == CartStatus.placed) {
            final messenger = ScaffoldMessenger.of(context);
            Navigator.popUntil(context, (route) => route.isFirst);
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.orderPlaced),
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state.status == CartStatus.failure) {
            context.showSnack(state.failure!.localize(l10n));
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.deliveryTime,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              SelectableTile(
                title: l10n.express,
                subtitle: l10n.minutesRange('10-15'),
                selected: _express,
                onTap: () => setState(() => _express = true),
              ),
              SelectableTile(
                title: l10n.standard,
                subtitle: l10n.minutesRange('20-25'),
                selected: !_express,
                onTap: () => setState(() => _express = false),
              ),
              const SizedBox(height: 12),
              Text(l10n.deliveryAddress,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              BlocBuilder<AddressCubit, DeliveryAddress>(
                builder: (context, address) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(
                      address.isEmpty ? l10n.addAddress : address.formatted),
                  subtitle:
                      address.comment.isEmpty ? null : Text(address.comment),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.address),
                ),
              ),
              const SizedBox(height: 12),
              Text(l10n.paymentMethod,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              SelectableTile(
                title: l10n.cash,
                selected: !_useCard,
                onTap: () => setState(() => _useCard = false),
              ),
              SelectableTile(
                title: l10n.card,
                subtitle: maskedCard,
                selected: _useCard,
                onTap: _selectCard,
              ),
              const Divider(height: 32),
              SummaryRow(label: l10n.subtotal, value: price(state.subtotal)),
              SummaryRow(
                  label: l10n.deliveryFee, value: price(state.deliveryFee)),
              SummaryRow(
                  label: l10n.serviceFee, value: price(state.serviceFee)),
              SummaryRow(
                  label: l10n.total, value: price(state.total), bold: true),
              const SizedBox(height: 16),
              PrimaryButton(
                label: l10n.placeOrder,
                isLoading: state.status == CartStatus.placing,
                onPressed: state.items.isEmpty ? null : _placeOrder,
              ),
            ],
          );
        },
      ),
    );
  }
}
