import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString('token', user.token);
    await sharedPreferences.setString('user_id', user.id);
    await sharedPreferences.setString('user_name', user.name);
    await sharedPreferences.setString('user_email', user.email);
  }

  @override
  Future<UserModel?> getUser() async {
    final token = sharedPreferences.getString('token');
    if (token == null || token.isEmpty) {
      return null;
    }

    return UserModel(
      id: sharedPreferences.getString('user_id') ?? '',
      name: sharedPreferences.getString('user_name') ?? '',
      email: sharedPreferences.getString('user_email') ?? '',
      token: token,
    );
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove('token');
    await sharedPreferences.remove('user_id');
    await sharedPreferences.remove('user_name');
    await sharedPreferences.remove('user_email');
  }
}
