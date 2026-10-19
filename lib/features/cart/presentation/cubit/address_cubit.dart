import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/delivery_address.dart';

class AddressCubit extends Cubit<DeliveryAddress> {
  AddressCubit(this._prefs)
      : super(DeliveryAddress(
          address: _prefs.getString(AppConstants.addressKey) ?? '',
          apartment: _prefs.getString(AppConstants.apartmentKey) ?? '',
          comment: _prefs.getString(AppConstants.commentKey) ?? '',
        ));

  final SharedPreferences _prefs;

  Future<void> save(DeliveryAddress value) async {
    await _prefs.setString(AppConstants.addressKey, value.address);
    await _prefs.setString(AppConstants.apartmentKey, value.apartment);
    await _prefs.setString(AppConstants.commentKey, value.comment);
    emit(value);
  }
}
