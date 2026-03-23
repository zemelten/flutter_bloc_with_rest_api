import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<User> login({required String email, required String password}) async {
    if (!await networkInfo.isConnected) {
      throw CacheException(message: 'No internet connection');
    }

    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await localDataSource.cacheUser(user);

      return user;
    } on ServerException catch (e) {
      throw ServerFailure(e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await localDataSource.getUser();
    return user != null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getUser();
  }
}
