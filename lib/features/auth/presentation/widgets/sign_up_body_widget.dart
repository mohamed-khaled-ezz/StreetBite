import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'auth_footer_widget.dart';
import 'auth_text_field_widget.dart';
import 'password_field_widget.dart';

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({super.key});

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(_name.text, _email.text, _password.text);
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
                    Text(l10n.createAccount,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 24),
                    AuthTextFieldWidget(
                      controller: _name,
                      label: l10n.fullName,
                      validator: (v) => Validators.name(v)?.localize(l10n),
                    ),
                    const SizedBox(height: 14),
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
                      validator: (v) => Validators.password(v)?.localize(l10n),
                    ),
                    const SizedBox(height: 14),
                    PasswordFieldWidget(
                      controller: _confirm,
                      label: l10n.confirmPassword,
                      textInputAction: TextInputAction.done,
                      validator: (v) =>
                          Validators.confirmPassword(v, _password.text)
                              ?.localize(l10n),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: l10n.signUp,
                      isLoading: state is AuthLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 12),
                    AuthFooterWidget(
                      promptText: l10n.haveAccountPrompt,
                      actionText: l10n.login,
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, AppRoutes.login),
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
