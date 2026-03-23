import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_provider.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiProvider.loginUri,
        data: {'email': email, 'password': password, 'guest_id': 1},
      );

      final data = response.data;

      // ✅ Validate response structure
      if (data == null || data is! Map<String, dynamic>) {
        throw ServerException(
          message: 'Invalid server response',
          statusCode: response.statusCode,
        );
      }

      final user = UserModel.fromMap(data);

      if (user.token.isEmpty) {
        throw ServerException(
          message: 'Token missing from response',
          statusCode: response.statusCode,
        );
      }

      return user;
    } on DioException catch (e) {
      throw ServerException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      return 'Server took too long to respond';
    }

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      String serverMessage = 'Server error';

      if (data is Map<String, dynamic>) {
        final errors = data['errors'];
        if (errors is List && errors.isNotEmpty) {
          final firstError = errors.first;
          if (firstError is Map<String, dynamic>) {
            final nestedMessage = firstError['message'];
            if (nestedMessage is String && nestedMessage.trim().isNotEmpty) {
              return nestedMessage;
            }
          }
        }

        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          serverMessage = message;
        }
      }

      if (statusCode == 401 || statusCode == 403) {
        return 'Invalid email or password';
      }

      return '$serverMessage (${statusCode ?? 'unknown'})';
    }

    if (e.type == DioExceptionType.cancel) {
      return 'Request cancelled';
    }

    return 'Something went wrong';
  }
}
