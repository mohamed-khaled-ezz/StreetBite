import 'package:flutter/material.dart';

import '../widgets/auth_listener_widget.dart';
import '../widgets/login_body_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AuthListenerWidget(
          child: LoginBodyWidget(),
        ),
      ),
    );
  }
}
