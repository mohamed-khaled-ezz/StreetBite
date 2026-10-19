import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../cart/domain/entities/order_entity.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final heading = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w800);
    return SafeArea(
      child: BlocBuilder<OrdersCubit, List<OrderEntity>>(
        builder: (context, orders) {
          final now = DateTime.now();
          final active = orders.where((o) => o.isActive(now)).toList();
          final past = orders.where((o) => !o.isActive(now)).toList();

          Widget tile(OrderEntity order, {required bool isActive}) => OrderTile(
                order: order,
                isActive: isActive,
                onTap: () => Navigator.pushNamed(context, AppRoutes.tracking,
                    arguments: order),
              );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.orders,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              if (orders.isEmpty) Center(child: Text(l10n.ordersEmpty)),
              for (final order in active) tile(order, isActive: true),
              if (past.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(l10n.pastOrders, style: heading),
                for (final order in past) tile(order, isActive: false),
              ],
            ],
          );
        },
      ),
    );
  }
}
