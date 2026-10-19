import 'package:flutter/material.dart';

import '../widgets/auth_listener_widget.dart';
import '../widgets/sign_up_body_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AuthListenerWidget(
          child: SignUpBodyWidget(),
        ),
      ),
    );
  }
}
