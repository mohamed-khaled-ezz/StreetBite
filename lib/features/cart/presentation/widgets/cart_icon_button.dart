import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (prev, curr) => prev.itemCount != curr.itemCount,
      builder: (context, state) {
        return IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          icon: Badge(
            isLabelVisible: state.itemCount > 0,
            label: Text('${state.itemCount}'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
        );
      },
    );
  }
}
