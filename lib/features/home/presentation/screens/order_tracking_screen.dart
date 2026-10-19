import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/summary_row.dart';
import '../../../cart/domain/entities/order_entity.dart';

/// Order status. Progress is simulated from the time since the order was placed.
class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key, required this.order});

  final OrderEntity order;

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 20),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final order = widget.order;
    final step = order.trackingStep(DateTime.now());
    final delivered = step >= OrderEntity.stepCount;
    final labels = [
      l10n.stepReceived,
      l10n.stepCooking,
      l10n.stepCourier,
      l10n.stepDelivered,
    ];

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (!delivered)
            Text(l10n.arrivesIn('25-30'),
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w700)),
          Text(
            delivered ? l10n.stepDelivered : l10n.preparingOrder,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < labels.length; i++)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: i < step || delivered
                    ? AppColors.primary
                    : Colors.grey.shade300,
                child: Icon(
                  i < step || delivered ? Icons.check : Icons.circle,
                  size: 16,
                  color: i == step && !delivered
                      ? AppColors.primary
                      : Colors.white,
                ),
              ),
              title: Text(labels[i],
                  style: TextStyle(
                      fontWeight:
                          i == step ? FontWeight.w800 : FontWeight.w400)),
            ),
          const Divider(height: 32),
          for (final item in order.items)
            SummaryRow(
              label: '${item.quantity} × ${item.meal.name}',
              value: l10n.priceLabel(item.total.toStringAsFixed(2)),
            ),
          const Divider(height: 24),
          SummaryRow(
            label: l10n.total,
            value: l10n.priceLabel(order.total.toStringAsFixed(2)),
            bold: true,
          ),
          SummaryRow(
            label: l10n.paymentMethod,
            value: order.paymentMethod == 'card' ? l10n.card : l10n.cash,
          ),
          SummaryRow(label: l10n.address, value: order.address),
        ],
      ),
    );
  }
}
