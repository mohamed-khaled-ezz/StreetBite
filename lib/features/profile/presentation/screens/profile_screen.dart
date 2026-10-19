import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../cart/domain/entities/order_entity.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../../favorites/presentation/screens/favorites_screen.dart';
import '../../../home/presentation/cubit/orders_cubit.dart';
import '../../../home/presentation/widgets/order_tile.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _pickPhoto(UserEntity user) async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      imageQuality: 70,
    );
    if (file == null || !mounted) return;
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    final ok = await context
        .read<ProfileCubit>()
        .changePhoto(user, base64Encode(bytes));
    if (!mounted) return;
    context
        .showSnack(ok ? context.l10n.photoUpdated : context.l10n.errorServer);
  }

  Future<void> _signOut() async {
    context.read<FavoritesCubit>().stop();
    context.read<OrdersCubit>().stop();
    context.read<ProfileCubit>().stop();
    context.read<CartCubit>().clear();
    await context.read<AuthCubit>().signOut();
  }

  void _showInfo(String title, String body) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final auth = context.watch<AuthCubit>().state;
    if (auth is! Authenticated) return const SizedBox.shrink();
    final titleStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w800);

    return SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final stored = state.user;
          final user = UserEntity(
            id: auth.user.id,
            name: (stored?.name.isNotEmpty ?? false)
                ? stored!.name
                : auth.user.name,
            email: auth.user.email,
            photoBase64: stored?.photoBase64,
          );
          final device = state.device;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Stack(
                  children: [
                    UserAvatar(photoBase64: user.photoBase64),
                    PositionedDirectional(
                      end: 0,
                      bottom: 0,
                      child: IconButton.filled(
                        tooltip: l10n.changePhoto,
                        onPressed: () => _pickPhoto(user),
                        icon: const Icon(Icons.photo_camera, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(user.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
              ),
              Center(child: Text(user.email)),
              const SizedBox(height: 16),
              if (device != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.deviceDetails, style: titleStyle),
                        const SizedBox(height: 8),
                        Text('${l10n.deviceBrand}: ${device.brand}'),
                        Text('${l10n.deviceModel}: ${device.model}'),
                        Text('${l10n.deviceOs}: ${device.osVersion}'),
                      ],
                    ),
                  ),
                ),
              ListTile(
                leading: const Icon(Icons.tune),
                title: Text(l10n.settings),
                onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: Text(l10n.contactUs),
                onTap: () => _showInfo(l10n.contactUs, l10n.contactInfo),
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(l10n.helpCenter),
                onTap: () => _showInfo(l10n.helpCenter, l10n.helpInfo),
              ),
              const Divider(),
              Text(l10n.favourites, style: titleStyle),
              const FavoritesScreen(),
              const Divider(),
              Text(l10n.orderHistory, style: titleStyle),
              BlocBuilder<OrdersCubit, List<OrderEntity>>(
                builder: (context, orders) {
                  if (orders.isEmpty) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.ordersEmpty),
                    );
                  }
                  final now = DateTime.now();
                  return Column(
                    children: [
                      for (final order in orders)
                        OrderTile(
                          order: order,
                          isActive: order.isActive(now),
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.tracking,
                              arguments: order),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _signOut,
                icon: const Icon(Icons.logout),
                label: Text(l10n.signOut),
              ),
            ],
          );
        },
      ),
    );
  }
}
