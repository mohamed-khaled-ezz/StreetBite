import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/utils/price_helper.dart';
import '../../../../core/widgets/network_meal_image.dart';
import '../../domain/entities/meal_entity.dart';

class HotOfferCard extends StatelessWidget {
  const HotOfferCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.onAdd,
  });

  final MealEntity meal;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final oldPrice = PriceHelper.priceFor(meal.id);
    final percent = (AppConstants.offerDiscount * 100).round().toString();
    return SizedBox(
      width: 160,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: NetworkMealImage(url: meal.thumbnail),
                  ),
                  PositionedDirectional(
                    top: 8,
                    start: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        l10n.discountBadge(percent),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(meal.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: l10n.priceLabel(meal.price.toStringAsFixed(2)),
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: l10n.priceLabel(oldPrice.toStringAsFixed(2)),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 11,
                        ),
                      ),
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  tooltip: l10n.addToCart,
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
