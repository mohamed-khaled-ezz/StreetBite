import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._prefs)
      : super(Locale(_prefs.getString(AppConstants.localeKey) ?? 'en'));

  final SharedPreferences _prefs;

  /// Runtime EN/AR switch, remembered across restarts.
  void toggle() {
    final next = Locale(state.languageCode == 'en' ? 'ar' : 'en');
    _prefs.setString(AppConstants.localeKey, next.languageCode);
    emit(next);
  }
}
