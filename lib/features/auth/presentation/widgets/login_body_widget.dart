import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'auth_footer_widget.dart';
import 'auth_text_field_widget.dart';
import 'password_field_widget.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(_email.text, _password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Align(
                      child: AppLogo(
                        size: 80,
                        background: AppColors.primary,
                        iconColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(l10n.login,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 24),
                    AuthTextFieldWidget(
                      controller: _email,
                      label: l10n.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => Validators.email(v)?.localize(l10n),
                    ),
                    const SizedBox(height: 14),
                    PasswordFieldWidget(
                      controller: _password,
                      label: l10n.password,
                      textInputAction: TextInputAction.done,
                      validator: (v) => Validators.password(v)?.localize(l10n),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: l10n.login,
                      isLoading: state is AuthLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 12),
                    AuthFooterWidget(
                      promptText: l10n.noAccountPrompt,
                      actionText: l10n.signUp,
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, AppRoutes.signUp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
