import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/summary_row.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String price(double v) => l10n.priceLabel(v.toStringAsFixed(2));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.order)),
      // BlocListener: SnackBar when the cart becomes empty (not after an order).
      body: BlocListener<CartCubit, CartState>(
        listenWhen: (prev, curr) =>
            prev.items.isNotEmpty &&
            curr.items.isEmpty &&
            curr.status != CartStatus.placed,
        listener: (context, state) => context.showSnack(l10n.cartBecameEmpty),
        // BlocBuilder: items and totals rebuild reactively.
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(child: Text(l10n.emptyCart));
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(value: true, label: Text(l10n.delivery)),
                      ButtonSegment(value: false, label: Text(l10n.pickup)),
                    ],
                    selected: {state.isDelivery},
                    onSelectionChanged: (s) => context
                        .read<CartCubit>()
                        .setFulfilment(isDelivery: s.first),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for (final item in state.items)
                          CartItemTile(item: item),
                      ],
                    ),
                  ),
                  const Divider(),
                  SummaryRow(
                      label: l10n.subtotal, value: price(state.subtotal)),
                  SummaryRow(
                      label: l10n.deliveryFee, value: price(state.deliveryFee)),
                  SummaryRow(
                      label: l10n.serviceFee, value: price(state.serviceFee)),
                  SummaryRow(
                      label: l10n.total, value: price(state.total), bold: true),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: l10n.continueLabel,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.checkout),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
