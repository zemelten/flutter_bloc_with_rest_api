import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final payload = map['data'] is Map<String, dynamic>
        ? map['data'] as Map<String, dynamic>
        : map;

    final token = _firstNonEmptyString([
      map['token'],
      payload['token'],
      payload['access_token'],
      map['access_token'],
    ]);

    return UserModel(
      id: _firstNonEmptyString([payload['id'], map['id']]),
      name: _firstNonEmptyString([payload['name'], map['name']]),
      email: _firstNonEmptyString([payload['email'], map['email']]),
      token: token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  static String _firstNonEmptyString(List<dynamic> values) {
    for (final value in values) {
      final str = value?.toString().trim() ?? '';
      if (str.isNotEmpty) {
        return str;
      }
    }
    return '';
  }
}
