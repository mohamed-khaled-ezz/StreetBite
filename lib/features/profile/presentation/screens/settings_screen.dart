import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/locale_cubit.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../../../../core/theme/theme_event.dart';
import '../../../../core/utils/context_extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          BlocBuilder<ThemeBloc, ThemeMode>(
            builder: (context, mode) => SwitchListTile(
              title: Text(l10n.darkMode),
              value: mode == ThemeMode.dark,
              onChanged: (_) =>
                  context.read<ThemeBloc>().add(const ThemeToggled()),
            ),
          ),
          BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) => ListTile(
              title: Text(l10n.language),
              subtitle: Text(
                  locale.languageCode == 'ar' ? l10n.arabic : l10n.english),
              trailing: const Icon(Icons.translate),
              onTap: () => context.read<LocaleCubit>().toggle(),
            ),
          ),
        ],
      ),
    );
  }
}
