import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/network_meal_image.dart';
import '../../../cart/domain/entities/order_entity.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.order,
    required this.isActive,
    required this.onTap,
  });

  final OrderEntity order;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final shortId = order.id.length > 4
        ? order.id.substring(order.id.length - 4)
        : order.id;
    final date = DateFormat.yMMMd(locale).add_jm().format(order.createdAt);
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 56,
        height: 56,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: NetworkMealImage(
            url: order.items.isEmpty ? '' : order.items.first.meal.thumbnail,
            size: 'small',
          ),
        ),
      ),
      title: Text(l10n.orderNumber(shortId),
          style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(
        isActive
            ? l10n.arrivesIn('25-30')
            : '${l10n.itemsCount(order.itemCount)} · $date',
        style: TextStyle(color: isActive ? AppColors.primary : null),
      ),
      trailing: Text(l10n.priceLabel(order.total.toStringAsFixed(2))),
    );
  }
}
