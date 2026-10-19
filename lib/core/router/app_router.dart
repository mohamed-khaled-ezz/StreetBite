import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/cart/presentation/screens/add_card_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/cart/presentation/screens/checkout_screen.dart';
import '../../features/cart/presentation/screens/delivery_address_screen.dart';
import '../../features/home/domain/entities/meal_entity.dart';
import '../../features/home/presentation/screens/meal_details_screen.dart';
import '../../features/home/presentation/screens/order_tracking_screen.dart';
import '../../features/main_layout/main_layout_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/cart/domain/entities/order_entity.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      AppRoutes.login => const LoginScreen(),
      AppRoutes.signUp => const SignUpScreen(),
      AppRoutes.main => const MainLayoutScreen(),
      // The selected meal is passed through navigation arguments.
      AppRoutes.details =>
        MealDetailsScreen(meal: settings.arguments as MealEntity),
      AppRoutes.cart => const CartScreen(),
      AppRoutes.checkout => const CheckoutScreen(),
      AppRoutes.addCard => const AddCardScreen(),
      AppRoutes.address => const DeliveryAddressScreen(),
      AppRoutes.tracking =>
        OrderTrackingScreen(order: settings.arguments as OrderEntity),
      AppRoutes.settings => const SettingsScreen(),
      _ => const SplashScreen(),
    };
    return MaterialPageRoute<dynamic>(builder: (_) => page, settings: settings);
  }
}
