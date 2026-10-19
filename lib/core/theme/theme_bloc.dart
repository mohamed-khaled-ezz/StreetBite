import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc(this._prefs)
      : super(_prefs.getBool(AppConstants.themeKey) ?? false
            ? ThemeMode.dark
            : ThemeMode.light) {
    on<ThemeToggled>((event, emit) {
      final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      _prefs.setBool(AppConstants.themeKey, next == ThemeMode.dark);
      emit(next);
    });
  }

  final SharedPreferences _prefs;
}
