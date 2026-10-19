import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class AuthListenerWidget extends StatelessWidget {
  const AuthListenerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          context.showSnack(state.type.localize(l10n));
        } else if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.main, (_) => false);
        }
      },
      child: child,
    );
  }
}
