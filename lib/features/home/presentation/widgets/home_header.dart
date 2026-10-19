import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../../../../core/theme/theme_event.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../cart/domain/entities/delivery_address.dart';
import '../../../cart/presentation/cubit/address_cubit.dart';
import '../../../cart/presentation/widgets/cart_icon_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.address),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primary),
                const SizedBox(width: 4),
                Flexible(
                  child: BlocBuilder<AddressCubit, DeliveryAddress>(
                    builder: (context, address) => Text(
                      address.isEmpty ? l10n.addAddress : address.formatted,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (context, mode) => IconButton(
            tooltip: l10n.darkMode,
            onPressed: () =>
                context.read<ThemeBloc>().add(const ThemeToggled()),
            icon: Icon(mode == ThemeMode.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
          ),
        ),
        const CartIconButton(),
      ],
    );
  }
}
