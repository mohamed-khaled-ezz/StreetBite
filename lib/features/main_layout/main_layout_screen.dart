import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/router/app_routes.dart';
import '../../core/utils/context_extensions.dart';
import '../auth/presentation/cubit/auth_cubit.dart';
import '../auth/presentation/cubit/auth_state.dart';
import '../favorites/presentation/cubit/favorites_cubit.dart';
import '../home/presentation/cubit/meals_cubit.dart';
import '../home/presentation/cubit/orders_cubit.dart';
import '../home/presentation/screens/browse_screen.dart';
import '../home/presentation/screens/home_screen.dart';
import '../home/presentation/screens/orders_screen.dart';
import '../profile/presentation/cubit/profile_cubit.dart';
import '../profile/presentation/screens/profile_screen.dart';

/// Bottom navigation layout: Home, Browse, Orders, Profile.
class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    final uid = context.read<AuthCubit>().userId;
    if (uid != null) {
      context.read<FavoritesCubit>().watch(uid);
      context.read<OrdersCubit>().watch(uid);
      context.read<ProfileCubit>().watch(uid);
    }
    context.read<MealsCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => curr is Unauthenticated,
      listener: (context, state) => Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (_) => false),
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: const [
            HomeScreen(),
            BrowseScreen(),
            OrdersScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: [
            NavigationDestination(
                icon: const Icon(Icons.home_outlined), label: l10n.home),
            NavigationDestination(
                icon: const Icon(Icons.search), label: l10n.browse),
            NavigationDestination(
                icon: const Icon(Icons.receipt_long_outlined),
                label: l10n.orders),
            NavigationDestination(
                icon: const Icon(Icons.person_outline), label: l10n.profile),
          ],
        ),
      ),
    );
  }
}
