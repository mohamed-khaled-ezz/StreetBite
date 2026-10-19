import 'user_model.dart';

/// BUILDER PATTERN: constructs a [UserModel] step by step, so sign-up code
/// reads clearly and optional fields (photo) need no long constructor calls.
class UserModelBuilder {
  String _id = '';
  String _name = '';
  String _email = '';
  String? _photoBase64;

  UserModelBuilder id(String value) {
    _id = value;
    return this;
  }

  UserModelBuilder name(String value) {
    _name = value;
    return this;
  }

  UserModelBuilder email(String value) {
    _email = value;
    return this;
  }

  UserModelBuilder photoBase64(String? value) {
    _photoBase64 = value;
    return this;
  }

  UserModel build() => UserModel.internal(
        id: _id,
        name: _name,
        email: _email,
        photoBase64: _photoBase64,
      );
}
